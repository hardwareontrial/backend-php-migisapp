-- --------------------------------------------------------
-- Host:                         192.168.100.227
-- Server version:               10.5.19-MariaDB-1:10.5.19+maria~ubu2004-log - mariadb.org binary distribution
-- Server OS:                    debian-linux-gnu
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_certificates
CREATE TABLE IF NOT EXISTS `app_elearning_certificates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) NOT NULL,
  `signer_name` varchar(255) NOT NULL,
  `signer_position` varchar(255) DEFAULT NULL,
  `folder_name` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_materials
CREATE TABLE IF NOT EXISTS `app_elearning_materials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `m_title` text NOT NULL,
  `dept_id` int(10) unsigned NOT NULL,
  `m_level` int(11) NOT NULL,
  `m_duration` int(11) DEFAULT NULL,
  `m_desc` text NOT NULL,
  `slug` text NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `isactive` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_material_files
CREATE TABLE IF NOT EXISTS `app_elearning_material_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `m_id` int(10) unsigned NOT NULL,
  `m_file` longtext NOT NULL,
  `view_count` int(11) NOT NULL,
  `download_count` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_questions
CREATE TABLE IF NOT EXISTS `app_elearning_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `material_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `nilai_min` int(11) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `level` int(11) NOT NULL,
  `isactive` int(11) NOT NULL,
  `slug` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_question_collections
CREATE TABLE IF NOT EXISTS `app_elearning_question_collections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `questions_id` int(11) NOT NULL,
  `question` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`question`)),
  `answer_options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`answer_options`)),
  `answer_key` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_question_status_uploads
CREATE TABLE IF NOT EXISTS `app_elearning_question_status_uploads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `material_id` int(10) unsigned NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `question_collection_id` int(10) unsigned DEFAULT NULL,
  `status` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_schedules
CREATE TABLE IF NOT EXISTS `app_elearning_schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `nilai_min` int(11) NOT NULL,
  `duration` int(11) NOT NULL,
  `question_id` int(10) unsigned NOT NULL,
  `type` int(11) NOT NULL,
  `startdate_exam` datetime NOT NULL,
  `enddate_exam` datetime NOT NULL,
  `note` text NOT NULL,
  `participant_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`participant_id`)),
  `questions_count` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `isactive` int(11) NOT NULL,
  `certificate_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_elearning_userdata_exams
CREATE TABLE IF NOT EXISTS `app_elearning_userdata_exams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `schedule_id` int(11) NOT NULL,
  `user_nik` varchar(255) NOT NULL,
  `questions_pattern` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`questions_pattern`)),
  `answers_user` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`answers_user`)),
  `user_start_exam` datetime DEFAULT NULL,
  `user_end_exam` datetime DEFAULT NULL,
  `timeleft_seconds` int(11) DEFAULT NULL,
  `isdone` int(11) NOT NULL COMMENT '1: Selesai, 2: Belum Dikerjakan, 3: Proses',
  `ispassed` int(11) NOT NULL COMMENT '1: Passed, 2: NotPassed',
  `score` int(11) NOT NULL DEFAULT 0,
  `certificate` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_gainventaris
CREATE TABLE IF NOT EXISTS `app_gainventaris` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kd_brg` varchar(255) NOT NULL,
  `nama_brg` varchar(255) NOT NULL,
  `tgl_beli` date NOT NULL,
  `harga` int(11) DEFAULT NULL,
  `toko` varchar(255) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `serialnumber` varchar(255) DEFAULT NULL,
  `pemilik_id` int(11) NOT NULL,
  `merk_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `lokasi_id` int(11) NOT NULL,
  `user1_id` int(11) DEFAULT NULL,
  `user2_id` int(11) DEFAULT NULL,
  `dept_user` int(11) DEFAULT NULL,
  `mtc_note` varchar(255) DEFAULT NULL,
  `qrcode` varchar(255) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=712 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_gainventaris_app_user
CREATE TABLE IF NOT EXISTS `app_gainventaris_app_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `app_gainventaris_id` int(10) unsigned NOT NULL,
  `app_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_gainventaris_app_user: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_gainventaris_logs
CREATE TABLE IF NOT EXISTS `app_gainventaris_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gainventaris_id` int(10) unsigned NOT NULL,
  `action` int(11) NOT NULL,
  `n_status_id` int(11) DEFAULT NULL,
  `o_status_id` int(11) DEFAULT NULL,
  `n_lokasi_id` int(11) DEFAULT NULL,
  `o_lokasi_id` int(11) DEFAULT NULL,
  `n_user1_id` int(11) DEFAULT NULL,
  `o_user1_id` int(11) DEFAULT NULL,
  `n_user2_id` int(11) DEFAULT NULL,
  `o_user2_id` int(11) DEFAULT NULL,
  `n_dept_user` int(11) DEFAULT NULL,
  `o_dept_user` int(11) DEFAULT NULL,
  `n_nama_brg` varchar(255) DEFAULT NULL,
  `o_nama_brg` varchar(255) DEFAULT NULL,
  `n_tgl_beli` date DEFAULT NULL,
  `o_tgl_beli` date DEFAULT NULL,
  `n_toko` varchar(255) DEFAULT NULL,
  `o_toko` varchar(255) DEFAULT NULL,
  `n_harga` int(11) DEFAULT NULL,
  `o_harga` int(11) DEFAULT NULL,
  `n_serialnumber` varchar(255) DEFAULT NULL,
  `o_serialnumber` varchar(255) DEFAULT NULL,
  `n_merk_id` int(11) DEFAULT NULL,
  `o_merk_id` int(11) DEFAULT NULL,
  `n_spesifikasi` varchar(255) DEFAULT NULL,
  `o_spesifikasi` varchar(255) DEFAULT NULL,
  `n_mtc_note` varchar(255) DEFAULT NULL,
  `o_mtc_note` varchar(255) DEFAULT NULL,
  `n_active` int(11) DEFAULT NULL,
  `o_active` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1400 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_gainventaris_sells
