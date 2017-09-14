package com.newtouch.cloud.serviceuser.service;

import com.newtouch.cloud.serviceuser.controller.NewAppUser;
import com.newtouch.cloud.serviceuser.persistence.AppUser;
import com.newtouch.cloud.serviceuser.persistence.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

@Service
public class AppUserServiceImpl implements AppUserService {

    private final UserMapper userMapper;

    @Autowired
    public AppUserServiceImpl(UserMapper userMapper) {

        this.userMapper = userMapper;

    }

    @Override
    public AppUser register(NewAppUser user) {

        // 创建新用户
        AppUser appUser = new AppUser(user);

        // 保存新用户（未激活）
        Assert.isTrue(1 == userMapper.insert(appUser), "");

        // TODO 发送新用户注册成功消息

        return appUser;
    }

    @Override
    public void sendActivateMail(AppUser appUser) {

        //生成激活token
        String token = generateActivateToken(appUser);

        // TODO 向用户发送激活邮件

    }

    @Override
    public void activate(String activateToken) {

        String userId = getIdByActivateToken(activateToken);

        AppUser appUser = new AppUser();
        appUser.setId(userId);
        appUser.setLocked(Boolean.FALSE);

        Assert.isTrue(1 == userMapper.updateByPrimaryKeySelective(appUser), "");
    }

    @Override
    public AppUser getById(String id) {

        return userMapper.selectByPrimaryKey(id);

    }

    private String generateActivateToken(AppUser appUser) {
        // TODO 生成激活码
        return "";
    }

    private String generateActivateMail(AppUser appUser, String activateToken) {
        // TODO 生成激活邮件
        return "";
    }

    private String getIdByActivateToken(String activateToken) {
        // TODO 通过激活码获取关联用户
        return "";
    }
}
