package com.project_mung.service;

import com.project_mung.domain.User;
import com.project_mung.domain.UserRole;

import java.util.HashMap;

public interface UserService {

    void insertUser(User user);

    User getLoginInfo(String userid, String userpass);

    void insertUserRole(UserRole userRole);




}
