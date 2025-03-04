package com.megacitycab.model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String contact;
    private String passwordHash;
    private String role;

    // Constructor to initialize all fields
    public User(int userId, String name, String email, String contact, String passwordHash, String role) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.contact = contact;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    // Default constructor (optional)
    public User() {}

    public User(int aInt, String name, String email, String contact) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    // Getter and Setter methods for each field
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}