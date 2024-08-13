package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.Basket;
import uz.pdp.uzummarket.repositories.BasketRepository;
import uz.pdp.uzummarket.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class BasketService {
    private final BasketRepository cartRepository;

    public BasketService() {
        this.cartRepository = new BasketRepository();
    }

    public void createBasket(Basket cart) {
        cartRepository.save(cart);
    }

    public boolean deleteCart(Basket cart) {
        return cartRepository.delete(cart);
    }

    public Basket getBasketById(int id) {
        return cartRepository.get(id);
    }

    public List<Basket> getAllBaskets() {
        return cartRepository.getAll();
    }

    public void updateBasket(Basket cart) {
        cartRepository.update(cart);
    }

    public List<Basket> getBasketListByUserId(int userId) {
        return cartRepository.getBasketListByUserId(userId);
    }

    public int getQuantity(int userId, int productId) {
        return cartRepository.getQuantity(userId, productId);
    }

    public int getQuantityById(int cartId) {
        return cartRepository.getQuantityById(cartId);
    }

    public void updateQuantity(int cartId, int quantity) {
        cartRepository.updateQuantity(cartId, quantity);
    }

    public boolean removeProductFromBasket(int userId, int productId) {
        return cartRepository.removeProductFromBasket(userId, productId);
    }

    public void removeAllProducts(int userId) {
        cartRepository.removeAllProducts(userId);
    }

    public int getIdByUserIdAndProductId(int userId, int productId) {
        return cartRepository.getIdByUserIdAndProductId(userId, productId);
    }
    public int getBasketCountByUserId(int userId) throws SQLException {
        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement psmt = connection.prepareStatement("SELECT COUNT(*) FROM basket WHERE uid = ?");
        ) {
            psmt.setInt(1, userId);
            try (ResultSet rs = psmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }
}