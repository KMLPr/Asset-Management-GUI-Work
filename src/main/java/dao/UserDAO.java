package dao;

import model.User;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class UserDAO {
    //Make basic CRUD methods

    //Read through all the users in the system
    //Could be good for audits
    public List<User> getAllUsers(){
        List<User> users = new ArrayList<>();

        String query = "SELECT * FROM users";

        try(Connection conn = DBConnection.getConnection()){
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query); {
                while(rs.next()){
                    User user = new User(rs.getInt("user_id"),
                            rs.getString("first_name"),
                            rs.getString("last_name"),
                            rs.getDate("DOB"),
                            rs.getString("email"),
                            rs.getString("location"),
                            rs.getString("department"),
                            rs.getString("work_status"));
                    users.add(user);
                }
            }
        } catch(SQLException e){
            e.printStackTrace();
        }
        return users;
    }

    //Make the user forr the system
    public void addUser(User user){
        String query = "INSERT INTO users " +
                "(first_name, last_name, DOB, email, location, department, work_status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try(Connection conn = DBConnection.getConnection();
        PreparedStatement stmt = conn.prepareStatement(query)){
            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setDate(3, user.getDob());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getLocation());
            stmt.setString(6, user.getDepartment());
            stmt.setString(7, user.getWorkStatus());

            stmt.executeUpdate();
            System.out.println("User added successfully.");
        }catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Change user info
    public void updateUser(User user){
        String query = "UPDATE users SET first_name=?, last_name=?, DOB=?, " +
                "email=?, location=?, department=?, work_status=? WHERE user_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setDate(3, user.getDob());
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getLocation());
            stmt.setString(6, user.getDepartment());
            stmt.setString(7, user.getWorkStatus());
            stmt.setInt(8, user.getUserId());

            stmt.executeUpdate();
            System.out.println("User updated successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //Take out user
    public void deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, userId);
            stmt.executeUpdate();

            System.out.println("User deleted successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
