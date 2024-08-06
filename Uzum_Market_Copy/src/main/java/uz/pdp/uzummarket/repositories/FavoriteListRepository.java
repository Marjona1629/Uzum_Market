package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import uz.pdp.uzummarket.entities.FavoriteList;

import java.util.ArrayList;
import java.util.List;

public class FavoriteListRepository implements BaseRepository<FavoriteList> {

    private static final EntityManagerFactory ENTITY_MANAGER_FACTORY = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");
    private final EntityManager entityManager;

    public FavoriteListRepository() {
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
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            FavoriteList existingFavoriteList = entityManager.find(FavoriteList.class, favoriteList.getId());
            if (existingFavoriteList != null) {
                entityManager.remove(existingFavoriteList);
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
        String jpql = "SELECT f FROM FavoriteList f WHERE f.id = :userId";
        TypedQuery<FavoriteList> query = entityManager.createQuery(jpql, FavoriteList.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
}
