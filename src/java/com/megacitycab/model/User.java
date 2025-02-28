package com.megacitycab.model;

public class User {
    private String name;
    private String email;
    private String contact;
    private String passwordHash;
    private String role;

    // Constructor to initialize all fields
    public User(String name, String email, String contact, String passwordHash, String role) {
        this.name = name;
        this.email = email;
        this.contact = contact;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    // Default constructor (optional)
    public User() {}

    // Getter and Setter methods for each field
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
