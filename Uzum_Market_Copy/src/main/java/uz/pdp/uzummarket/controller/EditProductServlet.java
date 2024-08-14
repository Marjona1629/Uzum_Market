package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.service.ProductService;
import uz.pdp.uzummarket.service.CategoryService;
import uz.pdp.uzummarket.service.ShopService;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
@WebServlet("/editProduct")
public class EditProductServlet extends HttpServlet {
    private ProductService productService;
    private CategoryService categoryService;
    private ShopService shopService;

    @Override
    public void init() throws ServletException {
        super.init();
        productService = new ProductService();
        categoryService = new CategoryService();
        shopService = new ShopService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            try {
                int productId = Integer.parseInt(idParam);
                Product product = productService.getProductById(productId);
                List<Category> categories = categoryService.getAllCategories();
                List<Shop> sellerShops = shopService.getAllShops();

                request.setAttribute("product", product);
                request.setAttribute("productId", productId);
                request.setAttribute("categories", categories);
                request.setAttribute("sellerShops", sellerShops);

                request.getRequestDispatcher("/editProduct.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID is missing");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get parameters from the request
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                throw new ServletException("Product ID is required.");
            }
            int productId = Integer.parseInt(productIdStr);

            // Retrieve existing product
            Product product = productService.getProductById(productId);
            if (product == null) {
                throw new ServletException("Product not found.");
            }

            // Update fields if they are provided
            String productName = request.getParameter("productName");
            if (productName != null && !productName.trim().isEmpty()) {
                product.setName(productName);
            }

            String productDescription = request.getParameter("productDescription");
            if (productDescription != null && !productDescription.trim().isEmpty()) {
                product.setDescription(productDescription);
            }

            String productPriceStr = request.getParameter("productPrice");
            if (productPriceStr != null && !productPriceStr.trim().isEmpty()) {
                try {
                    product.setPrice((float) Double.parseDouble(productPriceStr));
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid product price format.");
                }
            }

            String productDiscountStr = request.getParameter("productDiscount");
            if (productDiscountStr != null && !productDiscountStr.trim().isEmpty()) {
                try {
                    product.setDiscount((int) Double.parseDouble(productDiscountStr));
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid product discount format.");
                }
            }

            String productQuantityStr = request.getParameter("productQuantity");
            if (productQuantityStr != null && !productQuantityStr.trim().isEmpty()) {
                try {
                    product.setQuantity(Integer.parseInt(productQuantityStr));
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid product quantity format.");
                }
            }

            String categoryIdStr = request.getParameter("category");
            if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
                try {
                    Category category = categoryService.getCategoryById(Integer.parseInt(categoryIdStr));
                    product.setCategory(category);
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid category ID format.");
                }
            }

            String shopIdStr = request.getParameter("shop");
            if (shopIdStr != null && !shopIdStr.trim().isEmpty()) {
                try {
                    Shop shop = shopService.getShopById(Integer.parseInt(shopIdStr));
                    product.setShop(shop);
                } catch (NumberFormatException e) {
                    throw new ServletException("Invalid shop ID format.");
                }
            }

            // Handle file upload
            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String filePath = getServletContext().getRealPath("/") + "images" + File.separator + fileName;

                File file = new File(filePath);
                file.getParentFile().mkdirs();
                Files.copy(filePart.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);

                product.setImages(fileName);
            }

            // Update product in the database
            productService.updateProduct(product);

            // Redirect to another page
            response.sendRedirect("addProduct.jsp");
        } catch (Exception e) {
            // Handle exceptions and provide a user-friendly error message
            throw new ServletException("Error processing request.", e);
        }
    }
}