package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;
import uz.pdp.uzummarket.entities.Order;

import java.util.List;

public class OrderRepository implements BaseRepository<Order> {
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager = entityManagerFactory.createEntityManager();

    @Transactional
    @Override
    public void save(Order order) {
        entityManager.getTransaction().begin();
        entityManager.persist(order);
        entityManager.getTransaction().commit();
    }

    @Transactional
    @Override
    public boolean delete(Order order) {
        entityManager.getTransaction().begin();
        Order managedOrder = entityManager.find(Order.class, order.getId());
        if (managedOrder != null) {
            entityManager.remove(managedOrder);
            entityManager.getTransaction().commit();
            return true;
        }
        entityManager.getTransaction().rollback();
        return false;
    }

    @Override
    public Order get(Integer id) {
        return entityManager.find(Order.class, id);
    }

    @Override
    public List<Order> getAll() {
        return entityManager.createQuery("SELECT o FROM Order o", Order.class).getResultList();
    }

    @Transactional
    @Override
    public void update(Order order) {
        entityManager.getTransaction().begin();
        Order managedOrder = entityManager.find(Order.class, order.getId());
        if (managedOrder != null) {
            managedOrder.setId(order.getId());
            managedOrder.setDelivered(order.isDelivered());
            managedOrder.setDate(order.getDate());
            managedOrder.setPaymentType(order.getPaymentType());
            managedOrder.setUser(order.getUser());
            managedOrder.setBasket(order.getBasket());
            entityManager.getTransaction().commit();
        } else {
            entityManager.getTransaction().rollback();
        }
    }

    public List<Order> getAllOrderByUserId(int userId) {
        return entityManager.createQuery("SELECT o FROM Order o WHERE o.user.id = :userId", Order.class)
                .setParameter("userId", userId)
                .getResultList();
    }

    @Transactional
    public void updateOrderStatus(int orderId, Boolean newStatus) {
        entityManager.getTransaction().begin();
        Order order = entityManager.find(Order.class, orderId);
        if (order != null) {
            order.setDelivered(newStatus);
            entityManager.merge(order);
            entityManager.getTransaction().commit();
        } else {
            entityManager.getTransaction().rollback();
        }
    }
}
