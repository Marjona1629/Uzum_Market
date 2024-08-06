package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.FavoriteList;
import uz.pdp.uzummarket.repositories.FavoriteListRepository;

import java.util.List;

public class FavoriteListService {

    private final FavoriteListRepository favoriteListRepository;

    public FavoriteListService() {
        this.favoriteListRepository = new FavoriteListRepository();
    }

    public void addToFavoriteList(int userId, int productId) {
        FavoriteList favoriteList = new FavoriteList();
        favoriteListRepository.save(favoriteList);
    }

    public boolean removeFromFavoriteList(int wishlistId) {
        FavoriteList favoriteList = favoriteListRepository.get(wishlistId);
        if (favoriteList != null) {
            return favoriteListRepository.delete(favoriteList);
        }
        return false;
    }

    public List<FavoriteList> getFavoriteListByUserId(int userId) {
        return favoriteListRepository.getListByUserId(userId);
    }

    public boolean isProductInFavoriteList(int userId, int productId) {
        List<FavoriteList> favoriteLists = favoriteListRepository.getListByUserId(userId);
        for (FavoriteList favoriteList : favoriteLists) {
            if (favoriteList.getProduct().getId() == productId) {
                return true;
            }
        }
        return false;
    }

    public void updateFavoriteList(FavoriteList favoriteList) {
        favoriteListRepository.update(favoriteList);
    }

    public void removeAllFromFavoriteList(int userId) {
        List<FavoriteList> favoriteLists = favoriteListRepository.getListByUserId(userId);
        for (FavoriteList favoriteList : favoriteLists) {
            favoriteListRepository.delete(favoriteList);
        }
    }
}
