package uz.pdp.uzummarket.service;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.repositories.AdminRepository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

public class AdminService {

    private static AdminRepository adminRepository = new AdminRepository();
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
            TypedQuery<User> typedQuery = entityManager.createQuery(query, User.class);
            typedQuery.setParameter("role", Role.ADMIN);
            List<User> admins = typedQuery.getResultList();

            if (!admins.isEmpty()) {
                adminInfo = admins.get(0); // Assume there is at least one admin
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
            query.setParameter("role", Role.SELLER); // Use Role.SELLER enum
            sellers = query.getResultList();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }

        return sellers;
    }

    public int getTotalCustomers() throws SQLException {
        return adminRepository.getTotalCustomers();
    }

    public int getPreviousYearCustomers() throws SQLException {
        return adminRepository.getPreviousYearCustomers();
    }

    public int getTotalSellers() throws SQLException {
        return adminRepository.getTotalSellers();
    }

    public int getPreviousYearSellers() throws SQLException {
        return adminRepository.getPreviousYearSellers();
    }

    public int getTotalShops() throws SQLException {
        return adminRepository.getTotalShops();
    }

    public int getPreviousYearShops() throws SQLException {
        return adminRepository.getPreviousYearShops();
    }

    public ResultSet getShopsList() throws SQLException {
        return adminRepository.getShopsList();
    }

    public double calculatePercentageChange(int current, int previous) {
        if (previous == 0) return 0.0;
        return ((double)(current - previous) / previous) * 100;
    }

    public String formatPercentage(double percentage) {
        DecimalFormat df = new DecimalFormat("#.##");
        return df.format(Math.abs(percentage)) + "%";
    }

    public List<Shop> displayDashboard() {
        List<Shop> shopList = new ArrayList<>();
        try {
            // Fetch totals and percentages if needed
            int totalCustomers = getTotalCustomers();
            int previousYearCustomers = getPreviousYearCustomers();
            double percentageChangeCustomers = calculatePercentageChange(totalCustomers, previousYearCustomers);
            String formattedPercentageChangeCustomers = formatPercentage(percentageChangeCustomers);

            int totalSellers = getTotalSellers();
            int previousYearSellers = getPreviousYearSellers();
            double percentageChangeSellers = calculatePercentageChange(totalSellers, previousYearSellers);
            String formattedPercentageChangeSellers = formatPercentage(percentageChangeSellers);

            int totalShops = getTotalShops();
            int previousYearShops = getPreviousYearShops();
            double percentageChangeShops = calculatePercentageChange(totalShops, previousYearShops);
            String formattedPercentageChangeShops = formatPercentage(percentageChangeShops);

            // Process shops list
            ResultSet shopsList = getShopsList();
            while (shopsList.next()) {
                Shop shop = new Shop();
                shop.setId(shopsList.getInt("id"));
                shop.setName(shopsList.getString("name"));
                shop.setAddress(shopsList.getString("address"));

                User owner = new User();
                owner.setFirstName(shopsList.getString("first_name"));
                owner.setLastName(shopsList.getString("last_name"));
                shop.setOwner(owner);

                shopList.add(shop);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shopList;
    }

}