CREATE TABLE IF NOT EXISTS `app_gainventaris_sells` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ex_kd_brg` varchar(255) NOT NULL,
  `nama_brg` varchar(255) NOT NULL,
  `tgl_beli` date NOT NULL,
  `harga_beli` int(11) DEFAULT NULL,
  `toko` varchar(255) DEFAULT NULL,
  `spesifikasi` text DEFAULT NULL,
  `serialnumber` varchar(255) DEFAULT NULL,
  `pemilik` varchar(255) NOT NULL,
  `merk` varchar(255) NOT NULL,
  `harga_jual` int(11) DEFAULT NULL,
  `history` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`history`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_general_listlocation
CREATE TABLE IF NOT EXISTS `app_general_listlocation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_general_listmerk
CREATE TABLE IF NOT EXISTS `app_general_listmerk` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_hr_attendaces
CREATE TABLE IF NOT EXISTS `app_hr_attendaces` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pin` varchar(255) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `scan_date` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6486 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_hr_attendace_logs
CREATE TABLE IF NOT EXISTS `app_hr_attendace_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `startdate` text DEFAULT NULL,
  `enddate` text DEFAULT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=221 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_hr_departments
CREATE TABLE IF NOT EXISTS `app_hr_departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `isactive` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_hr_departments: ~8 rows (approximately)
INSERT INTO `app_hr_departments` (`id`, `name`, `parent_id`, `isactive`, `created_at`, `updated_at`) VALUES
	(1, 'CORPORATE', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(2, 'PLANT', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(3, 'SALES (WEST)', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(4, 'SALES (EAST)', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(5, 'LOGISTIC', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(6, 'MANAGEMENT SYSTEM', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(7, 'FAT', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(8, 'HRM&GA', NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00');

-- Dumping structure for table stg_mig_db_migisapp101.app_hr_positions
CREATE TABLE IF NOT EXISTS `app_hr_positions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `dept_id` bigint(20) DEFAULT NULL,
  `sub_dept_id` bigint(20) unsigned DEFAULT NULL,
  `level` int(11) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `isactive` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_hr_positions: ~59 rows (approximately)
