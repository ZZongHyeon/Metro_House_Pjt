package com.boot.z_config.security;

import com.boot.user.dto.UserDTO;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
public class OAuth2AuthenticationSuccessHandler implements AuthenticationSuccessHandler
{
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication)
            throws IOException, ServletException
    {
        // Security 인증 객체에서 PrincipalDetails 꺼냄
        PrincipalDetails principalDetails = (PrincipalDetails) authentication.getPrincipal();
        UserDTO user = principalDetails.getUser();
        //  JSP에서 사용할 세션 정보로 등록
        request.getSession().setAttribute("loginUser", user);
        // 홈으로 이동
        response.sendRedirect("/");
    }
}