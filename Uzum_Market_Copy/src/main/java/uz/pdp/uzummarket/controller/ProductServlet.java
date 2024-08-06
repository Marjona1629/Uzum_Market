package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.service.ProductService;

import java.io.IOException;
import java.io.InputStream;
import java.util.Base64;

@WebServlet(name = "productServlet", urlPatterns = "/add-product")
@MultipartConfig
public class ProductServlet extends HttpServlet {

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("addProduct.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("product_name");
        String description = req.getParameter("productDescription");
        Float productPrice = Float.valueOf(req.getParameter("productPrice"));
        Integer productDiscount = Integer.valueOf(req.getParameter("productDiscount"));
        Integer productQuantity = Integer.valueOf(req.getParameter("productQuantity"));
        Integer categoryAll = Integer.valueOf(req.getParameter("category_all"));

        Part filePart = req.getPart("productImages");
        String base64Image = null;

        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                byte[] imageBytes = inputStream.readAllBytes();
                base64Image = Base64.getEncoder().encodeToString(imageBytes);
            }
        }

        Product product = Product.builder()
                .name(name)
                .description(description)
                .price(productPrice)
                .discount(productDiscount)
                .quantity(productQuantity)
                .images(base64Image)
                .build();
        productService.createProduct(product);

        resp.sendRedirect("addProduct.jsp");
    }
}
