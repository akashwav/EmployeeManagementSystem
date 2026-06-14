<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>EMS | My Profile</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style> body { -webkit-font-smoothing: antialiased; } </style>
</head>
<body class="bg-gray-50 flex flex-col min-h-screen">

    <nav class="bg-blue-600 shadow-md">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16 items-center">
                <div class="text-white font-bold text-xl tracking-wider">EMS Portal</div>
                <a href="LogoutServlet" class="bg-blue-700 hover:bg-blue-800 text-white px-3 py-1.5 rounded text-sm transition">Logout</a>
            </div>
        </div>
    </nav>

    <div class="flex-grow flex items-center justify-center p-4">
        <div class="bg-white w-full max-w-md rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
            
            <div class="bg-gray-50 border-b border-gray-100 px-6 py-5 text-center">
                <div class="h-20 w-20 mx-auto bg-blue-600 rounded-full flex items-center justify-center text-white text-3xl font-bold shadow-inner mb-3">
                    ${sessionScope.activeUser.name.substring(0,1)}
                </div>
                <h2 class="text-2xl font-bold text-gray-900">${sessionScope.activeUser.name}</h2>
                <p class="text-sm text-gray-500 mt-1">${sessionScope.activeUser.role} Account</p>
            </div>

            <div class="p-6 space-y-4">
                <div class="flex justify-between items-center py-2 border-b border-gray-50">
                    <span class="text-sm font-medium text-gray-500">Employee ID</span>
                    <span class="text-sm font-semibold text-gray-900 font-mono">${sessionScope.activeUser.employeeId}</span>
                </div>
                <div class="flex justify-between items-center py-2 border-b border-gray-50">
                    <span class="text-sm font-medium text-gray-500">Corporate Email</span>
                    <span class="text-sm font-semibold text-gray-900">${sessionScope.activeUser.email}</span>
                </div>
                <div class="flex justify-between items-center py-2 border-b border-gray-50">
                    <span class="text-sm font-medium text-gray-500">Department</span>
                    <span class="px-2 py-1 bg-blue-50 text-blue-700 rounded-md text-xs font-bold">${sessionScope.activeUser.department}</span>
                </div>
                <div class="flex justify-between items-center py-2">
                    <span class="text-sm font-medium text-gray-500">Base Salary</span>
                    <span class="text-sm font-semibold text-gray-900">₹${sessionScope.activeUser.salary}</span>
                </div>
            </div>
        </div>
    </div>

</body>
</html>