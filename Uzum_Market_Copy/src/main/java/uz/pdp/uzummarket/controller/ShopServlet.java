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

@WebServlet(name = "shopServlet",urlPatterns = "/add-shop")
public class ShopServlet extends HttpServlet {

    ShopService shopService = new ShopService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("post");

        HttpSession session = req.getSession();
        User loggedInUserId = (User) session.getAttribute("id");


        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String address = req.getParameter("address");

        Shop shop = Shop.builder()
                .name(name)
                .description(description)
                .address(address)
                .owner(loggedInUserId)
                .build();
        shopService.createShop(shop);
    }
}
