package com.boot.z_config.security.jwt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class JwtAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

//    @Autowired
//    private JwtTokenCache tokenCache;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // JWT 토큰 생성
        String token = jwtTokenUtil.generateToken(authentication);

        // 사용자 정보를 캐시에 저장
//        if (authentication.getPrincipal() instanceof UserDetails) {
//            tokenCache.putUserInCache(token, (UserDetails) authentication.getPrincipal());
//        }

        // JWT 토큰을 쿠키에 저장
        Cookie jwtCookie = new Cookie("jwt_token", token);
        jwtCookie.setPath("/"); // 모든 경로에서 접근 가능
        jwtCookie.setHttpOnly(true); // JavaScript에서 접근 불가능하게 설정
        
        // 브라우저에 토큰 저장 JwtTokenUtil.java의 유효시간과 동일해야함
        jwtCookie.setMaxAge(1 * 24 * 60 * 60); // 1일 유효기간

        // HTTPS 환경에서는 Secure 플래그 추가
        if (request.isSecure()) {
            jwtCookie.setSecure(true);
        }

        response.addCookie(jwtCookie);

        // 홈 페이지로 리다이렉트
        getRedirectStrategy().sendRedirect(request, response, "/");
    }
}
