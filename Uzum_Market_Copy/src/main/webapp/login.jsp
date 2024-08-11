<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous"/>
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"
          integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #b699c5, #9d6fb7, #7f24b4, #9644a8);
            background-size: 400% 400%;
            animation: gradientAnimation 15s ease infinite;
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        @keyframes gradientAnimation {
            0% {
                background-position: 0% 50%;
            }
            50% {
                background-position: 100% 50%;
            }
            100% {
                background-position: 0% 50%;
            }
        }

        .container {
            width: 400px;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.9);
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .container h3 {
            margin-bottom: 20px;
        }

        .form-control {
            margin-bottom: 10px;
        }

        .btn-primary {
            background-color: #4CAF50;
            border: none;
            border-radius: 5px;
            padding: 12px 20px;
            cursor: pointer;
            width: 100%;
        }

        .btn-primary:hover {
            background-color: #45a049;
        }

        .forgot-password, .create-account {
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="container">
    <h3>Login</h3>
    <form action="/login" method="post">
        <input type="text" name="username" class="form-control" placeholder="Username" required
               value="<%= request.getAttribute("username") != null ? request.getAttribute("username") : "" %>"><br>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
        <div class="forgot-password">
            <a href="forgot-password.jsp" class="btn btn-link">Forgot Password?</a>
        </div>
        <button class="btn btn-primary" type="submit">Login</button>
        <div class="create-account">
            <p>Don't have an account? <a href="/signup" class="btn btn-link">Create Account</a></p>
        </div>
    </form>
</div>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
        crossorigin="anonymous"></script>

<script>
    <% if (request.getAttribute("errorMessage") != null) { %>
    alert("<%= request.getAttribute("errorMessage") %>");
    <% } %>
</script>

</body>
</html>
