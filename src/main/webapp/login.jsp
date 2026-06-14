<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>EMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Custom overrides for specific mobile smoothing */
        body { -webkit-font-smoothing: antialiased; }
        .glass-panel {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
    </style>
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen p-4">

    <div class="glass-panel w-full max-w-md rounded-2xl shadow-xl overflow-hidden border border-gray-100">
        
        <div class="bg-blue-600 p-6 text-center">
            <h1 class="text-2xl font-bold text-white tracking-wide">Welcome to EMS</h1>
            <p class="text-blue-100 text-sm mt-1">Employee Management System</p>
        </div>

        <div class="p-8">
            <% 
                String error = (String) request.getAttribute("errorMessage");
                String message = (String) request.getAttribute("successMessage");
                if (error != null) { 
            %>
                <div class="mb-4 p-3 bg-red-50 border-l-4 border-red-500 text-red-700 text-sm rounded">
                    <%= error %>
                </div>
            <% } else if (message != null) { %>
                <div class="mb-4 p-3 bg-green-50 border-l-4 border-green-500 text-green-700 text-sm rounded">
                    <%= message %>
                </div>
            <% } %>

            <form action="LoginServlet" method="POST" class="space-y-5">
                
                <div>
                    <label for="role" class="block text-sm font-medium text-gray-700 mb-1">Access Level</label>
                    <select id="role" name="role" required 
                            class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all bg-white">
                        <option value="Employee">Employee</option>
                        <option value="Admin">Administrator</option>
                    </select>
                </div>

                <div>
                    <label for="identifier" class="block text-sm font-medium text-gray-700 mb-1">Employee ID or Email</label>
                    <input type="text" id="identifier" name="identifier" required placeholder="e.g. E0A1001 or name@company.com"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password</label>
                    <input type="password" id="password" name="password" required placeholder="••••••••"
                           class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
                </div>

                <div class="flex items-center justify-between mt-2">
                    <div class="text-sm">
                        <a href="forgot_password.jsp" class="font-medium text-blue-600 hover:text-blue-500 transition-colors">
                            Retrieve Password
                        </a>
                    </div>
                </div>

                <button type="submit" 
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 px-4 rounded-lg shadow-md transition-all duration-200 transform hover:-translate-y-0.5 mt-4">
                    Authenticate
                </button>
            </form>
        </div>
    </div>

</body>
</html>