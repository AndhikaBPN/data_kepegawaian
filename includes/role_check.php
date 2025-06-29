<?php
// Pastikan auth sudah dipanggil sebelum ini
if (!isset($_SESSION['role'])) {
    header("Location: ../index.php?page=login");
    exit;
}

// Fungsi untuk membatasi role
function checkCuti($allowed_roles = []) {
    if (!in_array($_SESSION['role'], $allowed_roles)) {
        header("Location: http://localhost/data_kepegawaian/pages/cuti.php");
    } else {
        
    }
}

function checkAbsensi($allowed_roles = []) {
    if (!in_array($_SESSION['role'], $allowed_roles)) {
        header("Location: http://localhost/data_kepegawaian/pages/absensi.php");
    } else {

    }
}
