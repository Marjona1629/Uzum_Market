package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;

@WebServlet(name = "updateProfile", value = "/app/updateProfile")
public class UpdateProfileServlet extends HttpServlet {

    private UserService userService = UserService.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user != null) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String phoneNumber = request.getParameter("phone");
            String address = request.getParameter("address");
            String state = request.getParameter("country");
            String city = request.getParameter("city");
            String gender = request.getParameter("gender");

            // Update user details
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setPhone(phoneNumber);
            user.setAddress(address);
            user.setState(state);
            user.setCity(city);
            user.setGender(gender);

            boolean isUpdated = userService.updateUser(user);

            if (isUpdated) {
                session.setAttribute("user", user);

                if ("ADMIN".equalsIgnoreCase(String.valueOf(user.getRole()))) {
                    response.sendRedirect(request.getContextPath() + "/adminprofile.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/profile.jsp");
                }

            } else {
                request.setAttribute("errorMessage", "Failed to update profile.");
                request.getRequestDispatcher("/profile.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
        }
    }
}