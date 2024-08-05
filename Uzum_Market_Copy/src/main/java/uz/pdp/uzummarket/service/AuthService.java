package uz.pdp.uzummarket.service;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.SneakyThrows;
import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.UserRepository;

import java.util.Base64;
import java.util.Optional;
import java.util.Random;

public class AuthService {
    private final UserRepository userRepository;
    private final EmailService emailService;

    public AuthService() {
        this.userRepository = UserRepository.getInstance();
        this.emailService = EmailService.getInstance();
    }

    @SneakyThrows
    public boolean signIn(HttpServletRequest request, HttpServletResponse response) {
        request.setAttribute("exists",true);
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Optional<User> optionalUser = userRepository.getUserByEmail(email);
        if (optionalUser.isEmpty() || !optionalUser.get().getPassword().equals(password)){
            request.setAttribute("exists",false);
            return false;
        }
        User user = optionalUser.get();
        if (!user.getHasConfirmed()){
            response.setContentType("text/html");
            response.getWriter().write("you should confirm your account!");
            return false;
        }
        request.setAttribute("user",user);
        return true;
    }

    public boolean signUp(HttpServletRequest request, HttpServletResponse response) {
        String name = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Optional<User> optionalUser = userRepository.getUserByEmail(email);

        request.setAttribute("exists", false);
        if (optionalUser.isPresent()) {
            request.setAttribute("exists", true);
            return false;
        }
        User user =  User.builder()
                .username(name)
                .email(email)
                .password(password)
                .hasConfirmed(false)
                .build();
        user.setCode(generateCode());
        userRepository.save(user);
        String  text = user.getEmail()+":"+user.getCode();
        final String message = new String(Base64.getEncoder().encode(text.getBytes()));
        new Thread(()->emailService.sendSmsToUser(user.getEmail(),message)).start();
        return true;
    }

    private String generateCode() {
        StringBuilder sb = new StringBuilder();
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            sb.append(random.nextInt(10)); // Generates a random integer between 0 and 9
        }
        return sb.toString();
    }


    @SneakyThrows
    public void confirmEmail(HttpServletRequest req, HttpServletResponse resp) {
        String confirmation = req.getParameter("confirmation");
        confirmation = new String(Base64.getDecoder().decode(confirmation.getBytes()));
        String[] split = confirmation.split(":");
        Optional<User> optionalUser = userRepository.getUserByEmail(split[0]);
        req.setAttribute("exists",false);
        if (optionalUser.isEmpty() || !optionalUser.get().getCode().equals(split[1])){
            resp.getWriter().write("something went wrong");
            return;
        }
    }


    private static AuthService authService;
    public static AuthService getInstance() {
        if (authService == null)
            synchronized (AuthService.class) {
                if (authService == null) {
                    authService = new AuthService();
                }
            }
        return authService;
    }
}