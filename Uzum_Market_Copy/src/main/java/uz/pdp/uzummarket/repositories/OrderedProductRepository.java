package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import uz.pdp.uzummarket.entities.OrderedProduct;

import java.util.ArrayList;
import java.util.List;

public class OrderedProductRepository implements BaseRepository<OrderedProduct> {

    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager;

    public OrderedProductRepository() {
        this.entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
    }

    @Override
    public void save(OrderedProduct orderedProduct) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(orderedProduct);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    @Override
    public boolean delete(OrderedProduct orderedProduct) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            OrderedProduct existingOrderedProduct = entityManager.find(OrderedProduct.class, orderedProduct.getId());
            if (existingOrderedProduct != null) {
                entityManager.remove(existingOrderedProduct);
                transaction.commit();
                return true;
            }
            transaction.rollback();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
        return false;
    }

    @Override
    public OrderedProduct get(Integer id) {
        return entityManager.find(OrderedProduct.class, id);
    }

    @Override
    public List<OrderedProduct> getAll() {
        String jpql = "SELECT o FROM OrderedProduct o";
        TypedQuery<OrderedProduct> query = entityManager.createQuery(jpql, OrderedProduct.class);
        return query.getResultList();
    }

    @Override
    public void update(OrderedProduct orderedProduct) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(orderedProduct);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }
}
