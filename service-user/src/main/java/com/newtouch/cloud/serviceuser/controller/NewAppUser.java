package com.newtouch.cloud.serviceuser.controller;

import lombok.Data;
import org.hibernate.validator.constraints.Email;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;

@Data
public class NewAppUser {

    @Pattern(regexp = "[\\w]{4,30}")
    private String username;

    @Email
    @NotNull
    private String email;

    @Pattern(regexp = "(\\w|\\p{Punct}){6,30}")
    private String password;

}
