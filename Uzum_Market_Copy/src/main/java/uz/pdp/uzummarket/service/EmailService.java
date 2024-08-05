package uz.pdp.uzummarket.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.SneakyThrows;

import java.util.Properties;

public class EmailService {
    @SneakyThrows
    public void sendSmsToUser(String email, String text) {
        String subject = "Account Confirmation";
        String htmlContent = String.format("Please click this <a href=\"http://10.10.3.154:8080/auth?confirmation=%s\">link</a> in order to confirm your account", text);

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("lalisamarjona17@gmail.com", "fzcmookbyxjpyhbf");
            }
        };
        Session session = Session.getInstance(properties, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("lalisamarjona17@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html");

            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }

    }

    private static EmailService emailService;
    public static EmailService getInstance() {
        if (emailService == null) {
            emailService = new EmailService();
        }
        return emailService;
    }
}