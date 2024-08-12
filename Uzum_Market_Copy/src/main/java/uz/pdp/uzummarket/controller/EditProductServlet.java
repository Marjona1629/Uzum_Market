package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.Product;
import uz.pdp.uzummarket.entities.Category;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.service.ProductService;
import uz.pdp.uzummarket.service.CategoryService;
import uz.pdp.uzummarket.service.ShopService;

import java.io.IOException;
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
}