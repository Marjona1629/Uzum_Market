package uz.pdp.uzummarket.service;

import jakarta.transaction.Transactional;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.ProductRepository;

import java.util.List;

public class ProductService {

    private final ProductRepository productRepository;

    public ProductService() {
        this.productRepository = new ProductRepository();
    }

    public void createProduct(Product product) {
        productRepository.save(product);
    }

    public boolean deleteProduct(Product product) {
        return productRepository.delete(product);
    }

    public Product getProductById(int id) {
        return productRepository.get(id);
    }

    public List<Product> getAllProducts() {
        return productRepository.getAll();
    }

    public List<Product> getAllProductsByCategory(int categoryId) {
        return productRepository.findProductsByCategoryId(categoryId);
    }

    public void updateProduct(Product product) {
        productRepository.update(product);
    }

    public List<Product> getAllLatestProducts() {
        return productRepository.findLatestProducts();
    }

    @Transactional
    public List<Product> getDiscountedProducts() {
        return productRepository.findDiscountedProducts();
    }

    public List<Product> searchProductsByName(String name) {
        return productRepository.findProductsByName(name);
    }

    public List<Product> getProductsBySeller(User user) {
        return productRepository.findProductsBySeller(user);
    }
}
