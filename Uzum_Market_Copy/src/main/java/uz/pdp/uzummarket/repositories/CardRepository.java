package uz.pdp.uzummarket.repositories;

import jakarta.persistence.*;
import uz.pdp.uzummarket.entities.Card;

import java.util.List;

public class CardRepository implements BaseRepository<Card> {

    private static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("HIBERNATE-UNIT");

    public void save(Card card) {
        EntityManager entityManager = null;
        EntityTransaction transaction = null;

        try {
            entityManager = entityManagerFactory.createEntityManager();
            transaction = entityManager.getTransaction();
            transaction.begin();

            if (card.getId() == null) {
                System.out.println("Persisting new card: " + card);
                entityManager.persist(card);
            } else {
                System.out.println("Updating existing card: " + card);
                entityManager.merge(card);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null && transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Error during save operation: " + e.getMessage());
            throw new RuntimeException("Failed to save card", e);
        }
    }

    @Override
    public boolean delete(Card card) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Card managedCard = entityManager.find(Card.class, card.getId());
            if (managedCard != null) {
                entityManager.remove(managedCard);
                transaction.commit();
                return true;
            }
            transaction.rollback();
            return false;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new RuntimeException("Failed to delete card", e);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public Card get(Integer id) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            return entityManager.find(Card.class, id);
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Card> getAll() {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Card> query = entityManager.createQuery("SELECT c FROM Card c", Card.class);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public void update(Card card) {
        save(card);  // Reuse save method which handles both persistence and merging.
    }

    public List<Card> findByUserId(Integer userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Card> query = entityManager.createQuery(
                    "SELECT c FROM Card c WHERE c.user.id = :userId", Card.class
            );
            query.setParameter("userId", userId);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    private static CardRepository cardRepository;

    public static CardRepository getInstance() {
        if (cardRepository == null) {
            synchronized (CardRepository.class) {
                if (cardRepository == null) {
                    cardRepository = new CardRepository();
                }
            }
        }
        return cardRepository;
    }

    public long countByUserId(Integer userId) {
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        try {
            TypedQuery<Long> query = entityManager.createQuery(
                    "SELECT COUNT(c) FROM Card c WHERE c.user.id = :userId", Long.class
            );
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } finally {
            entityManager.close();
        }
    }
}