package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.Basket;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.BasketService;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/app/deletebasket")
public class DeleteBasketServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            int basketId = Integer.parseInt(request.getParameter("basketId"));
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user != null) {
                BasketService basketService = new BasketService();
                Basket basket = basketService.getBasketById(basketId);
                if (basket != null) {
                    basketService.deleteCart(basket); // Method to delete the item
                    sendJsonResponse(response, true, "Item deleted successfully.");
                } else {
                    sendJsonResponse(response, false, "Basket item not found.");
                }
            } else {
                sendJsonResponse(response, false, "User not authorized.");
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            }
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid basket ID format.");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        PrintWriter out = response.getWriter();
        String jsonResponse = String.format("{\"success\": %b, \"message\": \"%s\"}", success, message);
        out.print(jsonResponse);
        out.flush();
    }
}