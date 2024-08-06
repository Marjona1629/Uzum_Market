package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.service.UserService;

import java.io.IOException;
import java.util.List;

@WebServlet("/user")
public class UserServlet extends HttpServlet {

    UserService userService =  UserService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String numberPhone = req.getParameter("numberPhone");
        User user = User.builder()
                .username(username)
                .password(password)
                .email(email)
                .phone(numberPhone)
                .build();

        try {
            userService.saveUser(user);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("message", "User saved successfully!");
        req.getRequestDispatcher("user.jsp").forward(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<User> users = null;
        try {
            users = userService.getAllUsers();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        req.setAttribute("users", users);
        req.getRequestDispatcher("user.jsp").forward(req, resp);
    }




    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("id");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        User user = null;
        try {
            user = userService.getUserById(Integer.parseInt(userId));
            user.setUsername(username);
            user.setPassword(password);
            userService.updateUser(user);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        resp.setStatus(200);
    }

}
