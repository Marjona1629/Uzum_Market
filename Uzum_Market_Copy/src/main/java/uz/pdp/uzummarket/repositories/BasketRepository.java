package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import uz.pdp.uzummarket.entities.Basket;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static uz.pdp.uzummarket.util.DBConnection.getConnection;

public class BasketRepository implements BaseRepository<Basket> {


    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager = entityManagerFactory.createEntityManager();

    @Override
    public void save(Basket basket) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(basket);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error saving basket", e);
        }
    }

    @Override
    public boolean delete(Basket basket) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Basket existingBasket = entityManager.find(Basket.class, basket.getBasketId());
            if (existingBasket != null) {
                entityManager.remove(existingBasket);
                transaction.commit();
                return true;
            }
            transaction.rollback();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error deleting basket", e);
        }
        return false;
    }

    @Override
    public Basket get(Integer id) {
        try {
            return entityManager.find(Basket.class, id);
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public List<Basket> getAll() {
        try {
            TypedQuery<Basket> query = entityManager.createQuery("SELECT b FROM Basket b", Basket.class);
            return query.getResultList();
        } catch (NoResultException e) {
            return new ArrayList<>();
        }
    }

    @Override
    public void update(Basket basket) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(basket);
            transaction.commit();
            entityManager.close();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating basket", e);
        }
    }

    public List<Basket> getBasketListByUserId(int userId) {
        EntityTransaction transaction = entityManager.getTransaction();
        List<Basket> baskets = new ArrayList<>();
        try {
            transaction = entityManager.getTransaction();
            transaction.begin(); // Begin the transaction

            TypedQuery<Basket> query = entityManager.createQuery(
                    "SELECT b FROM Basket b WHERE b.user.id = :userId", Basket.class);
            query.setParameter("userId", userId);
            baskets = query.getResultList(); // Execute the query

            transaction.commit(); // Commit the transaction
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback(); // Rollback the transaction on error
            }
            throw new RuntimeException("Error retrieving basket list by user ID", e);
        }
        return baskets;
    }

    public int getQuantity(int userId, int productId) {
        try {
            TypedQuery<Integer> query = entityManager.createQuery(
                    "SELECT b.quantity FROM Basket b WHERE b.user.id = :userId AND b.product.id = :productId", Integer.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return 0;
        }
    }

    public int getQuantityById(int basketId) {
        try {
            TypedQuery<Integer> query = entityManager.createQuery(
                    "SELECT b.quantity FROM Basket b WHERE b.basketId = :basketId", Integer.class);
            query.setParameter("basketId", basketId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return 0;
        }
    }

    public void updateQuantity(int basketId, int quantity) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Basket basket = entityManager.find(Basket.class, basketId);
            if (basket != null) {
                basket.setQuantity(quantity);
                entityManager.merge(basket);
                transaction.commit();
            } else {
                transaction.rollback();
            }
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error updating basket quantity", e);
        }
    }

    public boolean removeProductFromBasket(int userId, int productId) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            TypedQuery<Basket> query = entityManager.createQuery(
                    "SELECT b FROM Basket b WHERE b.user.id = :userId AND b.product.id = :productId", Basket.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            Basket basket = query.getSingleResult();
            if (basket != null) {
                entityManager.remove(basket);
                transaction.commit();
                return true;
            }
            transaction.rollback();
        } catch (NoResultException e) {
            // Handle case where no basket is found
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error removing product from basket", e);
        }
        return false;
    }

    public void removeAllProducts(int userId) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            TypedQuery<Basket> query = entityManager.createQuery(
                    "DELETE FROM Basket b WHERE b.user.id = :userId", Basket.class);
            query.setParameter("userId", userId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Error removing all products from basket", e);
        }
    }

    public Integer getIdByUserIdAndProductId(int userId, int productId) {
        try {
            TypedQuery<Integer> query = entityManager.createQuery(
                    "SELECT b.basketId FROM Basket b WHERE b.user.id = :userId AND b.product.id = :productId", Integer.class);
            query.setParameter("userId", userId);
            query.setParameter("productId", productId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }


    public boolean isProductExistBasket(int userId, int productId) {
        String query = "SELECT COUNT(*) FROM baskets WHERE user_id = ? AND product_id = ?";

        try (Connection connection = getConnection();
             PreparedStatement statement = connection.prepareStatement(query)) {

            statement.setInt(1, userId);
            statement.setInt(2, productId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    int count = resultSet.getInt(1);
                    return count > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions as needed
        }

        return false;
    }
}