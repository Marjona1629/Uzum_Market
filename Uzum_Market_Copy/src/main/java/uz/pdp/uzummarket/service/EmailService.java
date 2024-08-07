package uz.pdp.uzummarket.service;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import lombok.SneakyThrows;

import java.util.Base64;
import java.util.Properties;

public class EmailService {

    @SneakyThrows
    public void sendConfirmationCode(String email, String encodedCode) {
        String decodedMessage = decodeMessage(encodedCode);
        String[] parts = decodedMessage.split(":");
        String userEmail = parts[0];
        String code = parts[1];

        String subject = "Account Confirmation";
        String htmlContent = String.format(
                "<html>" +
                        "<head>" +
                        "<style>" +
                        "body { font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f4f4f4; }" +
                        ".container { max-width: 600px; margin: 20px auto; padding: 20px; background-color: #ffffff; border-radius: 8px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); }" +
                        ".header { padding: 10px; text-align: center; background-color: #007bff; color: #ffffff; border-radius: 8px 8px 0 0; }" +
                        ".content { padding: 20px; text-align: center; }" +
                        ".footer { padding: 10px; text-align: center; font-size: 0.9em; color: #888888; }" +
                        "</style>" +
                        "</head>" +
                        "<body>" +
                        "<div class='container'>" +
                        "<div class='header'>Account Confirmation</div>" +
                        "<div class='content'>" +
                        "<p>Your confirmation code is:</p>" +
                        "<h2 style='font-size: 24px; color: #007bff;'>%s</h2>" +
                        "<p>Please enter this code to confirm your account.</p>" +
                        "</div>" +
                        "<div class='footer'>" +
                        "<p>Thank you for using our service!</p>" +
                        "</div>" +
                        "</div>" +
                        "</body>" +
                        "</html>",
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
                return new PasswordAuthentication("ozodaxonzoda05@gmail.com", "katougfdldkxqwgf");
            }
        };

        Session session = Session.getInstance(properties, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("ozodaxonzoda05@gmail.com"));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html");

            Transport.send(message);
            System.out.println("Confirmation email sent successfully to " + email);
        } catch (MessagingException e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private String decodeMessage(String encodedMessage) {
        byte[] decodedBytes = Base64.getDecoder().decode(encodedMessage);
        return new String(decodedBytes);
    }

    private static EmailService emailService;

    public static EmailService getInstance() {
        if (emailService == null) {
            emailService = new EmailService();
        }
        return emailService;
    }
}
