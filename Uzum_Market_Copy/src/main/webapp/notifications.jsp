<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Notifications</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f0f0f0;
            color: #333;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .notification-card {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 16px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 800px; /* Adjusted width to accommodate larger logos */
            margin: 20px auto; /* Center the card */
        }
        .notification-logo {
            width: 120px; /* Increased width */
            height: 60px; /* Adjusted height */
            margin-right: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden; /* Hide overflow */
        }
        .notification-logo img {
            width: 100%;
            height: auto; /* Maintain aspect ratio */
            object-fit: contain; /* Ensure the entire logo fits within the container */
        }
        .notification-content {
            flex: 1;
        }
        .notification-content p {
            margin: 5px 0;
            line-height: 1.4;
        }
        .notification-time {
            font-size: 14px;
            color: #777;
            margin-left: auto;
        }
        .button {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<a href="/app/seller/main" class="button">Back Home</a>

<h1>Your Notifications</h1>

<c:if test="${empty notifications}">
    <p>No notifications available.</p>
</c:if>

<c:forEach var="notification" items="${notifications}">
    <div class="notification-card">
        <div class="notification-logo">
            <img src="/assets/img/uzum_market_logo.png" alt="Logo">
        </div>
        <div class="notification-content">
            <p><strong>${notification.type}</strong></p>
            <p>${notification.message}</p>
        </div>
        <div class="notification-time">
                ${notification.questionSentTime}
        </div>
    </div>
</c:forEach>
</body>
</html>