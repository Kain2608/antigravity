package com.sportpj.sportpj.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender mailSender;

    public boolean sendEmail(String to, String subject, String body) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(body);
        message.setFrom("test@gmail.com"); // Matches the properties configured 

        try {
            mailSender.send(message);
            return true;
        } catch (Exception e) {
            System.err.println("SMTP Error: Could not send email to " + to + ". Reason: " + e.getMessage());
            return false;
        }
    }
}
