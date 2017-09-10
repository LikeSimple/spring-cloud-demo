package com.newtouch.cloud.serviceuser.controller;

import com.newtouch.cloud.serviceuser.persistence.AppUser;
import com.newtouch.cloud.serviceuser.service.AppUserService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/user")
public class AppUserController {

    private final AppUserService appUserService;

    public AppUserController(AppUserService appUserService) {
        this.appUserService = appUserService;
    }

    @PostMapping("/register")
    public AppUser register(NewAppUser newAppUser) {
        return appUserService.register(newAppUser);
    }

    @GetMapping("/{id}")
    public AppUser getById(@RequestParam("id") String id) {
        return appUserService.getById(id);
    }

    @PostMapping("/activate/{token}")
    public void activate(@RequestParam("token") String token) {
        appUserService.activate(token);
    }

    @PostMapping("/activate/send-mail")
    public void sendMail() {

    }
}
