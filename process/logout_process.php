<?php
session_start();
session_destroy();

header("Location: http://localhost/data_kepegawaian/index.php");
?>