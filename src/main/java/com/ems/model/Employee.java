package com.ems.model;

public class Employee {
    private String employeeId;
    private String name;
    private String email;
    private String password;
    private String department;
    private double salary;
    private String role;

    // Default Constructor
    public Employee() {}

    // Parameterized Constructor for easy object creation
    public Employee(String employeeId, String name, String email, String password, String department, double salary, String role) {
        this.employeeId = employeeId;
        this.name = name;
        this.email = email;
        this.password = password;
        this.department = department;
        this.salary = salary;
        this.role = role;
    }

    // Getters and Setters
    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public double getSalary() { return salary; }
    public void setSalary(double salary) { this.salary = salary; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}