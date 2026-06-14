package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;
import com.ems.util.EmailUtil;
import com.ems.util.PasswordUtil;

@WebServlet("/AddEmployeeServlet")
public class AddEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Session Protection (Ensure only Admins can add)
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Extract Data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        double salary = Double.parseDouble(request.getParameter("salary"));
        String role = "Employee";

        // 3. Auto-Generate Secure Password
        String generatedPassword = PasswordUtil.generateRandomPassword();
        
        System.out.println("==========================================");
        System.out.println("NEW HIRE CREDENTIALS:");
        System.out.println("Email: " + email);
        System.out.println("Password: " + generatedPassword);
        System.out.println("==========================================");

        // 4. Create Model Object (ID is null, DAO handles generation)
        Employee newEmp = new Employee(null, name, email, generatedPassword, department, salary, role);

        // 5. Save to Database
        boolean isAdded = employeeDAO.addEmployee(newEmp);

        if (isAdded) {
            // 6. Trigger Email Dispatch
            new Thread(() -> {
                EmailUtil.sendWelcomeEmail(email, newEmp.getEmployeeId(), generatedPassword);
                
            }).start();
            request.getSession().setAttribute("flashMessage", "Employee successfully added! Credentials dispatched via email.");
            response.sendRedirect("AdminDashboardServlet");
            return;
        } else {
            request.setAttribute("errorMessage", "Failed to add employee. Email might already exist.");
            request.getRequestDispatcher("add_employee.jsp").forward(request, response);
            return; 
        }
    }
}