package com.ems.dao;

import com.ems.model.Employee;
import com.ems.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeDAO {

    // 1. Authenticate Login
    public Employee authenticate(String identifier, String password, String role) {
        Employee emp = null;
        // Allows login via either Employee ID or Email
        String sql = "SELECT * FROM employees WHERE (employee_id = ? OR email = ?) AND password = ? AND role = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, identifier);
            pstmt.setString(2, identifier);
            pstmt.setString(3, password);
            pstmt.setString(4, role);
            
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                emp = new Employee();
                emp.setEmployeeId(rs.getString("employee_id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setRole(rs.getString("role"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return emp;
    }

    // 2. Generate Next Employee ID
    private String generateNextId(Connection conn) throws SQLException {
        String sql = "SELECT employee_id FROM employees ORDER BY created_at DESC LIMIT 1";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                String lastId = rs.getString("employee_id");
                if (lastId.startsWith("E0A")) {
                    int num = Integer.parseInt(lastId.substring(3));
                    return "E0A" + (num + 1);
                }
            }
        }
        return "E0A1001"; 
    }

    // 3. Add New Employee
    public boolean addEmployee(Employee emp) {
        String sql = "INSERT INTO employees (employee_id, name, email, password, department, salary, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            // Auto-generate ID before inserting
            String newId = generateNextId(conn);
            emp.setEmployeeId(newId);
            
            pstmt.setString(1, emp.getEmployeeId());
            pstmt.setString(2, emp.getName());
            pstmt.setString(3, emp.getEmail());
            pstmt.setString(4, emp.getPassword());
            pstmt.setString(5, emp.getDepartment());
            pstmt.setDouble(6, emp.getSalary());
            pstmt.setString(7, emp.getRole());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
 
    // 4. Fetch Paginated and Sorted Employees
    public List<Employee> getEmployees(int offset, int limit, String sortBy) {
        List<Employee> list = new ArrayList<>();
        String validSort = "employee_id";
        if ("name".equals(sortBy) || "department".equals(sortBy) || "salary".equals(sortBy)) {
            validSort = sortBy;
        }

        String sql = "SELECT * FROM employees " +
                "WHERE role <> 'Admin' " +
                "ORDER BY " + validSort + " ASC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, limit);
            pstmt.setInt(2, offset);
            
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setEmployeeId(rs.getString("employee_id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setDepartment(rs.getString("department"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setRole(rs.getString("role"));
                list.add(emp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 5. Get Total Record Count (for calculating total pages)
    public int getTotalRecords() {
    	String sql = "SELECT COUNT(*) FROM employees WHERE role <> 'Admin'";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
 // 6. Fetch Employee for Password Retrieval
    public Employee getEmployeeByIdentifier(String identifier) {
        String sql = "SELECT * FROM employees WHERE employee_id = ? OR email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, identifier);
            pstmt.setString(2, identifier);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Employee emp = new Employee();
                emp.setEmployeeId(rs.getString("employee_id"));
                emp.setName(rs.getString("name"));
                emp.setEmail(rs.getString("email"));
                emp.setPassword(rs.getString("password"));
                return emp;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // 7. Delete Employee
    public boolean deleteEmployee(String employeeId) {
        String sql = "DELETE FROM employees WHERE employee_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, employeeId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // 8. Update Employee Details
    public boolean updateEmployee(Employee emp) {
        String sql = "UPDATE employees SET name = ?, email = ?, department = ?, salary = ? WHERE employee_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, emp.getName());
            pstmt.setString(2, emp.getEmail());
            pstmt.setString(3, emp.getDepartment());
            pstmt.setDouble(4, emp.getSalary());
            pstmt.setString(5, emp.getEmployeeId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}