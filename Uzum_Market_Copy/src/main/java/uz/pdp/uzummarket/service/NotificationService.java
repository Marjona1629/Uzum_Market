package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.Notification;
import uz.pdp.uzummarket.repositories.NotificationRepository;

import java.util.List;

public class NotificationService {

    private final NotificationRepository notificationRepository;

    // Constructor Injection
    public NotificationService(NotificationRepository notificationRepository) {
        this.notificationRepository = notificationRepository;
    }

    public List<Notification> getNotificationsByUserId(Integer userId) {
        try {
            List<Notification> notifications = notificationRepository.findByUserId(userId);
            notifications.forEach(notification -> {
                notification.setIsRead(true);
                notificationRepository.save(notification);
            });
            return notifications;

        } catch (Exception e) {
            throw new RuntimeException("Failed to fetch notifications for user ID: " + userId, e);
        }
    }

    public long countUnreadNotificationsByUserId(Integer userId) {
        return notificationRepository.countByToIdAndIsRead(userId, false);
    }

    public List<Notification> getMessagesByUserId(Integer userId) {
        try {
            return notificationRepository.findMessagesByUserId(userId);
        } catch (Exception e) {
            // Log error or handle it accordingly
            throw new RuntimeException("Failed to fetch messages for user ID: " + userId, e);
        }
    }
}