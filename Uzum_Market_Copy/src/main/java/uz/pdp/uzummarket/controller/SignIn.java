package uz.pdp.uzummarket.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.uzummarket.service.AuthService;

import java.io.IOException;

@WebServlet("/sign-in")
public class SignIn extends HttpServlet {
    AuthService authService = AuthService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("sign", false);
        req.getRequestDispatcher("auth.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (authService.signIn(req, resp)) {
            resp.setContentType("text/html");
            resp.getWriter().write("<h1>CONFIRM SIGN IN.</h1>");
        } else {
            resp.setContentType("text/html");
            resp.getWriter().write("<h1>You should confirm your account! A confirmation email has been resent.</h1>");
            resp.getWriter().write("<a href='https://mail.google.com'>Go to Gmail</a>");
        }
    }
}
