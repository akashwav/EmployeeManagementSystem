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

@WebServlet("/EditEmployeeServlet")
public class EditEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    // 1. Catches the "Edit" click, loads data, and shows the form
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String id = request.getParameter("id");
        Employee emp = employeeDAO.getEmployeeByIdentifier(id);

        if (emp != null) {
            request.setAttribute("employeeToEdit", emp);
            request.getRequestDispatcher("edit_employee.jsp").forward(request, response);
        } else {
            session.setAttribute("flashMessage", "Error: Could not find employee data.");
            response.sendRedirect("AdminDashboardServlet");
        }
    }

    // 2. Catches the form submission and saves to the database
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Extract updated data
        String id = request.getParameter("employeeId");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String department = request.getParameter("department");
        double salary = Double.parseDouble(request.getParameter("salary"));

        // Package into model
        Employee emp = new Employee();
        emp.setEmployeeId(id);
        emp.setName(name);
        emp.setEmail(email);
        emp.setDepartment(department);
        emp.setSalary(salary);

        // Update DB
        boolean isUpdated = employeeDAO.updateEmployee(emp);

        if (isUpdated) {
            session.setAttribute("flashMessage", "Employee " + id + " was successfully updated.");
        } else {
            session.setAttribute("flashMessage", "Error: Failed to update employee.");
        }

        // Redirect back to dashboard
        response.sendRedirect("AdminDashboardServlet");
    }
}