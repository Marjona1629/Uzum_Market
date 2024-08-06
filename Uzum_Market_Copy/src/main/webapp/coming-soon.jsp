<%--
  Created by IntelliJ IDEA.
  User: test
  Date: 18/07/24
  Time: 20:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ADMIN</title>
    <style>
        body {
            background-image: url("admin-assets/img/coming.jpeg");
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
            margin-top: 150px;
            padding: 10px 20px;
            background-color: #6f3cce; /* Bootstrap primary color */
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }
    </style>
</head>
<body>


<a href="#" onclick="goBack()" class="home-button">Back</a>
<script>
    function goBack() {
        window.history.back();
    }
</script>

</body>
</html>
