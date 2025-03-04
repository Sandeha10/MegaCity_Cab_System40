package com.megacitycab.model;

public class Driver {
    private int driverId;
    private String driverName;
    private String driverNic;
    private String driverDlNumber;
    private String driverAddress;
    private String driverEmail;
    private String driverContact;

    // Constructor
    public Driver(int driverId, String driverName, String driverNic, String driverDlNumber, String driverAddress, String driverEmail, String driverContact) {
        this.driverId = driverId;
        this.driverName = driverName;
        this.driverNic = driverNic;
        this.driverDlNumber = driverDlNumber;
        this.driverAddress = driverAddress;
        this.driverEmail = driverEmail;
        this.driverContact = driverContact;
    }

    // Getters and Setters
    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }

    public String getDriverNic() { return driverNic; }
    public void setDriverNic(String driverNic) { this.driverNic = driverNic; }

    public String getDriverDlNumber() { return driverDlNumber; }
    public void setDriverDlNumber(String driverDlNumber) { this.driverDlNumber = driverDlNumber; }

    public String getDriverAddress() { return driverAddress; }
    public void setDriverAddress(String driverAddress) { this.driverAddress = driverAddress; }

    public String getDriverEmail() { return driverEmail; }
    public void setDriverEmail(String driverEmail) { this.driverEmail = driverEmail; }

    public String getDriverContact() { return driverContact; }
    public void setDriverContact(String driverContact) { this.driverContact = driverContact; }
}