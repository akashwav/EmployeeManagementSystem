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

@WebServlet("/DeleteEmployeeServlet")
public class DeleteEmployeeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    public void init() {
        employeeDAO = new EmployeeDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Strict Session & Role Verification
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("userRole"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Get the ID from the URL parameter (e.g., ?id=E0A1002)
        String idToDelete = request.getParameter("id");
        
        // 3. Server-Side Safety Check: Prevent Admin from deleting themselves
        Employee activeAdmin = (Employee) session.getAttribute("activeUser");
        if (activeAdmin.getEmployeeId().equals(idToDelete)) {
            session.setAttribute("flashMessage", "Security Block: You cannot delete your own admin account.");
            response.sendRedirect("AdminDashboardServlet");
            return;
        }

        // 4. Execute the deletion
        if (idToDelete != null && !idToDelete.isEmpty()) {
            boolean isDeleted = employeeDAO.deleteEmployee(idToDelete);
            
            if (isDeleted) {
                session.setAttribute("flashMessage", "Employee record " + idToDelete + " was successfully deleted.");
            } else {
                session.setAttribute("flashMessage", "Error: Could not delete employee record.");
            }
        }

        // 5. Redirect back to the dashboard to see the updated table
        response.sendRedirect("AdminDashboardServlet");
    }
}