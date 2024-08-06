<%@ page session="true" %>

<%
    // Invalidate the session, remove all session attributes
    session.invalidate();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logged Out</title>
    <style>
        body {
            background-image: url("admin-assets/img/logout.jpg");
            background-size: cover; /* Ensure the background image covers the entire page */
            background-position: center; /* Center the background image */
            height: 100vh; /* Set full viewport height */
            margin: 0; /* Remove default margin */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            text-align: left;
            color: white; /* Text color for contrast */
            font-family: Arial, sans-serif; /* Optional: Choose a suitable font */
        }
        .home-button {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff; /* Bootstrap primary color */
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>
<h1 style="color: #3f91d9; ">You have been successfully logged out.</h1>
<a href="home.jsp" class="home-button">Home</a>
</body>
</html>
