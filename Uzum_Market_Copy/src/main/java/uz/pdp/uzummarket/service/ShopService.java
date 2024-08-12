package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.ShopRepository;

import java.util.List;

public class ShopService {

    private final ShopRepository shopRepository;

    public ShopService() {
        this.shopRepository = new ShopRepository();
    }

    public void createShop(Shop shop) {
        shopRepository.save(shop);
    }

    public boolean deleteShop(Shop shop) {
        return shopRepository.delete(shop);
    }

    public Shop getShopById(Integer id) {
        return shopRepository.get(id);
    }

    public List<Shop> getAllShops() {
        return shopRepository.getAll();
    }

    public void updateShop(Shop shop) {
        shopRepository.update(shop);
    }

    public List<Shop> getShopsBySeller(User user) {
        return shopRepository.getSellerShops(user);
    }
}
