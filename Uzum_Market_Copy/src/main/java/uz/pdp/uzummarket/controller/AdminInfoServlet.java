package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.AdminService;

import java.io.IOException;

@WebServlet("/app/admin/main/info")
public class AdminInfoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        AdminService adminService = AdminService.getInstance();
        User adminInfo = adminService.getAdminInfo();

        if (adminInfo != null) {
            request.setAttribute("adminFirstName", adminInfo.getFirstName());
            request.setAttribute("adminLastName", adminInfo.getLastName());
            request.setAttribute("adminRole", adminInfo.getRole());
            request.setAttribute("adminEmail", adminInfo.getEmail());
            request.setAttribute("adminPhone", adminInfo.getPhone());
            request.setAttribute("adminGender", adminInfo.getGender());
            request.setAttribute("adminAddress", adminInfo.getAddress());
            request.setAttribute("adminCity", adminInfo.getCity());
            request.setAttribute("adminState", adminInfo.getState());
            request.setAttribute("adminDateTime", adminInfo.getDateTime().toString());
        }

        // Forward to the JSP page
        request.getRequestDispatcher("/adminprofile.jsp").forward(request, response);
    }
}
