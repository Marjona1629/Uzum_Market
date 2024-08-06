package uz.pdp.uzummarket.filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/app/admin/*"})
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession();
        Object role = session.getAttribute("role");

        if ( role != null && role.equals("ADMIN")) {
            System.out.println("Logged in as " + role);
            filterChain.doFilter(request, response);
        }else {
            response.sendError(403,"You are not ADMIN");
        }
    }

}
