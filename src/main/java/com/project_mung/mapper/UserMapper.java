package com.project_mung.mapper;

import com.project_mung.domain.User;
import com.project_mung.domain.UserRole;

public interface UserMapper {
    void insertUser(User user);

    User getLoginInfo(String userid, String userpass);

    User findByUserEmail(String userEmail);

    void insertUserRole(UserRole userRole);



}
