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
	(1, 'App\\Models\\API\\Auth\\AppUserLogin', 9000901);

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
	(1, '9000901', 'ADMINISTRATOR', NULL, NULL, NULL, '', 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00');

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
	('9000901', '901', 'admin@molindointigas.co.id', '$2y$10$Cda6WRgRL2sIoi3PwlMNq.MckKRoBgjEDDlKQYQklI6H/HwaeXBRW', 1, 1, '2022-07-25 06:00:00', '2022-07-25 06:00:00');

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
