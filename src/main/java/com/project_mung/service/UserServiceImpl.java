package com.project_mung.service;

import com.project_mung.domain.User;
import com.project_mung.domain.UserRole;
import com.project_mung.mapper.UserMapper;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserMapper userMapper, PasswordEncoder passwordEncoder) {
        this.userMapper = userMapper;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    @Transactional
    public void insertUser(User user) {
        user.setUserpass(passwordEncoder.encode(user.getUserpass()));

        userMapper.insertUser(user);

        // UserRole 정보 저장
        // UserRole userRole = UserRole.USER; // Enum 상수 직접 사용자가

        // 적절한 역할(role)을 설정해야 합니다.
        // 여기서는 'USER'로 고정되어 있습니다.
        // 만약 동적으로 역할을 설정해야 한다면 다른 방식으로 처리해야 합니다.

        // userMapper.insertUserRole(userRole);


    }
    @Override
    public User getLoginInfo(String userid, String userpass) {

        return userMapper.getLoginInfo(userid,userpass);


    }

    @Override
    public void insertUserRole(UserRole userRole) {

        userMapper.insertUserRole(userRole);
    }

    @Override
    public void insertUserDelivery(User user) {
        userMapper.insertUserDelivery(user);
    }

    @Override
    public void modifyUser(User user) {
        userMapper.modifyUser(user);
    }

    @Override
    public User getUserById(String userid) {
        return userMapper.getUserById(userid);
    }
}
