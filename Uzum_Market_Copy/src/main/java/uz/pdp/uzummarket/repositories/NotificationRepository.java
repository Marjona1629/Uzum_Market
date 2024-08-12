package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import uz.pdp.uzummarket.entities.Notification;
import uz.pdp.uzummarket.enums.NotificationType;

import java.util.List;

public class NotificationRepository implements BaseRepository<Notification> {

    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");

    @Override
    public void save(Notification notification) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            if (notification.getId() == null) {
                entityManager.persist(notification);
            } else {
                entityManager.merge(notification);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Failed to save notification", e);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public boolean delete(Notification notification) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Notification managedNotification = entityManager.find(Notification.class, notification.getId());
            if (managedNotification != null) {
                entityManager.remove(managedNotification);
                transaction.commit();
                return true;
            }
            transaction.rollback();
            return false;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Failed to delete notification", e);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Notification get(Integer id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Notification.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Notification> getAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Notification> query = entityManager.createQuery("SELECT n FROM Notification n", Notification.class);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void update(Notification notification) {
        save(notification);  // Reuse save method which handles both persistence and merging.
    }

    public List<Notification> findByUserId(Integer userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Notification> query = entityManager.createQuery(
                    "SELECT n FROM Notification n WHERE n.toId = :userId", Notification.class
            );
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    public List<Notification> findMessagesByUserId(Integer userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Notification> query = entityManager.createQuery(
                    "SELECT n FROM Notification n WHERE n.toId = :userId AND n.type = :type", Notification.class
            );
            query.setParameter("userId", userId);
            query.setParameter("type", NotificationType.MESSAGE.name());
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    private static NotificationRepository notificationRepository;

    public static NotificationRepository getInstance() {
        if (notificationRepository == null) {
            synchronized (NotificationRepository.class) {
                if (notificationRepository == null) {
                    notificationRepository = new NotificationRepository();
                }
            }
        }
        return notificationRepository;
    }

    public long countByToIdAndIsRead(Integer userId, boolean isRead) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(n) FROM Notification n WHERE n.toId = :userId AND n.isRead = :isRead", Long.class
            );
            query.setParameter("userId", userId);
            query.setParameter("isRead", isRead);
            return query.getSingleResult();
        } finally {
            entityManager.close();
        }
    }
}