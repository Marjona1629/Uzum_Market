package uz.pdp.uzummarket.service;

public class UserService {



    private static UserService userService;
    public static UserService getInstance(){
        if (userService == null){
            synchronized (UserService.class){
                if (userService == null){
                    userService = new UserService();
                }
            }
        }
        return userService;
    }
}
