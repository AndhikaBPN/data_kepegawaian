<?php
session_start();

include '../includes/connection.php';
include '../includes/auth.php';
include '../includes/role_check.php';
include '../includes/navbar.php';

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/styles.css">
    <title>Document</title>
</head>
<body>
    <br><br><br><br><br><br><br><br>
    <div class="container">
        <div class="chart">
        <canvas id="barchart"></canvas>
        </div>

        <div class="chart">
        <canvas id="doughnut"></canvas>
        </div>
    </div>
</body>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="../assets/js/chart1.js"></script>
<script src="../assets/js/chart2.js"></script>
</html>