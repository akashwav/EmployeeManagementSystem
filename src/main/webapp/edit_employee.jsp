<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS | Edit Employee</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 text-gray-800">

    <nav class="bg-blue-600 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="text-white font-bold text-xl tracking-wider">EMS Admin</div>
                <div class="flex space-x-4">
                    <a href="AdminDashboardServlet" class="text-blue-100 hover:text-white transition">Dashboard</a>
                    <a href="LogoutServlet" class="text-blue-100 hover:text-white transition">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="max-w-2xl mx-auto mt-10 p-4">
        <div class="bg-white rounded-xl shadow-lg border border-gray-100 overflow-hidden">
            <div class="border-b border-gray-100 bg-gray-50 px-6 py-4">
                <h2 class="text-xl font-semibold text-gray-800">Edit Employee Profile</h2>
            </div>

            <div class="p-6">
                <form action="EditEmployeeServlet" method="POST" class="space-y-6">
                    
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div class="md:col-span-2">
                            <label class="block text-sm font-medium text-gray-700 mb-1">Employee ID</label>
                            <input type="text" name="employeeId" value="${employeeToEdit.employeeId}" readonly
                                   class="w-full px-4 py-2 border border-gray-200 rounded-lg bg-gray-100 text-gray-500 outline-none cursor-not-allowed">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Full Name</label>
                            <input type="text" name="name" value="${employeeToEdit.name}" required 
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Corporate Email</label>
                            <input type="email" name="email" value="${employeeToEdit.email}" required 
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Department</label>
                            <select name="department" required class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none bg-white">
                                <option value="IT" ${employeeToEdit.department == 'IT' ? 'selected' : ''}>Information Technology</option>
                                <option value="HR" ${employeeToEdit.department == 'HR' ? 'selected' : ''}>Human Resources</option>
                                <option value="Finance" ${employeeToEdit.department == 'Finance' ? 'selected' : ''}>Finance</option>
                                <option value="Engineering" ${employeeToEdit.department == 'Engineering' ? 'selected' : ''}>Engineering</option>
                                <option value="Sales" ${employeeToEdit.department == 'Sales' ? 'selected' : ''}>Sales</option>
                            </select>
                        </div>

                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Base Salary (INR)</label>
                            <input type="number" name="salary" value="${employeeToEdit.salary}" step="0.01" min="0" required 
                                   class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 outline-none">
                        </div>
                    </div>

                    <div class="flex items-center justify-end space-x-4 pt-4 border-t border-gray-100">
                        <a href="AdminDashboardServlet" class="text-sm font-medium text-gray-600 hover:text-gray-900">Cancel</a>
                        <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 px-6 rounded-lg shadow-sm transition-all">
                            Save Changes
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>