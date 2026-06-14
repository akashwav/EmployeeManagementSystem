<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EMS | Retrieve Password</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-50 flex items-center justify-center min-h-screen p-4">

    <div class="bg-white w-full max-w-md rounded-2xl shadow-xl p-8 border border-gray-100">
        <h2 class="text-2xl font-bold text-gray-900 mb-2">Retrieve Credentials</h2>
        <p class="text-sm text-gray-500 mb-6">Enter your Corporate Email or Employee ID. We will securely email your current access details.</p>

        <% 
            String error = (String) request.getAttribute("errorMessage");
            String message = (String) request.getAttribute("successMessage");
            if (error != null) { 
        %>
            <div class="mb-4 p-3 bg-red-50 text-red-700 text-sm rounded border-l-4 border-red-500"><%= error %></div>
        <% } else if (message != null) { %>
            <div class="mb-4 p-3 bg-green-50 text-green-700 text-sm rounded border-l-4 border-green-500"><%= message %></div>
        <% } %>

        <form action="ForgotPasswordServlet" method="POST" class="space-y-5">
            <div>
                <label class="block text-sm font-medium text-gray-700 mb-1">Identity verification</label>
                <input type="text" name="identifier" required placeholder="Email or ID"
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none transition-all">
            </div>
            
            <button type="submit" class="w-full bg-gray-900 hover:bg-gray-800 text-white font-semibold py-3 px-4 rounded-lg shadow transition-all">
                Send My Credentials
            </button>
        </form>
        
        <div class="mt-6 text-center">
            <a href="login.jsp" class="text-sm font-medium text-blue-600 hover:text-blue-500">Return to Login</a>
        </div>
    </div>

</body>
</html>