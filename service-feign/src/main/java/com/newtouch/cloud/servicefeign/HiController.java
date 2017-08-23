package com.newtouch.cloud.servicefeign;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HiController {

    private final ScheduleServiceHi serviceHi;

    @Autowired
    public HiController(ScheduleServiceHi serviceHi) {
        this.serviceHi = serviceHi;
    }

    @RequestMapping(value = "/hi", method = RequestMethod.GET)
    public String sayHi(@RequestParam("name") String name) {
        return serviceHi.sayHi(name);
    }

}
