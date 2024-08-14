package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import jakarta.transaction.Transactional;
import uz.pdp.uzummarket.entities.FavoriteList;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.util.DBConnection;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class FavoriteRepository implements BaseRepository<FavoriteList> {

    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager;

    public FavoriteRepository() {
        this.entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
    }

    @Override
    public void save(FavoriteList favoriteList) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(favoriteList);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    @Override
    public boolean delete(FavoriteList favoriteList) {
        EntityTransaction transaction = null;
        try {
            transaction = entityManager.getTransaction();
            if (transaction != null && !transaction.isActive()) {
                transaction.begin();
            }
            FavoriteList existingFavoriteList = entityManager.find(FavoriteList.class, favoriteList.getId());

            if (existingFavoriteList != null) {
                entityManager.remove(existingFavoriteList);
                if (transaction != null && transaction.isActive()) {
                    transaction.commit();
                }
                return true;
            } else {
                if (transaction != null && transaction.isActive()) {
                    transaction.rollback();
                }
                System.err.println("FavoriteList with ID " + favoriteList.getId() + " not found.");
            }
        } catch (RuntimeException e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Error removing favorite: " + e.getMessage());
            throw e;
        }
        return false;
    }


    @Override
    public FavoriteList get(Integer id) {
        return entityManager.find(FavoriteList.class, id);
    }

    @Override
    public List<FavoriteList> getAll() {
        String jpql = "SELECT f FROM FavoriteList f";
        TypedQuery<FavoriteList> query = entityManager.createQuery(jpql, FavoriteList.class);
        return query.getResultList();
    }

    @Override
    public void update(FavoriteList favoriteList) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(favoriteList);
            transaction.commit();
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    public List<FavoriteList> getListByUserId(int userId) {
        EntityTransaction transaction = null;
        List<FavoriteList> favoriteLists = new ArrayList<>();
        try {
            transaction = entityManager.getTransaction();
            transaction.begin();

            TypedQuery<FavoriteList> query = entityManager.createQuery(
                    "SELECT f FROM FavoriteList f WHERE f.user.id = :userId", FavoriteList.class);
            query.setParameter("userId", userId);
            favoriteLists = query.getResultList();

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error retrieving favorite list by user ID", e);
        }
        return favoriteLists;
    }

    public FavoriteList findByUserAndProductId(User user, int productId) {
        EntityManager em = null;
        try {
            em = ENTITY_MANAGER_FACTORY.createEntityManager();
            return em.createQuery(
                            "SELECT f FROM FavoriteList f WHERE f.user = :user AND f.product.id = :productId", FavoriteList.class)
                    .setParameter("user", user)
                    .setParameter("productId", productId)
                    .getSingleResult();
        } catch (NoResultException e) {
            System.err.println("No result found for user: " + user + " and productId: " + productId);
            return null;
        } catch (Exception e) {
            System.err.println("Error retrieving favorite list by user and product ID: " + e.getMessage());
            throw new RuntimeException("Error retrieving favorite list by user and product ID", e);
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
