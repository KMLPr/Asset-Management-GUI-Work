package model;

import java.sql.Date;

public class User {
    private int userId;
    private String firstName;
    private String lastName;
    private Date dob;
    private String email;
    private String location;
    private String department;
    private String workStatus;

    public User(int userId, String firstName, String lastName, Date dob,
                String email, String location, String department, String workStatus) {
        this.userId = userId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dob = dob;
        this.email = email;
        this.location = location;
        this.department = department;
        this.workStatus = workStatus;
    }

    public int getUserId() { return userId; }
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
}