INSERT INTO `app_hr_positions` (`id`, `parent_id`, `name`, `dept_id`, `sub_dept_id`, `level`, `user_id`, `isactive`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Root', NULL, NULL, 1, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(2, 58, 'PLANT MANAGER', 2, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(3, 2, 'QC SUPERVISOR', 2, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(4, 2, 'UTILITY SUPERVISOR', 2, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(5, 2, 'PRODUCTION SUPERVISOR', 2, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(6, 2, 'TECHNICAL DESIGN OFFICER', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(7, 3, 'QUALITY CONTROL STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(8, 4, 'UTILITY WELDER STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(9, 4, 'UTILITY OPR. STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(10, 4, 'UTILITY SUPPORT STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(11, 5, 'DRYICE PROD. OPR. STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(12, 5, 'CO2 PROD. OPR. STAFF', 2, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(13, 58, 'SALES MANAGER (WEST)', 3, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(14, 13, 'SALES OPERATION SUPERVISOR', 3, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(15, 14, 'GEN. ADMINISTRATION STAFF', 3, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(16, 14, 'HSE & TECHNICAL SUPPORT STAFF', 3, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(17, 14, 'QC & INVENTORY STAFF', 3, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(18, 14, 'TRANSPORTER DRIVER', 3, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(19, 58, 'SALES MANAGER (EAST)', 4, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(20, 19, 'SALES SUPERVISOR', 4, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(21, 19, 'DISTRIBUTION OPR. SUPERVISOR', 4, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(22, 20, 'SALES STAFF', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(23, 20, 'SALES ADM. STAFF', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(24, 20, 'TECHNICAL SUPPORT', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(25, 21, 'TRANSPORTER MECHANICAL STAFF', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(26, 21, 'REGULAR DRIVER', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(27, 21, 'TRANSPORTER DRIVER', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(28, 21, 'TRANSPORTER CO-DRIVER', 4, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(29, 58, 'LOGISTIC MANAGER', 5, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(30, 29, 'PURCHASING SUPERVISOR', 5, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(31, 29, 'WAREHOUSE SUPERVISOR', 5, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(32, 30, 'PURCHASING STAFF', 5, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(33, 31, 'WAREHOUSE STAFF', 5, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(34, 58, 'MANAGEMENT SYSTEM MANAGER', 6, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(35, 34, 'QUALITY SYSTEM OFFICER', 6, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(36, 34, 'HSE OFFICER', 6, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(37, 58, 'FINANCE ACCOUNTING & TAX MANAGER', 7, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(38, 37, 'FINANCE ACCOUNTING & TAX SUPERVISOR', 7, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(39, 38, 'ACCOUNT RECEIVEABLE (AR) STAFF', 7, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(40, 38, 'FINANCE STAFF', 7, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(41, 38, 'ACCOUNT PAYABLE (AP) STAFF', 7, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(42, 38, 'CONTROLLER STAFF', 7, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(43, 38, 'CASHIER STAFF', 7, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(44, 58, 'HRM & GA MANAGER', 8, NULL, 4, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(45, 44, 'HRM SUPERVISOR', 8, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(46, 44, 'GA SUPERVISOR', 8, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(47, 44, 'IT SUPERVISOR', 8, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(48, 44, 'SENIOR SECURITY', 8, NULL, 5, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(49, 45, 'HRM STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(50, 46, 'CORPORATE AFFAIR STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(51, 46, 'GENERAL AFFAIR STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(52, 46, 'PLANT HOUSEKEEPING STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(53, 46, 'OFFICE HOUSEKEEPING STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(54, 46, 'BOD/BOC DRIVER', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(55, 47, 'IT STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(56, 48, 'SECURITY STAFF', 8, NULL, 6, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(57, 1, 'DIRECTOR', 1, NULL, 2, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(58, 57, 'GENERAL MANAGER', 1, NULL, 3, NULL, '1', '2022-07-24 23:00:00', '2022-07-24 23:00:00'),
	(59, 47, 'IT SENIOR STAFF', 8, NULL, 6, NULL, '1', '2022-11-03 18:00:00', '2022-11-03 18:00:00');

-- Dumping structure for table stg_mig_db_migisapp101.app_hr_sub_departments
CREATE TABLE IF NOT EXISTS `app_hr_sub_departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `dept_id` bigint(20) unsigned DEFAULT NULL,
  `position_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_hr_sub_departments: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_phonebooks
CREATE TABLE IF NOT EXISTS `app_phonebooks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company_address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1006 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_phonebook_details
CREATE TABLE IF NOT EXISTS `app_phonebook_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phonebook_id` int(11) NOT NULL,
  `number` varchar(255) DEFAULT NULL,
  `pic` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_phonebook_extensions
CREATE TABLE IF NOT EXISTS `app_phonebook_extensions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `ext` int(11) NOT NULL,
  `lokasi_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_phonebook_extensions: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_phonebook_logs
CREATE TABLE IF NOT EXISTS `app_phonebook_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `phonebook_id` int(11) NOT NULL,
  `phonebook_type` int(11) NOT NULL,
  `activity` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_rp_model_has_permissions
CREATE TABLE IF NOT EXISTS `app_rp_model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `user_nik` int(11) NOT NULL,
  PRIMARY KEY (`permission_id`,`user_nik`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`user_nik`,`model_type`),
  CONSTRAINT `app_rp_model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `app_rp_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_rp_model_has_permissions: ~362 rows (approximately)
INSERT INTO `app_rp_model_has_permissions` (`permission_id`, `model_type`, `user_nik`) VALUES
	(1, 'App\\Models\\API\\Auth\\AppUserLogin', 9000901),
	(1, 'App\\Models\\API\\Auth\\AppUserLogin', 9000902),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1000061),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1000067),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010074),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010075),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010078),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010079),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010080),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010081),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010082),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010083),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1010084),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1020089),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1020098),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1020101),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1020102),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1030103),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1030104),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1030106),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1050114),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1070121),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1070122),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1070123),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1080126),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1090133),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1090137),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1110142),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1120144),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1140177),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960009),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960012),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960018),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960019),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960022),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1960023),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970032),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970035),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970038),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970039),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970044),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970049),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970050),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1970052),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1980056),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1990058),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 1990059),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2100140),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2120145),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2120146),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2120149),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2120151),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130154),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130158),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130162),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130163),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130164),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2130166),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2140173),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2140176),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2140178),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2140183),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2140184),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2160200),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2160201),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2160209),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2160210),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2160212),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2170218),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2170228),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2170232),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2170235),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2180236),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2180239),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2180240),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2180242),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190247),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190248),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190252),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190254),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190256),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190257),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190258),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190259),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190260),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2190261),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200264),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200265),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200268),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200271),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200272),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200273),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2200275),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210276),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210277),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210278),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210279),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210280),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210281),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2210284),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2220289),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2220290),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2220291),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2220292),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 2230297),
	(2, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(37, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(38, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(39, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(40, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(41, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(42, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(43, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(44, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(45, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(46, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(47, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(48, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804),
	(49, 'App\\Models\\API\\Auth\\AppUserLogin', 8000804);

-- Dumping structure for table stg_mig_db_migisapp101.app_rp_model_has_roles
CREATE TABLE IF NOT EXISTS `app_rp_model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `user_nik` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_nik`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`user_nik`,`model_type`),
  CONSTRAINT `app_rp_model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `app_rp_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_rp_model_has_roles: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_rp_permissions
CREATE TABLE IF NOT EXISTS `app_rp_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `text` varchar(255) NOT NULL,
  `group_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_rp_permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_rp_permissions: ~49 rows (approximately)
INSERT INTO `app_rp_permissions` (`id`, `name`, `guard_name`, `description`, `text`, `group_name`, `created_at`, `updated_at`) VALUES
	(1, 'manage.all', 'web', 'Semua Akses App', '*', 'WildCard', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(2, 'read.Auth', 'web', 'Akses App tanpa otorisasi', 'App', 'General', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(3, 'read.ACL', 'web', 'Akses App dengan otorisasi', 'App Auth', 'General', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(4, 'read.AppTodo', 'web', 'Akses masuk AppTodo', 'AppTodo Access', 'AppTodo', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(5, 'create.AppTodo', 'web', 'Akses membuat Task', 'AppTodo Create', 'AppTodo', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(6, 'read.AppPhoneExt', 'web', 'Akses aplikasi phonebook internal', 'AppPhoneExtension Access', 'AppPhoneExtension', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(7, 'create.AppPhoneExt', 'web', 'Akses tambah data phonebook internal', 'AppPhoneExtension Create', 'AppPhoneExtension', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(8, 'edit.AppPhoneExt', 'web', 'Akses update data phonebook internal', 'AppPhoneExtension Edit', 'AppPhoneExtension', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(9, 'delete.AppPhoneExt', 'web', 'Akses hapus data phonebook internal', 'AppPhoneExtension Delete', 'AppPhoneExtension', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(10, 'read.AppPhonebook', 'web', 'Akses aplikasi phonebook eksternal', 'AppPhonebook Access', 'AppPhonebook', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(11, 'create.AppPhonebook', 'web', 'Akses tambah data phonebook eksternal', 'AppPhonebook Create', 'AppPhonebook', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(12, 'edit.AppPhonebook', 'web', 'Akses update data phonebook eksternal', 'AppPhonebook Edit', 'AppPhonebook', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(13, 'read.AppDelivery', 'web', 'Akses aplikasi surat jalan', 'AppDelivery Access', 'AppDelivery', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(14, 'create.AppDelivery', 'web', 'Akses input data surat jalan', 'AppDelivery Create', 'AppDelivery', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(15, 'edit.AppDelivery', 'web', 'Akses update data surat jalan', 'AppDelivery Update', 'AppDelivery', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(16, 'invoice.AppDelivery', 'web', 'Akses update invoice data surat jalan', 'AppDelivery Post Invoice', 'AppDelivery', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(17, 'read.AppInventaris', 'web', 'Akses aplikasi inventaris', 'AppInventaris Access', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(18, 'create.AppInventaris', 'web', 'Akses input data inventaris', 'AppInventaris Create', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(19, 'edit.AppInventaris', 'web', 'Akses update data inventaris', 'AppInventaris Update', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(20, 'archieve.AppInventaris', 'web', 'Akses \'tandai di gudang\' untuk barang', 'AppInventaris Archieve Goods', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(21, 'sell.AppInventaris', 'web', 'Akses \'tandai di jual\' untuk barang', 'AppInventaris Sell Goods', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(22, 'export.AppInventaris', 'web', 'Akses print dan export QR atau List Data', 'AppInventaris Print Qr & List', 'AppInventaris', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(23, 'read.AppUserMgt', 'web', 'Akses aplikasi User Management', 'AppUserManagement Access', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(24, 'create.AppUserMgt', 'web', 'Akses input data user', 'AppUserManagement Create', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(25, 'switchlogin.AppUserMgt', 'web', 'Akses switch on/off Login User', 'AppUserManagement Switch Login', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(26, 'switchuser.AppUserMgt', 'web', 'Akses switch aktif/non-aktif User', 'AppUserManagement Switch User', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(27, 'edit.AppUserMgt', 'web', 'Akses Update data user', 'AppUserManagement Update', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(28, 'editinfo.AppUserMgt', 'web', 'Akses Update Info User', 'AppUserManagement Update Info-User', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(29, 'editaccount.AppUserMgt', 'web', 'Akses Update Account User', 'AppUserManagement Update Info-Account', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(30, 'editpermission.AppUserMgt', 'web', 'Akses Update Permission User', 'AppUserManagement Update Info-Permission', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(31, 'resetpassuser.AppUserMgt', 'web', 'Akses Reset Account User', 'AppUserManagement Reset Password User', 'AppUserManagement', '2022-07-11 00:00:00', '2022-07-11 00:00:00'),
	(32, 'export.AppDelivery', 'web', 'Akses Ekspor Data Surat Jalan ke XLSX', 'AppDelivery Export', 'AppDelivery', '2022-08-18 00:00:00', '2022-08-18 00:00:00'),
	(33, 'delete.AppPhonebook', 'web', 'Akses update data phonebook eksternal', 'AppPhonebook Delete', 'AppPhonebook', '2022-09-11 00:00:00', '2022-09-11 00:00:00'),
	(34, 'read.AppHRPresence', 'web', 'Akses HR - Monitoring Absensi', 'AppHR Presence', 'AppHR', '2022-11-30 04:00:00', '2022-11-30 04:00:00'),
	(35, 'read.AppHRPosition', 'web', 'Akses HR - Jabatan Karyawan', 'AppHR Position', 'AppHR', '2022-11-30 04:00:00', '2022-11-30 04:00:00'),
	(36, 'edit.AppHRPosition', 'web', 'Akses HR - Edit Jabatan Karyawan', 'AppHR Position Edit', 'AppHR', '2022-11-30 04:00:00', '2022-11-30 04:00:00'),
	(37, 'read.AppOKM', 'web', 'Akses OKM', 'App OKM Access', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(38, 'create.AppOKMMaterial', 'web', 'Akses OKM - Create Material', 'App OKM Access Create Material', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(39, 'update.AppOKMMaterial', 'web', 'Akses OKM - Update Material', 'App OKM Access Update Material', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(40, 'read.AppOKMMaterial', 'web', 'Akses OKM - Detail Material', 'App OKM Access Detail Material', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(41, 'delete.AppOKMMaterial', 'web', 'Akses OKM - Delete Material', 'App OKM Access Delete Material', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(42, 'create.AppOKMQuestion', 'web', 'Akses OKM - Create Question', 'App OKM Access Create Question', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(43, 'update.AppOKMQuestion', 'web', 'Akses OKM - Update Question', 'App OKM Access Update Question', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(44, 'read.AppOKMQuestion', 'web', 'Akses OKM - Detail Question', 'App OKM Access Detail Question', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(45, 'delete.AppOKMQuestion', 'web', 'Akses OKM - Delete Question', 'App OKM Access Delete Question', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(46, 'create.AppOKMSchedule', 'web', 'Akses OKM - Create Schedule', 'App OKM Access Create Schedule', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(47, 'update.AppOKMSchedule', 'web', 'Akses OKM - Update Schedule', 'App OKM Access Update Schedule', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(48, 'read.AppOKMSchedule', 'web', 'Akses OKM - Detail Schedule', 'App OKM Access Detail Schedule', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00'),
	(49, 'delete.AppOKMSchedule', 'web', 'Akses OKM - Delete Schedule', 'App OKM Access Delete Schedule', 'AppOKM (Adm)', '2023-03-30 05:00:00', '2023-03-30 05:00:00');

-- Dumping structure for table stg_mig_db_migisapp101.app_rp_roles
CREATE TABLE IF NOT EXISTS `app_rp_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_rp_roles_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_rp_roles: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_rp_role_has_permissions
CREATE TABLE IF NOT EXISTS `app_rp_role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `app_rp_role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `app_rp_role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `app_rp_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `app_rp_role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `app_rp_roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_rp_role_has_permissions: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_simple_todos
CREATE TABLE IF NOT EXISTS `app_simple_todos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `dueDate` date NOT NULL,
  `detail` text NOT NULL,
  `assignee_id` bigint(20) unsigned NOT NULL,
  `tags` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`tags`)),
  `requestor_id` bigint(20) unsigned NOT NULL,
  `isComplete` tinyint(3) unsigned NOT NULL,
  `isImportant` tinyint(3) unsigned NOT NULL,
  `isDeleted` tinyint(3) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_suratjalans
CREATE TABLE IF NOT EXISTS `app_suratjalans` (
  `delivery_no` varchar(255) NOT NULL,
  `do_no` varchar(255) DEFAULT NULL,
  `po_no` varchar(255) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `is_processing` enum('0','1') NOT NULL DEFAULT '0',
  `is_remark` enum('0','1') NOT NULL DEFAULT '0',
  `invoice_no` varchar(255) DEFAULT NULL,
  `print_count` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`delivery_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_suratjalan_details
CREATE TABLE IF NOT EXISTS `app_suratjalan_details` (
  `deliveryno_id` varchar(255) NOT NULL,
  `detail_customer` varchar(255) NOT NULL,
  `detail_address` varchar(255) NOT NULL,
  `detail_city` varchar(255) NOT NULL,
  `detail_nopol` varchar(255) NOT NULL,
  `detail_driver` varchar(255) NOT NULL,
  `detail_item` varchar(255) NOT NULL,
  `detail_qty` int(11) NOT NULL,
  `detail_uom` varchar(255) NOT NULL,
  `detail_sending_date` date NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`deliveryno_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.app_suratjalan_logs
CREATE TABLE IF NOT EXISTS `app_suratjalan_logs` (
  `deliveryno_id` varchar(255) NOT NULL,
  `action_name` varchar(255) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`deliveryno_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_suratjalan_logs: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.app_users
CREATE TABLE IF NOT EXISTS `app_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nik` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `dept_id` bigint(20) unsigned DEFAULT NULL,
  `position_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `active` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_users: ~121 rows (approximately)
INSERT INTO `app_users` (`id`, `nik`, `name`, `dept_id`, `position_id`, `group_id`, `avatar`, `active`, `created_at`, `updated_at`) VALUES
	(1, '9000901', 'ADMINISTRATOR', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(2, '9000902', 'ADMINISTRATOR 2', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(3, '8000801', 'ANDRI J', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(4, '8000802', 'INDRA W', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(5, '8000803', 'SANDOJO', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(6, '1960009', 'SUDI HARTOYO', NULL, 48, NULL, 'SUDI-HARTOYO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(7, '1960012', 'HARIS SETIAWAN', NULL, 24, NULL, 'HARIS-SETIAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(8, '1960018', 'INDRA BASTIAN', NULL, 9, NULL, 'INDRA-BASTIAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(9, '1960019', 'MEILI WIRAWATI', NULL, 46, NULL, 'MEILI-WIRAWATI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(10, '1960022', 'SUPRIYANTO', NULL, 56, NULL, 'SUPRIYANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(11, '1960023', 'SUCI ANDAYANI', NULL, 34, NULL, 'SUCI-ANDAYANI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(12, '1970032', 'WIYOTO', NULL, 27, NULL, 'WIYOTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(13, '1970035', 'SUGENG PURNOMO', NULL, 8, NULL, 'SUGENG-PURNOMO.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:43:30'),
	(14, '1970038', 'SUGENG RIANTO', NULL, 28, NULL, 'SUGENG-RIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(15, '1970039', 'M YANUAR FIRMANSYAH', NULL, 4, NULL, 'M-YANUAR-FIRMANSYAH.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(16, '1970044', 'RUMAJIANTO', NULL, 27, NULL, 'RUMAJIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(17, '1970049', 'M CHAIRUL ANAM', NULL, 33, NULL, 'M-CHAIRUL-ANAM.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(18, '1970050', 'YETTY ADISTANA', NULL, 31, NULL, 'YETTY-ADISTANA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(19, '1970052', 'ENDRI PRABOWO', NULL, NULL, NULL, 'ENDRI-PRABOWO.jpg', 0, '2022-07-25 06:00:00', '2022-11-04 03:46:05'),
	(20, '1980056', 'EVELINE VALENCIANA', NULL, 57, NULL, 'EVELINE-VALENCIANA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(21, '1990058', 'SUPRIONO', NULL, 51, NULL, 'SUPRIONO.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:55:32'),
	(22, '1990059', 'KHOIRUL ROSIDIN', NULL, 12, NULL, 'KHOIRUL-ROSIDIN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(23, '1000061', 'SUHARIYADI', NULL, 9, NULL, 'SUHARIYADI.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:47:41'),
	(24, '1000067', 'ALI KOSIM', NULL, 27, NULL, 'ALI-KOSIM.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(25, '1010074', 'NARI SANTOSO', NULL, 56, NULL, 'NARI-SANTOSO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(26, '1010075', 'DIDIN WIJAYA', NULL, 7, NULL, 'DIDIN-WIJAYA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(27, '1010078', 'SLAMET RIYADI', NULL, 23, NULL, 'SLAMET-RIYADI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(28, '1010079', 'SLAMET TARMUJI', NULL, 27, NULL, 'SLAMET-TARMUJI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(29, '1010080', 'LUHUR BUDI WALUYO', NULL, 21, NULL, 'LUHUR-BUDI-WALUYO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(30, '1010081', 'MURWANTO', NULL, 28, NULL, 'MURWANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(31, '1010082', 'SUNARYO', NULL, 7, NULL, 'SUNARYO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(32, '1010083', 'ASLICHUDDIN FADLOL', NULL, 20, NULL, 'ASLICHUDDIN-FADLOL.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(33, '1010084', 'FERI SANTOSO', NULL, 9, NULL, 'FERI-SANTOSO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(34, '1020089', 'EKO FERRY  FENNANDEZ', NULL, 5, NULL, 'EKO-FERRY-FENNANDEZ.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(35, '1020098', 'SAMUEL TRI SANTOSO', NULL, 33, NULL, 'SAMUEL-TRI-SANTOSO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(36, '1020101', 'ANDRIYANTO', NULL, 12, NULL, 'ANDRIYANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(37, '1020102', 'HENDRI SETIANTO', NULL, 9, NULL, 'HENDRI-SETIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(38, '1030103', 'LULUK TRI ASTUTIK', NULL, 44, NULL, 'LULUK-TRI-ASTUTIK.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(39, '1030104', 'HARI SUTANTO', NULL, 7, NULL, 'HARI-SUTANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(40, '1030106', 'HANDY HEKSA S.', NULL, 7, NULL, 'HANDY-HEKSA-S..jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(41, '1050114', 'SUPANGAT', NULL, NULL, NULL, 'SUPANGAT.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:55:59'),
	(42, '1070121', 'YONO', NULL, 18, NULL, 'YONO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(43, '1070122', 'UNANG SUHERMAN', NULL, 17, NULL, 'UNANG-SUHERMAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(44, '1070123', 'SURONO', NULL, 13, NULL, 'SURONO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(45, '1080126', 'ERWIN SULISTYO', NULL, 12, NULL, 'ERWIN-SULISTYO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(46, '1090133', 'RIZQA MAKHSUNAH', NULL, 32, NULL, 'RIZQA-MAKHSUNAH.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(47, '1090137', 'NAUMI DEBI ALVIA', NULL, 49, NULL, 'NAUMI-DEBI-ALVIA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(48, '2100140', 'ASAN', NULL, 18, NULL, 'ASAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(49, '1110142', 'AMBAR PALUPI', NULL, 41, NULL, 'AMBAR-PALUPI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(50, '1120144', 'JIMMY KRISTIANTO', NULL, 19, NULL, 'JIMMY-KRISTIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(51, '2120145', 'SUWONDO', NULL, 8, NULL, 'SUWONDO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(52, '2120146', 'DJANUAR ARI WIBOWO', NULL, 52, NULL, 'DJANUAR-ARI-WIBOWO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(53, '2120149', 'BENY SETIYAWAN', NULL, 52, NULL, 'BENY-SETIYAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(54, '2120151', 'ARI PRAMONO', NULL, 10, NULL, 'ARI-PRAMONO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(55, '2130154', 'SUHENDI', NULL, 18, NULL, 'SUHENDI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(56, '2130158', 'MESRAWATI', NULL, 15, NULL, 'MESRAWATI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(57, '2130162', 'CHOIRUL ANWAR', NULL, 12, NULL, 'CHOIRUL-ANWAR.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:48:50'),
	(58, '2130163', 'SARPIN', NULL, 27, NULL, 'SARPIN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(59, '2130164', 'YUNIANTO', NULL, 25, NULL, 'YUNIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(60, '2130166', 'SANTOSO BUDI RAHARJO', NULL, 56, NULL, '2130166-220907_0153.jpg', 1, '2022-07-25 06:00:00', '2022-09-07 06:53:36'),
	(61, '2140173', 'ERWAN', NULL, 18, NULL, 'ERWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(62, '2140176', 'ANY SHOFIYAH', NULL, 35, NULL, 'ANY-SHOFIYAH.jpg', 1, '2022-07-25 06:00:00', '2022-09-12 02:23:52'),
	(63, '1140177', 'FAHMARIZA', NULL, 3, NULL, 'FAHMARIZA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(64, '2140178', 'HENDRA SETIAWAN', NULL, 27, NULL, 'HENDRA-SETIAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:54:12'),
	(65, '2140183', 'MOH JOHAN WITONO', NULL, 53, NULL, 'MOH-JOHAN-WITONO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(66, '2140184', 'MARETTA RAMADHIANA P', NULL, NULL, NULL, 'MARETTA-RAMADHIANA-P.jpg', 0, '2022-07-25 06:00:00', '2022-09-12 02:20:28'),
	(67, '2160200', 'KURNIAWAN', NULL, 18, NULL, 'KURNIAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(68, '2160201', 'TATANG SIHABUDIN', NULL, 18, NULL, 'TATANG-SIHABUDIN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(69, '2160209', 'ARRY ATUR SUKMAWATI', NULL, 23, NULL, 'ARRY-ATUR-SUKMAWATI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(70, '2160210', 'YOHANES KURNIAWAN', NULL, 58, NULL, 'YOHANES-KURNIAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(71, '2160212', 'FERIL DWI FITANTO', NULL, NULL, NULL, 'FERIL-DWI-FITANTO.jpg', 0, '2022-07-25 06:00:00', '2023-02-08 00:20:20'),
	(72, '2170218', 'TANTI DWI MANDASARI', NULL, 37, NULL, 'TANTI-DWI-MANDASARI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(73, '2170228', 'KRISDIANTO', NULL, 27, NULL, 'KRISDIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(74, '2170232', 'ALI BUKHORI', NULL, NULL, NULL, 'ALI-BUKHORI.jpg', 0, '2022-07-25 06:00:00', '2023-02-08 00:20:21'),
	(75, '2170235', 'DHIKA PUTRA PERMANA', NULL, 47, NULL, 'DHIKA-PUTRA-PERMANA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(76, '2180236', 'DARIUS RENGGA', NULL, NULL, NULL, 'DARIUS-RENGGA.jpg', 0, '2022-07-25 06:00:00', '2022-11-04 03:50:44'),
	(77, '2180239', 'AGUS SUGIANTO', NULL, 27, NULL, 'AGUS-SUGIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(78, '2180240', 'WAGIANTO', NULL, 27, NULL, 'WAGIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(79, '2180242', 'ARIF WIBOWO', NULL, 26, NULL, 'ARIF-WIBOWO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(80, '2190247', 'REVAN NUR ENGGA', NULL, NULL, NULL, 'REVAN-NUR-ENGGA.jpg', 0, '2022-07-25 06:00:00', '2023-02-08 00:17:00'),
	(81, '2190248', 'EFI PAHLAWATI', NULL, 39, NULL, 'EFI-PAHLAWATI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(82, '2190252', 'MOCH ROBIYANTO', NULL, 54, NULL, 'MOCH-ROBIYANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(83, '2190254', 'SUGENG HARIADI', NULL, 27, NULL, 'SUGENG-HARIADI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(84, '2190256', 'AFKAR HANIF SYAIFUDDIN', NULL, 30, NULL, 'AFKAR-HANIF-SYAIFUDDIN.jpg', 1, '2022-07-25 06:00:00', '2022-09-12 02:08:24'),
	(85, '2190257', 'DAYU BUDI SANTOSO', NULL, 33, NULL, 'DAYU-BUDI-SANTOSO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(86, '2190258', 'HADI RAKHMAWAN', NULL, 27, NULL, 'HADI-RAKHMAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(87, '2190259', 'EKO DIAN PRASETYO', NULL, 27, NULL, 'EKO-DIAN-PRASETYO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(88, '2190260', 'ISWAHYUDI', NULL, 6, NULL, 'ISWAHYUDI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(89, '2190261', 'ARIF EKA KURNIAWAN', NULL, 14, NULL, 'ARIF-EKA-KURNIAWAN.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(90, '2200264', 'ANDRIEO OKTO SUNA', NULL, 16, NULL, 'ANDRIEO-OKTO-SUNA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(91, '2200265', 'NOVIAR KHARISMAWATI', NULL, NULL, NULL, 'NOVIAR-KHARISMAWATI.jpg', 1, '2022-07-25 06:00:00', '2023-04-18 13:22:26'),
	(92, '2200268', 'HERMAN TONY', NULL, 27, NULL, 'HERMAN-TONY.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(93, '2200271', 'MISTIONO', NULL, 40, NULL, 'MISTIONO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(94, '2200272', 'NURIANTO', NULL, 27, NULL, 'NURIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(95, '2200273', 'NANDA ARTIKA CAHYANI', NULL, 43, NULL, 'NANDA-ARTIKA-CAHYANI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(96, '2200275', 'WAHYU DHANIAR P.', NULL, 36, NULL, 'WAHYU-DHANIAR-P..jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(97, '2210276', 'DWI PETRUS NOVEMBRIANTO', NULL, 55, NULL, 'DWI-PETRUS-NOVEMBRIANTO.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(98, '2210277', 'SUBAKIR', NULL, 27, NULL, 'SUBAKIR.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(99, '2210278', 'MOKHAMAD LUTHFI', NULL, 27, NULL, 'MOKHAMAD-LUTHFI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(100, '2210279', 'NANANG SETIAWAN', NULL, NULL, NULL, 'NANANG-SETIAWAN.jpg', 0, '2022-07-25 06:00:00', '2022-11-04 03:51:27'),
	(101, '2210280', 'NUNGKY SILVANA YUDHA', NULL, 45, NULL, 'NUNGKY-SILVANA-YUDHA.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(102, '2210281', 'RIZKY RAMADAN', NULL, NULL, NULL, 'RIZKY-RAMADAN.jpg', 0, '2022-07-25 06:00:00', '2022-09-12 02:20:37'),
	(103, '2210284', 'MONIKA YOSIANA INDRI K.', NULL, NULL, NULL, 'MONIKA-YOSIANA-INDRI-K..jpg', 0, '2022-07-25 06:00:00', '2022-09-12 02:23:10'),
	(104, '2210282', 'RINDHA YULI TRI PRASTYO', NULL, 27, NULL, 'RINDHA-YULI-TRI-PRASTYO.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:54:12'),
	(105, '2210283', 'DEDDY KOESTIADI', NULL, 54, NULL, 'DEDDY-KOESTIADI.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:55:59'),
	(106, '2210285', 'ANDRI AHMAD FAUZI', NULL, NULL, NULL, 'ANDRI-AHMAD-FAUZI.jpg', 0, '2022-07-25 06:00:00', '2023-02-08 00:18:25'),
	(107, '2210286', 'RAHARJO ARIF WICAKSONO', NULL, 11, NULL, 'RAHARJO-ARIF-WICAKSONO.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:48:57'),
	(108, '2220287', 'DODY PRASETYO', NULL, NULL, NULL, 'DODY-PRASETYO.jpg', 0, '2022-07-25 06:00:00', '2022-11-13 05:39:49'),
	(109, '2220288', 'ANDIK PRIYONO', NULL, 27, NULL, 'ANDIK-PRIYONO.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:54:12'),
	(110, '2220289', 'INDAH PURWANTINI UTAMI', NULL, 51, NULL, 'INDAH-PURWANTINI-UTAMI.jpg', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	(111, '2220290', 'M. TASWIRUL MUHAQQIQIN', NULL, 22, NULL, 'M.-TASWIRUL-MUHAQQIQIN.jpg', 1, '2022-07-25 06:00:00', '2022-11-04 03:50:44'),
	(112, '2220291', 'YUSUP EFENDY', NULL, 2, NULL, 'YUSUP-EFENDY.jpg', 1, '2022-07-25 06:00:00', '2022-09-12 01:43:23'),
	(113, '2220292', 'SASMITA AJIE', NULL, 29, NULL, NULL, 0, '2022-09-30 05:00:01', '2023-04-11 06:33:26'),
	(114, '2220293', 'MUHAMMAD NUR IRFAN', NULL, 26, NULL, 'null', 1, '2022-11-01 05:00:01', '2022-11-13 05:39:15'),
	(115, '2220294', 'ROMI DWI INDRA DARMAWAN', NULL, 27, NULL, NULL, 1, '2022-12-13 11:00:01', '2023-02-08 00:17:56'),
	(116, '2230295', 'MUHAMMAD AZRIEL', NULL, 28, NULL, NULL, 1, '2023-01-09 11:00:02', '2023-02-08 00:18:13'),
	(117, '2230296', 'FREDYANSYAH A HERLANGGA', NULL, 28, NULL, NULL, 1, '2023-01-09 11:00:02', '2023-02-08 00:18:13'),
	(119, '2230297', 'ANDIKA FIRMANSYAH', NULL, 23, NULL, NULL, 1, '2023-02-08 00:15:38', '2023-02-08 00:17:00'),
	(121, '2230298', 'MUHAMMAD ARIEF', NULL, NULL, NULL, NULL, 1, '2023-02-14 11:00:01', '2023-02-14 11:00:01'),
	(122, '2230300', 'WAHYU PUTRA PERDANA', NULL, NULL, NULL, NULL, 1, '2023-03-27 05:00:01', '2023-03-27 05:00:01'),
	(123, '2230301', 'BLESSTA KALANOV', NULL, 42, NULL, NULL, 1, '2023-03-27 05:00:01', '2023-04-18 13:22:26'),
	(125, '8000804', 'ADMIN OKM', NULL, NULL, NULL, NULL, 1, '2023-04-13 03:25:35', '2023-04-13 03:25:35');

-- Dumping structure for table stg_mig_db_migisapp101.app_user_logins
CREATE TABLE IF NOT EXISTS `app_user_logins` (
  `nik` varchar(255) NOT NULL,
  `s_nik` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `active` tinyint(4) NOT NULL,
  `admin` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`nik`),
  UNIQUE KEY `app_user_logins_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.app_user_logins: ~105 rows (approximately)
INSERT INTO `app_user_logins` (`nik`, `s_nik`, `email`, `password`, `active`, `admin`, `created_at`, `updated_at`) VALUES
	('1000061', '061', 'mail@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1000067', '067', 'alikosim@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010074', '074', 'narisantoso@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010075', '075', 'didinwijaya@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010078', '078', 'mrkt@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010079', '079', 'slamettarmuji@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010080', '080', 'luhur@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010081', '081', 'murwanto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010082', '082', 'sunaryo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010083', '083', 'aslichuddin.fadlol@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1010084', '084', 'ferisantoso@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1020089', '089', 'ekoferryf.@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1020098', '098', 'samueltris.@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1020101', '101', 'andriyanto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1020102', '102', 'hendrisetianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1030103', '103', 'hr@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1030104', '104', 'harisutanto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1030106', '106', 'handyheksas.@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1050114', '114', 'supangat@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1070121', '121', 'yono@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1070122', '122', 'unangsuherman@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1070123', '123', 'surono@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1080126', '126', 'erwinsulistyo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1090133', '133', 'rizqamakhsunah@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1090137', '137', 'hrd@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1110142', '142', 'ambar.palupi@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1120144', '144', 'jimmy.kristianto@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1140177', '177', 'fahma.riza@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1960009', '009', 'it@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1960012', '012', 'harissetiawan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1960018', '018', 'indrabastian@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1960019', '019', 'meili.wirawati@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1960022', '022', 'supriyanto@mig.com', '$2y$10$wJANr7gLzI8Gtpue7iK4meqvVmaUcV4hIkwN.9lUxtFfPkJKBAZ3i', 1, 0, '2022-07-25 06:00:00', '2022-09-13 07:59:56'),
	('1960023', '023', 'suci.andayani@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970032', '032', 'wiyoto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970035', '035', 'sugengpurnomo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970038', '038', 'sugengrianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970039', '039', 'yanuar.firmansyah@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970044', '044', 'rumajianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970049', '049', 'm.chairulanam@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970050', '050', 'yetty@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1970052', '052', 'endriprabowo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-11-04 03:45:03'),
	('1980056', '056', 'eveline.valenciana@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1990058', '058', 'supriono@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('1990059', '059', 'khoirulrosidin@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2100140', '140', 'asan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2120145', '145', 'suwondo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2120146', '146', 'djanuarariwibowo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2120149', '149', 'benysetiyawan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2120151', '151', 'aripramono@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130154', '154', 'suhendi@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130158', '158', 'mesrawati@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130162', '162', 'choirulanwar@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130163', '163', 'sarpin@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130164', '164', 'yunianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2130166', '166', 'santosobudiraharjo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2140173', '173', 'erwan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2140176', '176', 'anyshofiyah@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2140178', '178', 'hendrasetiawan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2140183', '183', 'mohjohanwitono@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2140184', '184', 'reta@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-09-12 02:20:28'),
	('2160200', '200', 'kurniawan@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2160201', '201', 'tatangsihabudin@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2160209', '209', 'arryatursukmawati@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2160210', '210', 'yohanes.kurniawan@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2160212', '212', 'ferildwifitanto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2023-02-08 00:19:52'),
	('2170218', '218', 'tantidwimandasari@gmail.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2170228', '228', 'krisdianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2170232', '232', 'alibukhori@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2023-02-08 00:19:44'),
	('2170235', '235', 'dhika.putra@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2180236', '236', 'dariusrengga@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-09-12 02:21:24'),
	('2180239', '239', 'agussugianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2180240', '240', 'wagianto@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2180242', '242', 'arifwibowo@mig.com', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190247', '247', 'revan@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2023-02-08 00:16:09'),
	('2190248', '248', 'efi@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190252', '252', 'robiyanto@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190254', '254', 'sugenghariadi@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190256', '256', 'afkar@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190257', '257', 'dayu@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190258', '258', 'hadirakhmawan@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190259', '259', 'ekodian@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190260', '260', 'iswahyudi@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2190261', '261', 'arifeka@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200264', '264', 'andrieo@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200265', '265', 'noviar@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200268', '268', 'herman@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200271', '271', 'mistiono@molindointigas.co.id', '$2y$10$ynbDXGAkdU4spcYiI2xz4efmQPzYkFuVCE8Du4rTeMvr42i7pERka', 1, 0, '2022-07-25 06:00:00', '2022-09-08 03:36:57'),
	('2200272', '272', 'nurianto@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200273', '273', 'nanda@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2200275', '275', 'wahyu.dhaniar@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2210276', '276', 'petrus@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2210277', '277', '---', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2210278', '278', '--', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2210279', '279', '-', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-09-12 02:21:54'),
	('2210280', '280', 'nungky@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2210281', '281', 'rizky@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-09-12 02:20:37'),
	('2210284', '284', 'monika@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 0, 0, '2022-07-25 06:00:00', '2022-09-12 02:22:02'),
	('2220289', '289', 'seketariat@molindointigas.co.id', '$2y$10$UpM7JWnRTrPLPKtBFHJ2culj5AniBqffl0LLeSS6V8.PUlZuG0dd6', 1, 0, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('2220290', '290', 'taswir@email.com', '$2y$10$CmnF3qM5crfdyIsbQAKSTeDaW1aUSrS8zZTM7oO/i2YXe1zOluv7C', 1, 0, '2023-02-07 00:06:19', '2023-02-07 00:06:19'),
	('2220291', '291', 'yusup.efendy@molindointigas.co.id', '$2y$10$OO5EmOjfLmBkvacGyAAzMOLrqhdVFiUSclyJRxrm0LS0OaeuouHta', 1, 0, '2022-09-12 02:25:37', '2022-09-12 02:26:00'),
	('2220292', '292', 'sasmita.aji@molindointigas.co.id', '$2y$10$mgvX0hQJZEfAQR.TVk/1Oe7CvW.6n7rQi3LepUN8gHHkxByloDoga', 0, 0, '2022-10-03 00:42:06', '2023-04-11 06:33:26'),
	('2230297', '297', 'andikaf@email.com', '$2y$10$u3d25081Ddz.tzQf95LRAuakMp7KI6cmklpp5tZxaRIJS.1xNessy', 1, 0, '2023-02-08 00:15:38', '2023-02-08 00:15:38'),
	('8000804', '804', 'okm@molindointigas.co.id', '$2y$10$t8Osiu0VbtrpOPwAn/xIf.4PHv9oVFOgsIVCeR3uLxaMYVxlOZx8G', 1, 0, '2023-04-13 03:25:35', '2023-04-13 03:25:35'),
	('9000901', '901', 'admin@molindointigas.co.id', '$2y$10$Cda6WRgRL2sIoi3PwlMNq.MckKRoBgjEDDlKQYQklI6H/HwaeXBRW', 1, 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00'),
	('9000902', '902', 'admin2@molindointigas.co.id', '$2y$10$et1oYEslaKYilt.CZKn/eeHw3pwI7yckUTKdxVEBxfLa32gC/OoX6', 1, 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00');

-- Dumping structure for table stg_mig_db_migisapp101.app_user_tokens
CREATE TABLE IF NOT EXISTS `app_user_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_nik` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_user_tokens_token_unique` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.jobs: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table stg_mig_db_migisapp101.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.password_resets: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_nik` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.personal_access_tokens: ~0 rows (approximately)

-- Dumping structure for table stg_mig_db_migisapp101.websockets_statistics_entries
CREATE TABLE IF NOT EXISTS `websockets_statistics_entries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) NOT NULL,
  `peak_connection_count` int(11) NOT NULL,
  `websocket_message_count` int(11) NOT NULL,
  `api_message_count` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table stg_mig_db_migisapp101.websockets_statistics_entries: ~0 rows (approximately)

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
