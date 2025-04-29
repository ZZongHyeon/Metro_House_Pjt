package com.boot.security;

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
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
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
                        "/checkExistingSession", "/loginForm", "/joinForm", "/joinProc", "/mailConfirm")
                .permitAll()
                .anyRequest()
                .authenticated()
                .and()
                .formLogin()
                .loginPage("/loginForm")
                .loginProcessingUrl("/login") // 폼의 action과 일치
                .usernameParameter("userId") // 폼의 아이디 필드명
                .passwordParameter("userPw") // 폼의 비밀번호 필드명
                .successHandler(successHandler) // 커스텀 성공 핸들러
                .failureHandler(failureHandler) // 커스텀 실패 핸들러
                .and()
                .logout()
                .logoutSuccessUrl("/loginForm");
        
        return httpSecurity.build();
    }
}