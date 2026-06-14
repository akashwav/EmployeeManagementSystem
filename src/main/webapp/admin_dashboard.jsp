<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

    <nav class="bg-blue-600 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="text-white font-bold text-xl tracking-wider">EMS Admin</div>
                <div class="flex space-x-4 items-center">
                    <span class="text-blue-200 text-sm hidden sm:block">Welcome, ${sessionScope.activeUser.name}</span>
                    <a href="LogoutServlet" class="bg-blue-700 hover:bg-blue-800 text-white px-3 py-1.5 rounded text-sm transition">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <c:if test="${not empty sessionScope.flashMessage}">
            <div class="mb-4 p-4 bg-green-50 border-l-4 border-green-500 text-green-700 rounded shadow-sm transition-all">
                ${sessionScope.flashMessage}
            </div>
            <c:remove var="flashMessage" scope="session" />
        </c:if>
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold text-gray-900">Employee Directory</h1>
            <a href="add_employee.jsp" class="bg-green-600 hover:bg-green-700 text-white font-semibold py-2 px-4 rounded shadow transition-all flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4"></path></svg>
                Add New Employee
            </a>
        </div>

        <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden">
            
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-50 border-b border-gray-200">
                            <th class="p-4 text-sm font-semibold text-gray-600">
                                <a href="AdminDashboardServlet?page=${currentPage}&sort=employee_id" class="hover:text-blue-600">ID &#8597;</a>
                            </th>
                            <th class="p-4 text-sm font-semibold text-gray-600">
                                <a href="AdminDashboardServlet?page=${currentPage}&sort=name" class="hover:text-blue-600">Name &#8597;</a>
                            </th>
                            <th class="p-4 text-sm font-semibold text-gray-600">Email</th>
                            <th class="p-4 text-sm font-semibold text-gray-600">
                                <a href="AdminDashboardServlet?page=${currentPage}&sort=department" class="hover:text-blue-600">Department &#8597;</a>
                            </th>
                            <th class="p-4 text-sm font-semibold text-gray-600">
                                <a href="AdminDashboardServlet?page=${currentPage}&sort=salary" class="hover:text-blue-600">Salary &#8597;</a>
                            </th>
                            <th class="p-4 text-sm font-semibold text-gray-600 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-100">
                        <c:forEach var="emp" items="${employeeList}">
                            <tr class="hover:bg-gray-50 transition-colors">
                                <td class="p-4 text-sm text-gray-700 font-mono">${emp.employeeId}</td>
                                <td class="p-4 text-sm font-medium text-gray-900">${emp.name}</td>
                                <td class="p-4 text-sm text-gray-500">${emp.email}</td>
                                <td class="p-4 text-sm">
                                    <span class="px-2 py-1 bg-blue-50 text-blue-700 rounded-full text-xs font-semibold">${emp.department}</span>
                                </td>
                                <td class="p-4 text-sm text-gray-700">₹${emp.salary}</td>
                                <td class="p-4 text-sm text-right space-x-2">
								    <a href="EditEmployeeServlet?id=${emp.employeeId}" class="text-indigo-600 hover:text-indigo-900 font-medium transition-colors">Edit</a>
								    
								    <c:choose>
								        <c:when test="${emp.employeeId ne sessionScope.activeUser.employeeId}">
								            <a href="DeleteEmployeeServlet?id=${emp.employeeId}" class="text-red-600 hover:text-red-900 font-medium transition-colors ml-2" onclick="return confirm('Are you sure you want to remove this employee?');">Delete</a>
								        </c:when>
								        <c:otherwise>
								            <span class="text-gray-400 font-medium cursor-not-allowed ml-2" title="Cannot delete active admin">Admin</span>
								        </c:otherwise>
								    </c:choose>
							</td>
                            </tr>
                        </c:forEach>
                        
                        <c:if test="${empty employeeList}">
                            <tr>
                                <td colspan="6" class="p-8 text-center text-gray-500">No employee records found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>

            <c:if test="${noOfPages > 1}">
                <div class="bg-gray-50 px-4 py-3 border-t border-gray-200 flex items-center justify-between sm:px-6">
                    <div class="flex-1 flex justify-between sm:hidden">
                        <a href="AdminDashboardServlet?page=${currentPage - 1}&sort=${currentSort}" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 ${currentPage == 1 ? 'pointer-events-none opacity-50' : ''}">Previous</a>
                        <a href="AdminDashboardServlet?page=${currentPage + 1}&sort=${currentSort}" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 ${currentPage == noOfPages ? 'pointer-events-none opacity-50' : ''}">Next</a>
                    </div>
                    <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
                        <div>
                            <p class="text-sm text-gray-700">Showing page <span class="font-medium">${currentPage}</span> of <span class="font-medium">${noOfPages}</span></p>
                        </div>
                        <div>
                            <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                                <c:forEach begin="1" end="${noOfPages}" var="i">
                                    <a href="AdminDashboardServlet?page=${i}&sort=${currentSort}" 
                                       class="relative inline-flex items-center px-4 py-2 border text-sm font-medium ${currentPage eq i ? 'z-10 bg-blue-50 border-blue-500 text-blue-600' : 'bg-white border-gray-300 text-gray-500 hover:bg-gray-50'}">
                                        ${i}
                                    </a>
                                </c:forEach>
                            </nav>
                        </div>
                    </div>
                </div>
            </c:if>

        </div>
    </div>
</body>
</html>