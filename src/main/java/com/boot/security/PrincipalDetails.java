package com.boot.security;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.boot.dto.UserDTO;

public class PrincipalDetails implements UserDetails {
    
    private static final long serialVersionUID = 1L;
    
    private UserDTO user;
    
    public PrincipalDetails(UserDTO user) {
        this.user = user;
    }
    
    // 사용자의 권한 반환
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new ArrayList<>();
        
        // userAdmin 값에 따라 권한 부여 (0: 일반 사용자, 1: 관리자)
        if (user.getUserAdmin() == 1) {
            authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        } else {
            authorities.add(new SimpleGrantedAuthority("ROLE_USER"));
        }
        
        return authorities;
    }
    
    @Override
    public String getPassword() {
        return user.getUserPw();
    }
    
    @Override
    public String getUsername() {
        return user.getUserId();
    }
    
    // 계정 만료 여부 (true: 만료되지 않음)
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }
    
    // 계정 잠금 여부 (true: 잠기지 않음)
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }
    
    // 비밀번호 만료 여부 (true: 만료되지 않음)
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }
    
    // 계정 활성화 여부 (true: 활성화됨)
    @Override
    public boolean isEnabled() {
        return true;
    }
    
    // 사용자 정보 접근을 위한 getter
    public UserDTO getUser() {
        return user;
    }
}