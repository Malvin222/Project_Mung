package com.project_mung.security;

import com.project_mung.domain.User;
import com.project_mung.domain.UserRole;
import com.project_mung.mapper.UserMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.jsp.PageContext;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.client.registration.ClientRegistration;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.Collection;
import java.util.Map;
import java.util.stream.Collectors;

@Log4j2
@Service
@RequiredArgsConstructor
public class OAuth2UserService extends DefaultOAuth2UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;
    private final HttpServletRequest request; // HttpServletRequest로 변경

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        log.info("userRequest...");
        log.info(userRequest);

        log.info("oauth2 user...........");

        ClientRegistration clientRegistration = userRequest.getClientRegistration();
        String clientName = clientRegistration.getClientName();

        log.info("NAME:" + clientName);
        OAuth2User oAuth2User = super.loadUser(userRequest);
        Map<String, Object> paramMap = oAuth2User.getAttributes();

        String email = null;

        switch (clientName) {
            case "kakao":
                email = getKakaoEmail(paramMap);
                break;
            // 다른 OAuth2 공급자에 대한 케이스 추가 가능
        }

        return generateUser(email, paramMap);
    }

    private OAuth2User generateUser(String userEmail, Map<String, Object> params) {
        User user = userMapper.findByUserEmail(userEmail);

        // 데이터베이스에 해당 이메일을 사용자가 없다면
        if (user == null) {
            // 회원 추가 // userId는 이메일주소/패스워드는 1111
            User newUser = User.builder()
                    .userid(userEmail)
                    .userpass(passwordEncoder.encode("1111"))
                    .username("")
                    .useremail(userEmail)
                    .userphone("")
                    .useraddress("")
                    .userdetailaddress("")
                    .userpostcode("")
                    .build();
            newUser.addRole(UserRole.USER);  // USER 권한 부여
            userMapper.insertUser(newUser);

            return new OAuth2User() {
                // OAuth2User 인터페이스의 메소드를 구현
                @Override
                public Map<String, Object> getAttributes() {
                    return params;
                }

                @Override
                public Collection<? extends GrantedAuthority> getAuthorities() {
                    return Arrays.asList(new SimpleGrantedAuthority("ROLE_USER"));
                }

                @Override
                public String getName() {
                    return newUser.getUserid();
                }
            };
        } else {
            // 사용자가 이미 존재하면 해당 사용자 반환
            // 사용자 정보를 세션에 저장
            request.getSession().setAttribute("user", user);
            return new OAuth2User() {
                // OAuth2User 인터페이스의 메소드를 구현
                @Override
                public Map<String, Object> getAttributes() {
                    return params;
                }

                @Override
                public Collection<? extends GrantedAuthority> getAuthorities() {
                    return user.getRoles().stream()
                            .map(role -> new SimpleGrantedAuthority("ROLE_" + role.name()))
                            .collect(Collectors.toList());
                }

                @Override
                public String getName() {

                    return user.getUserid();
                }
            };
        }
    }


    private String getKakaoEmail(Map<String, Object> paramMap) {
        log.info("KAKAO----------");
        Object value = paramMap.get("kakao_account");
        log.info(value);
        Map<String, Object> accountMap = (Map<String, Object>) value;
        return (String) accountMap.get("email");
    }
}
