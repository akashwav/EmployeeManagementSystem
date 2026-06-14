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

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Extract form parameters
        String role = request.getParameter("role");
        String identifier = request.getParameter("identifier"); // Can be ID or Email
        String password = request.getParameter("password");

        // 2. Authenticate against the database
        Employee employee = employeeDAO.authenticate(identifier, password, role);

        if (employee != null) {
            // 3. Establish secure session
            HttpSession session = request.getSession();
            session.setAttribute("activeUser", employee);
            session.setAttribute("userRole", role);

            // 4. Route based on role
            if ("Admin".equals(role)) {
                response.sendRedirect("AdminDashboardServlet"); 
            } else {
                response.sendRedirect("employee_profile.jsp");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid credentials or unauthorized role access.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}