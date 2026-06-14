package com.ems.controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ems.dao.EmployeeDAO;
import com.ems.model.Employee;

@WebServlet("/AdminDashboardServlet")
public class AdminDashboardServlet extends HttpServlet {
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

        // 2. Pagination Logic Setup
        int page = 1;
        int recordsPerPage = 5;
        
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        
        String sortBy = request.getParameter("sort");
        if (sortBy == null) {
            sortBy = "employee_id"; // Default sorting
        }

        // 3. Calculate Offset and Fetch Data
        int offset = (page - 1) * recordsPerPage;
        List<Employee> employeeList = employeeDAO.getEmployees(offset, recordsPerPage, sortBy);
        
        // 4. Calculate Pagination Math
        int totalRecords = employeeDAO.getTotalRecords();
        int noOfPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);

        // 5. Package Data into Request Attributes
        request.setAttribute("employeeList", employeeList);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        request.setAttribute("currentSort", sortBy);

        // 6. Forward to the View
        request.getRequestDispatcher("admin_dashboard.jsp").forward(request, response);
    }
}