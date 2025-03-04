package com.megacitycab.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {

    public static void sendEmail(String toEmail, String subject, String body) {
        // Replace these with your email credentials
        final String username = "your-email@gmail.com"; // Your Gmail address
        final String password = "your-email-password";   // Your Gmail app password

        // SMTP server configuration for Gmail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com"); // Gmail SMTP host
        props.put("mail.smtp.port", "587");           // Gmail SMTP port

        // Create a session with authentication
        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {
            // Create a MimeMessage object
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username)); // Set sender email
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail)); // Set recipient email
            message.setSubject(subject); // Set email subject
            message.setText(body);       // Set email body

            // Send the email
            Transport.send(message);
            System.out.println("✅ Email sent successfully to " + toEmail);
        } catch (MessagingException e) {
            System.out.println("❌ Error sending email: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
}