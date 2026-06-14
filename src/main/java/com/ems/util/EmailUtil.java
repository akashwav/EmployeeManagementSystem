package com.ems.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    // Replace with your actual sender email and App Passwor
    private static final String FROM_EMAIL = ConfigUtil.get("EMAIL_USER");
    private static final String APP_PASSWORD = ConfigUtil.get("EMAIL_PASS");

    public static void sendWelcomeEmail(String toEmail, String empId, String tempPassword) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM_EMAIL));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            msg.setSubject("Welcome to the Team! Your Login Details");
            
            // Clean HTML payload for the email body
            String emailContent = "<div style='font-family: Arial, sans-serif; padding: 20px;'>"
                    + "<h2 style='color: #2563eb;'>Welcome Aboard!</h2>"
                    + "<p>Your employee profile has been successfully generated. Please use the following credentials to access the system:</p>"
                    + "<div style='background-color: #f3f4f6; padding: 15px; border-radius: 8px; margin: 20px 0;'>"
                    + "<p><strong>Employee ID:</strong> " + empId + "</p>"
                    + "<p><strong>Temporary Password:</strong> " + tempPassword + "</p>"
                    + "</div>"
                    + "<p><em>Note: If you ever forget your password, you can request a retrieval link from the login portal.</em></p>"
                    + "</div>";
            
            msg.setContent(emailContent, "text/html");
            Transport.send(msg);
            
            System.out.println("Success: Welcome email dispatched to " + toEmail);
            
        } catch (MessagingException e) {
            e.printStackTrace();
            System.out.println("Error: Failed to send email to " + toEmail);
        }
    }
}