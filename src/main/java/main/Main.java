package main;

import dao.UserDAO;
import model.User;

import java.sql.Date;

public class Main {
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
//Testing create and adding new user, check database to verify the update
//        User newUser = new User(
//                0,
//                "Chris",
//                "Evans",
//                Date.valueOf("1995-05-10"),
//                "chris.evans@company.com",
//                "Miami",
//                "IT",
//                "Available"
//        );
//
//        userDAO.addUser(newUser);

        for(User user : userDAO.getAllUsers()){
            System.out.println(user.getFirstName() + " " + user.getLastName());
        }
    }
}
