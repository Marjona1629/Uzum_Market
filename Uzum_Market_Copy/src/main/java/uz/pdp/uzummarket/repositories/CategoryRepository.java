package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.repositories.BaseRepository;

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
        String sql = "SELECT category_name FROM category"; // Replace 'category_name' and 'category' with your actual column and table names
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList();
    }
    public String getCategoryName(int categoryId) {
        String sql = "SELECT category_name FROM category WHERE category_id = ?"; // Ensure 'category_id' and 'category_name' match your actual column names
        Query query = entityManager.createNativeQuery(sql);
        query.setParameter(1, categoryId); // Set the categoryId parameter

        try {
            return (String) query.getSingleResult();
        } catch (NoResultException e) {
            // Handle the case when no result is found, for example, return null or a default value
            return null;
        }
    }
}