package com.boot.z_config.security.jwt;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.MalformedJwtException;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.SignatureException;
import io.jsonwebtoken.UnsupportedJwtException;
import io.jsonwebtoken.security.Keys;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;

import com.boot.user.dto.UserDTO;
import com.boot.user.service.UserService;
import com.boot.z_config.security.PrincipalDetails;

import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.function.Function;
import javax.crypto.SecretKey;

@Component
public class JwtTokenUtil {

    private static final Logger logger = LoggerFactory.getLogger(JwtTokenUtil.class);

    @Autowired
    private UserService userService;

    // 시크릿 키 (실제 운영 환경에서는 환경 변수나 설정 파일에서 가져와야 함)
    private String secret = "metrohouse_jwt_secret_key_should_be_longer_than_32_bytes_for_security";

    // 토큰 유효 시간 (24시간)
    private int jwtExpirationInMs = 24 * 60 * 60 * 1000;

    // 시크릿 키를 SecretKey 객체로 변환
    private SecretKey getSigningKey() {
        byte[] keyBytes = secret.getBytes(StandardCharsets.UTF_8);
        return Keys.hmacShaKeyFor(keyBytes);
    }

    // 토큰에서 사용자명 추출
    public String getUsernameFromToken(String token) {
        return getClaimFromToken(token, Claims::getSubject);
    }

    // 토큰에서 클레임 추출
    public <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) {
        final Claims claims = getAllClaimsFromToken(token);
        return claimsResolver.apply(claims);
    }

    // 토큰에서 모든 클레임 추출
    private Claims getAllClaimsFromToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            logger.error("토큰에서 클레임을 추출하는 중 오류 발생: {}", e.getMessage());
            return null;
        }
    }

    // 토큰 만료 여부 확인
    private Boolean isTokenExpired(String token) {
        try {
            final Date expiration = getClaimFromToken(token, Claims::getExpiration);
            return expiration.before(new Date());
        } catch (ExpiredJwtException e) {
            return true;
        }
    }

    // 인증 정보로부터 토큰 생성
    public String generateToken(Authentication authentication) {
        Map<String, Object> claims = new HashMap<>();
        
        if (authentication.getPrincipal() instanceof PrincipalDetails) {
            PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
            UserDTO user = principalDetails.getUser();
            
            // 필수 정보만 클레임에 추가
            claims.put("userNumber", user.getUserNumber());
            claims.put("userName", user.getUserName());
            claims.put("userAdmin", user.getUserAdmin());
        }
        
        return doGenerateToken(claims, authentication.getName());
    }

    // 토큰 생성
    private String doGenerateToken(Map<String, Object> claims, String subject) {
        Date now = new Date();
        Date expiryDate = new Date(now.getTime() + jwtExpirationInMs);
        
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(subject)
                .setIssuedAt(now)
                .setExpiration(expiryDate)
                .signWith(getSigningKey(), SignatureAlgorithm.HS512)
                .compact();
    }

    // 토큰 검증
    public Boolean validateToken(String token) {
        if (token == null) {
            return false;
        }
        
        try {
            Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .build()
                .parseClaimsJws(token);
            return !isTokenExpired(token);
        } catch (Exception ex) {
            logger.error("JWT 토큰 검증 중 오류 발생: {}", ex.getMessage());
            return false;
        }
    }
    
    // JWT 토큰에서 사용자 정보 추출
    public UserDTO getUserFromToken(String token) {
        if (token == null || !validateToken(token)) {
            return null;
        }
        
        try {
            Claims claims = getAllClaimsFromToken(token);
            if (claims == null) {
                return null;
            }
            
            String userId = claims.getSubject();
            
            // 데이터베이스에서 사용자 정보 조회
            HashMap<String, String> param = new HashMap<>();
            param.put("userId", userId);
            return userService.getUserInfo(param);
        } catch (Exception e) {
            logger.error("토큰에서 사용자 정보를 추출하는 중 오류 발생: {}", e.getMessage());
            return null;
        }
    }
}