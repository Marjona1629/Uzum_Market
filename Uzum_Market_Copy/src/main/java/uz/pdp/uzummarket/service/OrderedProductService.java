package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.OrderedProduct;
import uz.pdp.uzummarket.repositories.OrderedProductRepository;

import java.util.List;

public class OrderedProductService {

    private final OrderedProductRepository orderedProductRepository;

    public OrderedProductService() {
        this.orderedProductRepository = new OrderedProductRepository();
    }

    public void addOrderedProduct(OrderedProduct orderedProduct) {
        orderedProductRepository.save(orderedProduct);
    }

    public boolean removeOrderedProduct(int orderedProductId) {
        OrderedProduct orderedProduct = orderedProductRepository.get(orderedProductId);
        if (orderedProduct != null) {
            return orderedProductRepository.delete(orderedProduct);
        }
        return false;
    }

    public OrderedProduct getOrderedProductById(int orderedProductId) {
        return orderedProductRepository.get(orderedProductId);
    }

    public List<OrderedProduct> getAllOrderedProducts() {
        return orderedProductRepository.getAll();
    }

    public void updateOrderedProduct(OrderedProduct orderedProduct) {
        orderedProductRepository.update(orderedProduct);
    }

    // Other methods related to OrderedProductService
}
