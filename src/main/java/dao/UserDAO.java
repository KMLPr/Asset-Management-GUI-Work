package dao;

import model.User;
import util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class UserDAO {

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
}
