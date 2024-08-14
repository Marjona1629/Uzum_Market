package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.repositories.CategoryRepository;

import java.util.List;

public class CategoryService {

    private final CategoryRepository categoryRepository;

    public CategoryService() {
        this.categoryRepository = new CategoryRepository();
    }

    public void addCategory(Category category) {
        categoryRepository.save(category);
    }

    public boolean removeCategory(int categoryId) {
        Category category = categoryRepository.get(categoryId);
        if (category != null) {
            return categoryRepository.delete(category);
        }
        return false;
    }

    public Category getCategoryById(int categoryId) {
        return categoryRepository.get(categoryId);
    }

    public List<Category> getAllCategories() {
        return categoryRepository.getAll();
    }

    public void updateCategory(Category category) {
        categoryRepository.update(category);
    }

    public int getCategoryCount() {
        return categoryRepository.categoryCount();
    }

    public List<String> getAllCategoryNames() {
        return categoryRepository.getCategoryNames();
    }

    public String getCategoryNameById(int categoryId) {
        return categoryRepository.getCategoryName(categoryId);
    }
}