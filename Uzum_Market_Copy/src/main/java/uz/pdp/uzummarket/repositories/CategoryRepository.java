package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.util.DBConnection;

import java.util.ArrayList;
import java.util.List;

public class CategoryRepository implements BaseRepository<Category> {

    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager = entityManagerFactory.createEntityManager();


    @Override
    public void save(Category category) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(category);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    @Override
    public boolean delete(Category category) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Category existingCategory = entityManager.find(Category.class, category.getCategoryId());
            if (existingCategory != null) {
                entityManager.remove(existingCategory);
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
    public Category get(Integer id) {
        return entityManager.find(Category.class, id);
    }

    @Override
    public List<Category> getAll() {
        String jpql = "SELECT c FROM Category c";
        TypedQuery<Category> query = entityManager.createQuery(jpql, Category.class);
        return query.getResultList();
    }

    @Override
    public void update(Category category) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(category);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    public int categoryCount() {
        String jpql = "SELECT COUNT(c) FROM Category c";
        TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
        return query.getSingleResult().intValue();
    }

    public List<String> getCategoryNames() {
        String jpql = "SELECT c.categoryName FROM Category c";
        TypedQuery<String> query = entityManager.createQuery(jpql, String.class);
        return query.getResultList();
    }
}
