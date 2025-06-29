-- Buat database
CREATE DATABASE IF NOT EXISTS data_kepegawaian;
USE data_kepegawaian;

-- Tabel role
CREATE TABLE role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR(50) NOT NULL,
    deskripsi VARCHAR(255)
);

-- Tabel jabatan
CREATE TABLE jabatan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_jabatan VARCHAR(100) NOT NULL
);

-- Tabel divisi
CREATE TABLE divisi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_divisi VARCHAR(100) NOT NULL
);

-- Tabel user (gabungan data user + pegawai + relasi divisi)
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    id_role INT NOT NULL,
    
    -- Data kepegawaian
    nip VARCHAR(20) NOT NULL UNIQUE,
    nama VARCHAR(100) NOT NULL,
    id_jabatan INT NOT NULL,
    id_divisi INT NOT NULL,
    tgl_lahir DATE NOT NULL,
    jenis_kelamin VARCHAR(10) NOT NULL,
    alamat VARCHAR(255),
    no_hp VARCHAR(20),
    status BOOLEAN DEFAULT TRUE,
    
    FOREIGN KEY (id_role) REFERENCES role(id),
    FOREIGN KEY (id_jabatan) REFERENCES jabatan(id),
    FOREIGN KEY (id_divisi) REFERENCES divisi(id)
);

-- Tabel absensi
CREATE TABLE absensi (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    tanggal DATE NOT NULL,
    status ENUM('Hadir', 'Izin', 'Sakit', 'Alpa') NOT NULL,
    FOREIGN KEY (id_user) REFERENCES user(id)
);

-- Tabel cuti
CREATE TABLE cuti (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    tanggal_pengajuan DATETIME NOT NULL,
    tanggal_mulai DATE NOT NULL,
    tanggal_selesai DATE NOT NULL,
    alasan VARCHAR(255),
    status ENUM('Menunggu', 'Disetujui', 'Ditolak') NOT NULL DEFAULT 'Menunggu',
    FOREIGN KEY (id_user) REFERENCES user(id)
);

ALTER TABLE user
ADD profile VARCHAR(255) DEFAULT NULL;

-- Add Data Role
INSERT INTO role (role, deskripsi) VALUES
    ('Admin', 'Role untuk Admin'),
    ('Pengguna', 'Role untuk Pegawai');

-- Add Data Jabatan
INSERT INTO jabatan (nama_jabatan) VALUES
    ('Manager'),
    ('Staff');

-- Add Data Divisi
INSERT INTO divisi (nama_divisi) VALUES
    ('Developer'),
    ('Quality Assurance');

ALTER TABLE `absensi` 
CHANGE `tanggal` `tanggal` DATETIME NOT NULL;

ALTER TABLE `absensi` DROP `status`;

ALTER TABLE `absensi` 
ADD `status` ENUM('Tepat Waktu','Terlambat') NOT NULL AFTER `tanggal`;

ALTER TABLE `absensi` 
ADD `lama_bekerja` FLOAT NOT NULL AFTER `status`;

ALTER TABLE `absensi` 
CHANGE `tanggal` `absen_masuk` DATETIME NOT NULL;

ALTER TABLE `absensi` 
ADD `absen_keluar` DATETIME NOT NULL AFTER `absen_masuk`;

ALTER TABLE `absensi` 
CHANGE `absen_keluar` `absen_keluar` DATETIME NULL DEFAULT NULL;

ALTER TABLE `cuti` 
CHANGE `status` `status` 
ENUM('Menunggu','Disetujui','Ditolak','Dibatalkan') 
CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Menunggu';