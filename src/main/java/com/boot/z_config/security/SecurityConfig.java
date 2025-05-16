package com.boot.z_config.security;

import com.boot.z_config.socialLogin.CustomOAuth2UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
    
    @Autowired
    private CustomUserDetailsService userDetailsService;
    
    @Autowired
    private CustomAuthenticationSuccessHandler successHandler;
    
    @Autowired
    private CustomAuthenticationFailureHandler failureHandler;
    
    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    // 소셜 로그인 성공 시 처리 핸들러
    @Autowired
    private OAuth2AuthenticationSuccessHandler oAuth2AuthenticationSuccessHandler;

    @Bean
    public AuthenticationManager authenticationManager(HttpSecurity http) throws Exception {
        // 메서드 내에서 직접 passwordEncoder() 호출
        return http.getSharedObject(AuthenticationManagerBuilder.class)
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder)
                .and()
                .build();
    }
    
    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity, CustomOAuth2UserService customOAuth2UserService) throws Exception {
        // AuthenticationManager 설정
        AuthenticationManagerBuilder authenticationManagerBuilder = httpSecurity.getSharedObject(AuthenticationManagerBuilder.class);
        authenticationManagerBuilder
                .userDetailsService(userDetailsService)
                .passwordEncoder(passwordEncoder); // 메서드 내에서 직접 passwordEncoder() 호출
        
        AuthenticationManager authenticationManager = authenticationManagerBuilder.build();
        
        httpSecurity
                .authenticationManager(authenticationManager)
                .csrf().disable()
                .authorizeHttpRequests()
                .antMatchers("/", "/auth/**", "/resources/**", "/js/**", "/css/**", "/images/**", 
                        "/checkExistingSession", "/loginForm", "/joinForm", "/joinProc", "/mailConfirm",
                        "/oauth2/**", "/login/oauth2/**", "/oauth/naver", "/oauth/kakao")
                .permitAll() // 위의 요청들은 인증 없이 접근 허용
                .anyRequest().authenticated() // 그 외 요청은 인증 필요
                .and()
                .formLogin() // 일반 로그인 설정
                .loginPage("/loginForm") // 로그인 페이지
                .loginProcessingUrl("/login") // 로그인 form action 주소
                .usernameParameter("userId") // 아이디 파라미터 이름
                .passwordParameter("userPw") // 비밀번호 파라미터 이름
                .successHandler(successHandler) // 로그인 성공 핸들러
                .failureHandler(failureHandler) // 로그인 실패 핸들러
                .and()
                .oauth2Login() // 소셜 로그인 설정
                .loginPage("/loginForm") // 소셜 로그인 실패 시 이동할 페이지
                .userInfoEndpoint()
                .userService(customOAuth2UserService) // 소셜 로그인 사용자 정보 서비스
                .and()
                .successHandler(oAuth2AuthenticationSuccessHandler) // 소셜 로그인 성공 핸들러
                .and()
                .logout()
                .logoutSuccessUrl("/loginForm"); // 로그아웃 성공 시 이동할 페이지
        
        return httpSecurity.build();
    }
}