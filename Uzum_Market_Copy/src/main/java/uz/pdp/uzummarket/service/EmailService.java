package uz.pdp.uzummarket.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.SneakyThrows;

import java.util.Properties;
import java.util.Random;

public class EmailService {
    @SneakyThrows
    public void sendConfirmationCode(String email, String code) {
        String subject = "Account Confirmation";
        String htmlContent = String.format(
                "Your confirmation code is: <b>%s</b>. Please enter this code to confirm your account.",
                code
        );

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.ssl.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("lalisamarjona17@gmail.com", "tltngrolxogwzvir");
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
