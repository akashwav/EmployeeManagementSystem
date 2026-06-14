package com.ems.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;
import com.ems.util.EmailUtil;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String identifier = request.getParameter("identifier");
        Employee emp = employeeDAO.getEmployeeByIdentifier(identifier);

        if (emp != null) {
            new Thread(() -> {
                EmailUtil.sendWelcomeEmail(emp.getEmail(), emp.getEmployeeId(), emp.getPassword());
            }).start();

            request.setAttribute("successMessage", "If an account matches that identifier, credentials have been dispatched.");
        } else {
            request.setAttribute("errorMessage", "No active account found with that identifier.");
        }
        request.getRequestDispatcher("forgot_password.jsp").forward(request, response);
    }
}