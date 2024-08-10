package uz.pdp.uzummarket.controller;

import jakarta.servlet.annotation.MultipartConfig;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.service.ProductService;
import uz.pdp.uzummarket.service.CategoryService; // Assuming you have a CategoryService
import uz.pdp.uzummarket.service.ShopService; // Assuming you have a ShopService
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

@WebServlet("/addProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService(); // Replace with actual service
    private final ShopService shopService = new ShopService(); // Replace with actual service

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("productName");
        String description = req.getParameter("productDescription");
        String priceStr = req.getParameter("productPrice");
        String discountStr = req.getParameter("productDiscount");
        String quantityStr = req.getParameter("productQuantity");
        String categoryIdStr = req.getParameter("productCategory");
        String shopIdStr = req.getParameter("productShop");

        boolean valid = true;

        double price = 0.0;
        double discount = 0.0;
        int quantity = 0;
        int categoryId = 0;
        int shopId = 0;

        if (name == null || name.trim().isEmpty() || description == null || description.trim().isEmpty()) {
            valid = false;
            req.setAttribute("error", "Name and description are required.");
        }

        try {
            if (priceStr != null) {
                price = Double.parseDouble(priceStr);
            }
            if (discountStr != null) {
                discount = Double.parseDouble(discountStr);
            }
            if (quantityStr != null) {
                quantity = Integer.parseInt(quantityStr);
            }
            if (categoryIdStr != null) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (shopIdStr != null) {
                shopId = Integer.parseInt(shopIdStr);
            }
        } catch (NumberFormatException e) {
            valid = false;
            req.setAttribute("error", "Invalid number format.");
            req.getRequestDispatcher("addProduct.jsp").forward(req, resp);
            return;
        }

        // Check if Category and Shop exist
        Category category = categoryService.getCategoryById(categoryId); // Replace with actual method
        Shop shop = shopService.getShopById(shopId); // Replace with actual method
        if (category == null) {
            valid = false;
            req.setAttribute("error", "Invalid category.");
        }
        if (shop == null) {
            valid = false;
            req.setAttribute("error", "Invalid shop.");
        }

        if (!valid) {
            req.getRequestDispatcher("addProduct.jsp").forward(req, resp);
            return;
        }

        // Handle file upload
        Part filePart = req.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            String imageFileName = filePart.getSubmittedFileName();
            String imageFilePath = getServletContext().getRealPath("/images/") + File.separator + imageFileName;
            filePart.write(imageFilePath);

            // Create Product object
            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice((float) price);
            product.setDiscount((int) discount);
            product.setQuantity(quantity);
            product.setCategory(category);
            product.setShop(shop);
            product.setImages(imageFileName); // Set just the file name or path depending on your storage

            // Save the product using ProductService
            productService.createProduct(product);

            // Redirect to a success page or a confirmation page
            resp.sendRedirect("seller.jsp");
        } else {
            req.setAttribute("error", "Product image is required.");
            req.getRequestDispatcher("addProduct.jsp").forward(req, resp);
        }
    }
}