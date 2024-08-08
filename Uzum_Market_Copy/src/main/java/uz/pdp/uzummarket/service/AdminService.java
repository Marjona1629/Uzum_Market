package uz.pdp.uzummarket.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Role;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdminService {

    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("uzummarket");
    private static AdminService instance;

    private AdminService() { }

    public static synchronized AdminService getInstance() {
        if (instance == null) {
            instance = new AdminService();
        }
        return instance;
    }
    public User getAdminInfo() {
        EntityManager entityManager = null;
        User adminInfo = null;

        try {
            entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
            entityManager.getTransaction().begin();

            String query = "SELECT u FROM User u WHERE u.role = :role";
            List<User> admins = entityManager.createQuery(query, User.class)
                    .setParameter("role", Role.ADMIN)
                    .getResultList();

            if (!admins.isEmpty()) {
                adminInfo = admins.get(0);
            }

            entityManager.getTransaction().commit();
        } catch (Exception e) {
            if (entityManager != null && entityManager.getTransaction().isActive()) {
                entityManager.getTransaction().rollback();
            }
            e.printStackTrace();
        } finally {
            if (entityManager != null) {
                entityManager.close();
            }
        }

        return adminInfo;
    }

    public List<User> getSellers() {
        EntityManager entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
        List<User> sellers = new ArrayList<>();

        try {
            String jpql = "SELECT u FROM User u WHERE u.role = :role";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            query.setParameter("role", "SELLER");
            sellers = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return sellers;
    }


    public int getTotalCount(String tableName, String role) {
        EntityManager entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
        int totalCount = 0;
        String jpql = "SELECT COUNT(u) FROM " + tableName + " u" + (role != null ? " WHERE u.role = :role" : "");

        try {
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            if (role != null) {
                query.setParameter("role", role);
            }
            totalCount = query.getSingleResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return totalCount;
    }

    public int getPreviousYearCount(String tableName, String role) {
        EntityManager entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
        int previousYearCount = 0;
        String jpql = "SELECT COUNT(u) FROM " + tableName + " u WHERE u.dateTime >= :oneYearAgo" +
                (role != null ? " AND u.role = :role" : "");

        try {
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("oneYearAgo", java.time.LocalDateTime.now().minusYears(1));
            if (role != null) {
                query.setParameter("role", role);
            }
            previousYearCount = query.getSingleResult().intValue();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return previousYearCount;
    }

    public double calculatePercentageChange(int totalCount, int previousYearCount) {
        if (previousYearCount == 0) {
            return 0.0;
        }
        return ((double)(totalCount - previousYearCount) / previousYearCount) * 100;
    }

    public int getTotalCustomers() {
        return getTotalCount("User", "CUSTOMER");
    }

    public int getPreviousYearCustomers() {
        return getPreviousYearCount("User", "CUSTOMER");
    }

    public int getTotalSellers() {
        return getTotalCount("User", "SELLER");
    }

    public int getPreviousYearSellers() {
        return getPreviousYearCount("User", "SELLER");
    }

    public int getTotalShops() {
        return getTotalCount("Shop", null);
    }

    public int getPreviousYearShops() {
        return getPreviousYearCount("Shop", null);
    }

    public List<Map<String, Object>> getShopListWithOwners() {
        EntityManager entityManager = ENTITY_MANAGER_FACTORY.createEntityManager();
        List<Map<String, Object>> shops = new ArrayList<>();
        String jpql = "SELECT s FROM Shop s JOIN s.owner o";

        try {
            TypedQuery<Object[]> query = entityManager.createQuery(jpql, Object[].class);
            List<Object[]> results = query.getResultList();

            for (Object[] result : results) {
                Map<String, Object> shopData = new HashMap<>();
                Shop shop = (Shop) result[0];
                User owner = (User) result[1];

                shopData.put("id", shop.getId());
                shopData.put("name", shop.getName());
                shopData.put("address", shop.getAddress());
                shopData.put("firstName", owner.getFirstName());
                shopData.put("lastName", owner.getLastName());

                shops.add(shopData);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return shops;
    }
}
