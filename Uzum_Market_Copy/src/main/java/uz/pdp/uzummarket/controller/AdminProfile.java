package uz.pdp.uzummarket.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.uzummarket.entities.User;

import java.io.IOException;

@WebServlet(name = "adminprofile",value = "/app/admin/adminprofile")
public class AdminProfile extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            request.setAttribute("user", user);
            request.getRequestDispatcher("/adminprofile.jsp").forward(request, response);
        } else {
            response.sendRedirect("/login.jsp");
        }
    }
}
