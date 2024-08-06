package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.AdminService;
import uz.pdp.uzummarket.util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/showSellers")
public class ShowSellersServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminService adminService =  AdminService.getInstance();
        List<User> sellers = adminService.getSellers();
        request.setAttribute("sellers", sellers);
        request.getRequestDispatcher("show-sellers.jsp").forward(request, response);
    }

}
