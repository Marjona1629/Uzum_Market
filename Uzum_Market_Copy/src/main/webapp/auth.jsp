<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Authentication Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            margin: 0;
            background: linear-gradient(to right, #b480d2, #904bb7);
        }

        form {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: #fff;
            width: 100%;
            max-width: 400px;
            margin-top: 20px;
        }

        div {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
        }

        .button-group {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .button-group a {
            display: block;
            margin-top: 10px;
            color: #28a745;
            text-decoration: none;
            font-size: 16px;
        }

        .button-group a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<c:set var="action_path" value="/sign-in"></c:set>
<c:set var="button_val" value="Sign In"></c:set>
<c:set var="uri_to" value="/sign-up"></c:set>

<c:if test="${sign}">
    <c:set var="action_path" value="/sign-up"></c:set>
    <c:set var="button_val" value="Sign Up"></c:set>
    <c:set var="uri_to" value="/sign-in"></c:set>
</c:if>

<form action="${action_path}" method="post">
    <c:if test="${sign}">
        <div>
            <label for="username">Username</label>
            <input name="username" type="text" id="username" placeholder="Enter your username">
        </div>
    </c:if>
    <div>
        <label for="email">Email</label>
        <input name="email" type="email" id="email" placeholder="Enter your email">
    </div>
    <div>
        <label for="password">Password</label>
        <input name="password" type="password" id="password" placeholder="Enter your password">
    </div>
    <div class="button-group">
        <button type="submit"><c:out value="${button_val}"/></button>
        <a href="${uri_to}"><c:out value="${sign ? 'Sign In' : 'Sign Up'}"/></a>
    </div>
</form>
</body>
</html>
