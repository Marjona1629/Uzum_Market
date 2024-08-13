package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;

@WebServlet(name = "registerseller",value = "/app/admin/registerseller")
public class RegisterSellerSevlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register-seller.jsp").forward(req, resp);
    }

    UserService userService =  UserService.getInstance();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        boolean isUserExists = userService.checkUserExists(email);

        if (isUserExists) {
            boolean registered = userService.registerSeller(email);
            if (registered) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        } else {
            response.getWriter().write("exists");
        }
    }
}