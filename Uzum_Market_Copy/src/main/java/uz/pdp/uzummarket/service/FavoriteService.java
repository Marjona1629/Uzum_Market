package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.FavoriteList;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.FavoriteRepository;

import java.util.List;

public class FavoriteService {

    private final FavoriteRepository favoriteRepository;

    public FavoriteService(FavoriteRepository favoriteRepository) {
        this.favoriteRepository = favoriteRepository;
    }

    public FavoriteService() {
        favoriteRepository = new FavoriteRepository();
    }

    public void addToFavoriteList(FavoriteList favoriteList) {
        favoriteRepository.save(favoriteList);
    }

    public boolean removeFromFavoriteList(int wishlistId) {
        FavoriteList favoriteList = favoriteRepository.get(wishlistId);
        if (favoriteList != null) {
            return favoriteRepository.delete(favoriteList);
        }
        return false;
    }

    public List<FavoriteList> getFavoriteListByUserId(int userId) {
        return favoriteRepository.getListByUserId(userId);
    }

    public boolean isProductInFavoriteList(int userId, int productId) {
        List<FavoriteList> favoriteLists = favoriteRepository.getListByUserId(userId);
        for (FavoriteList favoriteList : favoriteLists) {
            if (favoriteList.getProduct().getId() == productId) {
                return true;
            }
        }
        return false;
    }

    public void updateFavoriteList(FavoriteList favoriteList) {
        favoriteRepository.update(favoriteList);
    }

    public void removeAllFromFavoriteList(int userId) {
        List<FavoriteList> favoriteLists = favoriteRepository.getListByUserId(userId);
        for (FavoriteList favoriteList : favoriteLists) {
            favoriteRepository.delete(favoriteList);
        }
    }

    public boolean isProductInFavorites(User user, Product product) {
        List<FavoriteList> favorites = getUserFavorites(user);
        for (FavoriteList favorite : favorites) {
            if (favorite.getProduct().getId().equals(product.getId())) {
                return true;
            }
        }
        return false;
    }

    public List<FavoriteList> getUserFavorites(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null");
        }
        return favoriteRepository.getListByUserId(user.getId());
    }

    public void removeFavorite(User user, int productId) {
        FavoriteList favorite = favoriteRepository.findByUserAndProductId(user, productId);
        if (favorite != null) {
            favoriteRepository.delete(favorite);
        }
    }
}