<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS | Add Employee</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body { -webkit-font-smoothing: antialiased; }
    </style>
</head>
<body class="bg-gray-50 text-gray-800">

    <nav class="bg-blue-600 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="text-white font-bold text-xl tracking-wider">EMS Admin</div>
                <div class="flex space-x-4 text-sm">
                    <a href="AdminDashboardServlet" class="text-blue-100 hover:text-white transition">Dashboard</a>
                    <a href="LogoutServlet" class="text-blue-100 hover:text-white transition">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-2xl mx-auto mt-10 p-4">
        <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden">
            <div class="border-b border-gray-100 bg-gray-50 px-6 py-4">
                <h2 class="text-xl font-semibold text-gray-800">Register New Employee</h2>
                <p class="text-sm text-gray-500 mt-1">Credentials will be auto-generated and emailed.</p>
            </div>

            <div class="p-6">
                <% 
                    String error = (String) request.getAttribute("errorMessage");
                    String success = (String) request.getAttribute("successMessage");
                    if (error != null) { 
                %>
                    <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 text-red-700 rounded"><%= error %></div>
                <% } else if (success != null) { %>
                    <div class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 text-green-700 rounded"><%= success %></div>
                <% } %>

                <form action="AddEmployeeServlet" method="POST" class="space-y-6">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                            <input type="text" name="name" required placeholder="John Doe"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Corporate Email</label>
                            <input type="email" name="email" required placeholder="john.doe@company.com"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Department</label>
                            <select name="department" required 
                                    class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all bg-white">
                                <option value="" disabled selected>Select a department...</option>
                                <option value="IT">Information Technology</option>
                                <option value="HR">Human Resources</option>
                                <option value="Finance">Finance</option>
                                <option value="Engineering">Engineering</option>
                                <option value="Sales">Sales</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Base Salary (INR)</label>
                            <input type="number" name="salary" step="0.01" min="0" required placeholder="50000.00"
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                        </div>

                  
                    </div>

                    <div class="flex items-center justify-end space-x-4 pt-4 border-t border-gray-100">
                        <a href="AdminDashboardServlet" class="text-sm font-medium text-gray-600 hover:text-gray-900">Cancel</a>
                        <button type="submit" 
                                class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg shadow-sm transition-all">
                            Create & Notify
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>