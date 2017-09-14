package com.newtouch.cloud.serviceuser.service;

import com.newtouch.cloud.serviceuser.controller.NewAppUser;
import com.newtouch.cloud.serviceuser.persistence.AppUser;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotNull;

@Validated
public interface AppUserService {

    AppUser register(NewAppUser user);

    AppUser getById(@NotNull String id);

    void activate(@NotNull String token);

    void sendActivateMail(@NotNull AppUser user);

}
