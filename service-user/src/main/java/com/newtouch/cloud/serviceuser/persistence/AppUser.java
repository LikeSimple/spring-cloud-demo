package com.newtouch.cloud.serviceuser.persistence;

import com.newtouch.cloud.serviceuser.controller.NewAppUser;
import com.newtouch.cloud.serviceuser.utility.ShortUUIDGenerator;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Id;
import java.io.Serializable;
import java.util.Date;

@Data
@NoArgsConstructor
public class AppUser implements Serializable {

    private static final long serialVersionUID = 8906262667069423637L;

    @Id
    private String id;

    private String username;

    private String email;

    private String password;

    private Boolean enabled;

    private Boolean locked;

    private Date accountExpire;

    private Date credentialExpire;

    private Date createdTime;

    private Date modifiedTime;

    public AppUser(NewAppUser user) {
        this.id = ShortUUIDGenerator.generate();

        this.username = user.getUsername();
        this.email = user.getEmail();
        this.password = user.getPassword();

        this.locked = Boolean.TRUE;
        this.createdTime = new Date();
    }
}
