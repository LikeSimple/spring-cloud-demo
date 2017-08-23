package com.newtouch.cloud.servicefeign;

import org.springframework.stereotype.Component;

@Component
public class ScheduleServiceHiHystric implements ScheduleServiceHi {

    @Override
    public String sayHi(String name) {
        return "Hi " + name + ", sorry, error!";
    }
}
