package main;

import dao.UserDAO;
import model.User;
public class Main {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();

        for(User user : userDAO.getAllUsers()){
            System.out.println(user.getFirstName() + " " + user.getLastName());
        }
    }
}
