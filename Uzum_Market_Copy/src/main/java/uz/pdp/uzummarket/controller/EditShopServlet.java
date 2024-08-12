package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Shop;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.ShopService;

import java.io.IOException;
@WebServlet("/editShop")
public class EditShopServlet extends HttpServlet {

    private ShopService shopService;

    @Override
    public void init() throws ServletException {
        super.init();
        this.shopService = new ShopService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        Integer id = Integer.valueOf(req.getParameter("id"));
        Shop shop = shopService.getShopById(id);

        if (shop == null || !shop.getOwner().equals(user)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Shop not found or not authorized.");
            return;
        }

        req.setAttribute("shop", shop);
        req.getRequestDispatcher("/edit-shop.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in.");
            return;
        }

        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Shop ID is required.");
            return;
        }
        Integer id = Integer.valueOf(idParam);

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String address = req.getParameter("address");

        Shop shop = shopService.getShopById(id);

        if (shop == null || !shop.getOwner().equals(user)) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Shop not found or not authorized.");
            return;
        }

        shop.setName(name);
        shop.setDescription(description);
        shop.setAddress(address);

        shopService.updateShop(shop);

        resp.sendRedirect("/add-shop.jsp");
    }
}