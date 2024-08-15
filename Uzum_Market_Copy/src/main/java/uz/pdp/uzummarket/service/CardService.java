package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.Card;
import uz.pdp.uzummarket.repositories.CardRepository;

import jakarta.transaction.Transactional;
import java.util.List;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CardService {

    private Random random = new Random();

    private static final Logger LOGGER = Logger.getLogger(CardService.class.getName());
    private final CardRepository cardRepository;

    // Constructor
    public CardService(CardRepository cardRepository) {
        this.cardRepository = cardRepository;
    }

    @Transactional
    public void addCard(Card card) {
        try {
            card.setBalance(generateCardBalance()); // Optional: set default balance
            card.setNumber(generateCardNumber()); // Generate a card number
            cardRepository.save(card);
        } catch (Exception e) {
        }
    }

    @Transactional
    public boolean deleteCard(Integer id) {
        try {
            Card card = cardRepository.get(id);
            if (card != null) {
                return cardRepository.delete(card);
            } else {
                LOGGER.log(Level.WARNING, "Card with ID " + id + " not found");
                return false;
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error deleting card with ID " + id, e);
            return false;
        }
    }

    public Card getCard(Integer id) {
        try {
            return cardRepository.get(id);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving card with ID " + id, e);
            return null;
        }
    }

    public List<Card> getAllCards() {
        try {
            return cardRepository.getAll();
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error retrieving all cards", e);
            return null;
        }
    }

    public void updateCard(Card card) {
        try {
            cardRepository.update(card);
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error updating card", e);
        }
    }


    private Double generateCardBalance() {
        return Math.round((random.nextDouble() * 9999.99 + 0.01) * 100.0) / 100.0;
    }
    private String generateCardNumber() {
        // Generate a random 16-digit number
        StringBuilder cardNumber = new StringBuilder();
        for (int i = 0; i < 16; i++) {
            cardNumber.append(random.nextInt(10)); // Append a random digit
        }
        return cardNumber.toString();
    }
}