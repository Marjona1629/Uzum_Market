package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;

import java.util.Collections;
import java.util.List;
import java.util.ArrayList;

public class ProductRepository implements BaseRepository<Product> {

    private final ShopRepository shopRepository = new ShopRepository();
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager = entityManagerFactory.createEntityManager();

    @Transactional
    @Override
    public void save(Product product) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(product);
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        } finally {
            transaction.commit();
        }
    }


    @Transactional
    @Override
    public boolean delete(Product product) {
        entityManager.getTransaction().begin();
        Product managedProduct = entityManager.find(Product.class, product.getId());
        if (managedProduct != null) {
            entityManager.remove(managedProduct);
            entityManager.getTransaction().commit();
            return true;
        }
        entityManager.getTransaction().rollback();
        return false;
    }

    @Override
    public Product get(Integer id) {
        return entityManager.find(Product.class, id);
    }

    @Override
    public List<Product> getAll() {
        return entityManager.createQuery("SELECT p FROM Product p", Product.class).getResultList();
    }

    @Transactional
    @Override
    public void update(Product product) {
        entityManager.getTransaction().begin();
        Product managedProduct = entityManager.find(Product.class, product.getId());
        if (managedProduct != null) {
            managedProduct.setName(product.getName());
            managedProduct.setDescription(product.getDescription());
            managedProduct.setPrice(product.getPrice());
            managedProduct.setDiscount(product.getDiscount());
            managedProduct.setQuantity(product.getQuantity());
            managedProduct.setImages(product.getImages());
            managedProduct.setPriceAfterDiscount(product.getPriceAfterDiscount());
            managedProduct.setCategory(product.getCategory());
            managedProduct.setShop(product.getShop());
            entityManager.getTransaction().commit();
        } else {
            entityManager.getTransaction().rollback();
        }
    }

    public List<Product> findProductsByCategoryId(int categoryId) {
        return entityManager.createQuery("SELECT p FROM Product p WHERE p.category.id = :categoryId", Product.class)
                .setParameter("categoryId", categoryId)
                .getResultList();
    }

    public List<Product> findProductsByName(String query) {
        return entityManager.createQuery("SELECT p FROM Product p WHERE p.name LIKE :name", Product.class)
                .setParameter("name", query + "%")
                .getResultList();
    }

    public List<Product> findByName(String name) {
        return entityManager.createQuery("SELECT p FROM Product p WHERE p.name LIKE :name", Product.class)
                .setParameter("name", name + "%")
                .getResultList();
    }

    public List<Product> findLatestProducts() {
        return entityManager.createQuery("SELECT p FROM Product p ORDER BY p.id DESC", Product.class)
                .setMaxResults(10)
                .getResultList();
    }

    @Transactional
    public List<Product> findDiscountedProducts() {
        return entityManager.createQuery("SELECT p FROM Product p WHERE p.discount > 0", Product.class)
                .getResultList();
    }

    @Transactional
    public List<Product> findProductsBySeller(User user) {
        if (user == null) {
            return Collections.emptyList();
        }
        List<Shop> shops = shopRepository.getSellerShops(user);

        List<Product> products = new ArrayList<>();
        for (Shop shop : shops) {
            products.addAll(shop.getProducts());
        }
        return products;
    }
}