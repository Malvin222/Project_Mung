package com.project_mung.service;

import com.project_mung.domain.User;
import com.project_mung.domain.UserRole;

public interface UserService {

    void insertUser(User user);

    User getLoginInfo(String userid, String userpass);

    void insertUserRole(UserRole userRole);

    void insertUserDelivery(User user);

    void modifyUser(User user);

    User getUserById(String userid);
}
