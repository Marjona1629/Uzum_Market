package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.transaction.Transactional;
import uz.pdp.uzummarket.entities.Shop;

import java.util.List;

public class ShopRepository implements BaseRepository<Shop> {
    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager = entityManagerFactory.createEntityManager();

    @Transactional
    @Override
    public void save(Shop shop) {
        try {
            entityManager.getTransaction().begin();
            entityManager.persist(shop);
        } finally {
            entityManager.getTransaction().commit();
        }
    }

    @Transactional
    @Override
    public boolean delete(Shop shop) {
        entityManager.getTransaction().begin();
        Shop managedShop = entityManager.find(Shop.class, shop.getId());
        if (managedShop != null) {
            entityManager.remove(managedShop);
            entityManager.getTransaction().commit();
            return true;
        }
        entityManager.getTransaction().rollback();
        return false;
    }

    @Override
    public Shop get(Integer id) {
        return entityManager.find(Shop.class, id);
    }

    @Override
    public List<Shop> getAll() {
        return entityManager.createQuery("SELECT s FROM Shop s", Shop.class).getResultList();
    }

    @Transactional
    @Override
    public void update(Shop shop) {
        entityManager.getTransaction().begin();
        Shop managedShop = entityManager.find(Shop.class, shop.getId());
        if (managedShop != null) {
            managedShop.setName(shop.getName());
            managedShop.setDescription(shop.getDescription());
            managedShop.setAddress(shop.getAddress());
            managedShop.setOwner(shop.getOwner());
            managedShop.setStatus(shop.getStatus());
            entityManager.getTransaction().commit();
        } else {
            entityManager.getTransaction().rollback();
        }
    }
}
