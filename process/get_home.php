<?php
session_start();
include '../includes/connection.php';

function getGender() {
    global $conn;
    $query = "SELECT jenis_kelamin, COUNT(*) AS total FROM user WHERE status = 1 GROUP BY jenis_kelamin";
    $result = mysqli_query($conn, $query);

    $data = [
        'laki-laki' => 0,
        'perempuan' => 0
    ];
    
    while($row = mysqli_fetch_assoc($result)) {
        $gender = strtolower($row['jenis_kelamin']);
        if($gender === "laki-laki") {
            $data['laki-laki'] = (int)$row['total'];
        } elseif($gender === "perempuan") {
            $data['perempuan'] = (int)$row['total'];
        }
    }

    return $data;
}

function getAbsensi() {
    global $conn;

    $start_date = date('Y-m-01');
    $end_date   = date('Y-m-t');

    $queryAbsen = "SELECT status, COUNT(*) AS total FROM absensi WHERE DATE(absen_masuk) BETWEEN '$start_date' AND '$end_date' GROUP BY status";
    $queryCuti = "SELECT COUNT(*) AS total FROM cuti WHERE status = 'Disetujui' AND tanggal_mulai <= '2025-07-31' AND tanggal_selesai >='2025-07-01';";
    $resultAbsen = mysqli_query($conn, $queryAbsen);
    $resultCuti = mysqli_query($conn, $queryCuti);
    
    $data = [
        'tepat waktu' => 0,
        'terlambat' => 0,
        'cuti' => 0
    ];

    while ($row = mysqli_fetch_assoc($resultAbsen)) {
        $ket = strtolower($row['status']);
        if ($ket === 'tepat waktu') {
            $data['tepat waktu'] = (int)$row['total'];
        } elseif ($ket === 'terlambat') {
            $data['terlambat'] = (int)$row['total'];
        }

        if ($rowCuti = mysqli_fetch_assoc($resultCuti)) {
            $data['cuti'] = (int)$rowCuti['total'];
        }
    }


    return $data;
}

$type = $_GET['type'] ?? '';
switch ($type) {
    case 'gender':
        echo json_encode(['data' => getGender()]);
        break;
    case 'absensi':
        echo json_encode(['data' => getAbsensi()]);
        break;
    default:
        echo json_encode([]);
        break;
}

?>