<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous" />
    <!-- Font Awesome CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(45deg, #9dee52, #f873a7, #23a6d5, #23d5ab);
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

        .hidden {
            display: none;
        }
    </style>
</head>
<body>

<div class="container">
    <h3>Sign Up</h3>
    <form class="registration-form" action="/signup" method="post">
        <input type="text" name="username" class="form-control" placeholder="Username" required><br>
        <input type="email" name="email" class="form-control" placeholder="Email" required><br>
        <input type="password" name="password" class="form-control" placeholder="Password" required><br>
        <button class="btn btn-primary" type="submit">Register</button>
    </form>
    <!-- Confirmation Code Form -->
    <div id="confirmation-section" class="hidden">
        <h4>Enter Confirmation Code</h4>
        <form id="confirmation-form" action="/confirm" method="post">
            <input type="text" name="confirmationCode" class="form-control" placeholder="Confirmation Code" required><br>
            <button class="btn btn-primary" type="submit">Submit</button>
        </form>
    </div>
</div>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4" crossorigin="anonymous"></script>

<script>
    // Handle form submission
    document.querySelector('.registration-form').addEventListener('submit', function(e) {
        e.preventDefault();
        alert('Please enter the confirmation code sent to your email.');
        document.getElementById('confirmation-section').classList.remove('hidden');
    });
</script>

</body>
</html>
