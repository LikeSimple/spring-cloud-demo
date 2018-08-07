package com.newtouch.cloud.servicemail;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import javax.mail.MessagingException;
import java.io.File;
import java.util.ArrayList;

@RunWith(SpringRunner.class)
@SpringBootTest
public class ServiceMailApplicationTests {

    @Autowired
    private MailService mailService;

    @Test
    public void testSimpleMail() {
        mailService.sendSimpleMail("wolfxz@21cn.com", "测试邮件", "这是一份测试邮件，用于测试邮件服务！");
    }

    @Test
    public void testAttachedMail() throws MessagingException {
        File file = new File("/Users/jimmy/Pictures/IMG_9032.jpg");
        ArrayList<File> fileArrayList = new ArrayList<>();
        fileArrayList.add(file);
        mailService.sendAttachedMail("wolfxz@21cn.com", "测试邮件", "这是一份测试邮件，用于测试邮件服务！", fileArrayList);
    }

    @Test
    public void testInlineMail() throws MessagingException {

        File file = new File("/Users/jimmy/Pictures/IMG_9032.jpg");
        String content = "<html><body><img src=\\\"cid:" + file.getName() + "\\\" ></body></html>";
        ArrayList<File> fileArrayList = new ArrayList<>();
        fileArrayList.add(file);
        mailService.sendInlineMail("wolfxz@21cn.com", "测试邮件", content, fileArrayList);
    }

}
