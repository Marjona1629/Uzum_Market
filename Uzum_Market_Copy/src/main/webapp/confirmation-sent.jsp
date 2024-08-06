<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation Sent</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
</head>
<body>
<div class="container mt-5">
    <h3>Confirmation Sent</h3>
    <% if (request.getAttribute("message") != null) { %>
    <div class="alert alert-<%= request.getAttribute("messageType") %>">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>
</div>
</body>
</html>
