package uz.pdp.uzummarket.repositories;

import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.EntityTransaction;
import uz.pdp.uzummarket.entities.User;

import java.util.List;

public class UserRepository implements BaseRepository<User> {

    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public void save(User user) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            if (user.getUserId() == null) {
                entityManager.persist(user);
            } else {
                entityManager.merge(user);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw new RuntimeException("Failed to save user", e);
        }
    }

    @Override
    public boolean delete(User user) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User managedUser = entityManager.find(User.class, user.getUserId());
            if (managedUser != null) {
                entityManager.remove(managedUser);
                transaction.commit();
                return true;
            }
            transaction.rollback();
            return false;
        } catch (Exception e) {
            transaction.rollback();
            throw new RuntimeException("Failed to delete user", e);
        }
    }

    @Override
    public User get(Integer id) {
        return entityManager.find(User.class, id);
    }

    @Override
    public List<User> getAll() {
        return entityManager.createQuery("SELECT u FROM User u", User.class).getResultList();
    }

    @Override
    public void update(User user) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(user);
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw new RuntimeException("Failed to update user", e);
        }
    }
}
