package com.newtouch.cloud.serviceribbon;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HiController {

    private HiService hiService;

    public HiController(HiService hiService) {
        this.hiService = hiService;
    }

    @RequestMapping("/hi")
    public String sayHi(@RequestParam String name) {
        return hiService.sayHi(name);
    }
}

