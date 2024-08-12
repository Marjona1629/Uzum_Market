package uz.pdp.uzummarket.controller;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.enums.Role;
import uz.pdp.uzummarket.enums.Status;
import uz.pdp.uzummarket.repositories.NotificationRepository;
import uz.pdp.uzummarket.service.NotificationService;
import uz.pdp.uzummarket.service.ProductService;
import uz.pdp.uzummarket.service.CategoryService; // Ensure this service exists
import uz.pdp.uzummarket.service.ShopService; // Ensure this service exists
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;

import java.io.File;
import java.io.IOException;
import java.util.List;

@WebServlet("/app/seller/addProductServlet")
@MultipartConfig
public class AddProductServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();
    private final ShopService shopService = new ShopService();
    private final NotificationService notificationService = new NotificationService(new NotificationRepository());

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        List<Product> products = productService.getProductsBySeller(user);
        req.setAttribute("products", products);

        long unreadCount = notificationService.countUnreadNotificationsByUserId(user != null ? user.getId() : 0);
        req.setAttribute("unreadCount", unreadCount);

        req.getRequestDispatcher("/addProduct.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals(Role.SELLER)) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in or not authorized.");
            return;
        }

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
            if (priceStr != null && !priceStr.isEmpty()) {
                price = Double.parseDouble(priceStr);
            }
            if (discountStr != null && !discountStr.isEmpty()) {
                discount = Double.parseDouble(discountStr);
            }
            if (quantityStr != null && !quantityStr.isEmpty()) {
                quantity = Integer.parseInt(quantityStr);
            }
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
            if (shopIdStr != null && !shopIdStr.isEmpty()) {
                shopId = Integer.parseInt(shopIdStr);
            }
        } catch (NumberFormatException e) {
            valid = false;
            req.setAttribute("error", "Invalid number format.");
        }

        Category category = categoryService.getCategoryById(categoryId);
        Shop shop = shopService.getShopById(shopId);
        if (category == null) {
            valid = false;
            req.setAttribute("error", "Invalid category.");
        }
        if (shop == null) {
            valid = false;
            req.setAttribute("error", "Invalid shop.");
        }

        if (!valid) {
            req.getRequestDispatcher("/addProduct.jsp").forward(req, resp);
            return;
        }

        Part filePart = req.getPart("productImage");
        if (filePart != null && filePart.getSize() > 0) {
            String imageFileName = filePart.getSubmittedFileName();
            String imageFilePath = "D:/Uzum_Market_Images/" + imageFileName;

            File imageFile = new File(imageFilePath);
            imageFile.getParentFile().mkdirs(); // Ensure the directory exists

            filePart.write(imageFile.getAbsolutePath());

            Product product = new Product();
            product.setName(name);
            product.setDescription(description);
            product.setPrice((float) price);
            product.setDiscount((int) discount);
            product.setQuantity(quantity);
            product.setCategory(category);
            product.setShop(shop);
            product.setImages(imageFileName);

            productService.createProduct(product);
            resp.sendRedirect(req.getContextPath() + "/addProduct.jsp");
        } else {
            req.setAttribute("error", "Product image is required.");
            req.getRequestDispatcher("/addProduct.jsp").forward(req, resp);
        }
    }
}