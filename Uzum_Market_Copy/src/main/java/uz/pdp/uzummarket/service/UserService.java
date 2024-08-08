package uz.pdp.uzummarket.service;

import uz.pdp.uzummarket.entities.User;
import uz.pdp.uzummarket.repositories.UserRepository;

import java.util.List;
import java.util.Optional;

public class UserService {

    private final UserRepository userRepository;

    private UserService() {
        this.userRepository = UserRepository.getInstance();
    }

    public void saveUser(User user) {
        userRepository.save(user);
    }

    public boolean deleteUser(User user) {
        return userRepository.delete(user);
    }

    public User getUserById(Integer id) {
        return userRepository.get(id);
    }

    public List<User> getAllUsers() {
        return userRepository.getAll();
    }

    public boolean updateUser(User user) {
        try {
            userRepository.update(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    public User login(String username, String password) {
        return userRepository.login(username, password);
    }

    public User findByEmailAndPassword(String email, String password) {
        return userRepository.findByEmailAndPassword(email, password);
    }

    public boolean checkUserExists(String email) {
        return userRepository.checkUserExists(email);
    }

    public Optional<User> getUserByEmail(String email) {
        return userRepository.getUserByEmail(email);
    }

    public boolean registerSeller(String email) {
        return userRepository.registerSeller(email);
    }

    private static UserService userService;

    public static UserService getInstance() {
        if (userService == null) {
            synchronized (UserService.class) {
                if (userService == null) {
                    userService = new UserService();
                }
            }
        }
        return userService;
    }
}
