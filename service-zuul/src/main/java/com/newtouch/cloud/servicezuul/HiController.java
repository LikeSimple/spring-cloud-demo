package com.newtouch.cloud.servicezuul;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class HiController {

    @PreAuthorize("hasAuthority('FOO_WRITE')")
    @PostMapping
    public String writeFoo() {
        return "write foo " + UUID.randomUUID().toString();
    }

}
