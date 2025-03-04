package com.megacitycab.model;

import java.sql.Timestamp;

public class Booking {
    private int bookingId;
    private String customerName;
    private String nic;
    private String address;
    private String contactNumber;
    private String pickupLocation;
    private String dropLocation;
    private double distance;
    private String vehicleType;
    private String vehicleName;
    private double fare;
    private String  bookingDate;
    

    // Default Constructor (IMPORTANT)
    public Booking(int aInt, String string, String string1, String string2, String string3, String string4, String string5, double aDouble, String string6, String string7, double aDouble1, Timestamp timestamp, String string8, String string9) {}

    // Constructor with parameters
    public Booking(int bookingId, String customerName, String nic, String address, String contactNumber,
                   String pickupLocation, String dropLocation, double distance, String vehicleType,
                   String vehicleName, double fare, String  bookingDate) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.nic = nic;
        this.address = address;
        this.contactNumber = contactNumber;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.distance = distance;
        this.vehicleType = vehicleType;
        this.vehicleName = vehicleName;
        this.fare = fare;
        this.bookingDate = bookingDate;
        
    }

    // Getters and Setters
    public int getBookingId() { return bookingId; }
    public void setBookingId(int bookingId) { this.bookingId = bookingId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }

    public String getDropLocation() { return dropLocation; }
    public void setDropLocation(String dropLocation) { this.dropLocation = dropLocation; }

    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }

    public String getVehicleType() { return vehicleType; }
    public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }

    public String getVehicleName() { return vehicleName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }

    public double getFare() { return fare; }
    public void setFare(double fare) { this.fare = fare; }

    public String  getBookingDate() { return bookingDate; }
    public void setBookingDate(String  bookingDate) { this.bookingDate = bookingDate; }

   
    
    
}
