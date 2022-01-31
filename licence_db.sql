-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.5.5-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for license_db
DROP DATABASE IF EXISTS `license_db`;
CREATE DATABASE IF NOT EXISTS `license_db` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `license_db`;

-- Dumping structure for table license_db.all_user_approval_for_flow_level
DROP TABLE IF EXISTS `all_user_approval_for_flow_level`;
CREATE TABLE IF NOT EXISTS `all_user_approval_for_flow_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_level_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `comments` text NOT NULL,
  `signature` longtext DEFAULT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__flow_level_child_key` (`flow_level_id`) USING BTREE,
  KEY `FK__users_key` (`user_id`) USING BTREE,
  CONSTRAINT `FK__flow_level_child_key` FOREIGN KEY (`flow_level_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK__users_key` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.all_user_approval_for_flow_level: ~0 rows (approximately)
DELETE FROM `all_user_approval_for_flow_level`;
/*!40000 ALTER TABLE `all_user_approval_for_flow_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_user_approval_for_flow_level` ENABLE KEYS */;

-- Dumping structure for table license_db.all_user_approval_for_flow_level_log
DROP TABLE IF EXISTS `all_user_approval_for_flow_level_log`;
CREATE TABLE IF NOT EXISTS `all_user_approval_for_flow_level_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_level_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `comments` text NOT NULL,
  `signature` longtext DEFAULT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `approve_flag` varchar(50) NOT NULL DEFAULT 'N',
  `session` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__flow_level_child_key_log` (`flow_level_id`) USING BTREE,
  KEY `FK__users_key_log` (`user_id`) USING BTREE,
  CONSTRAINT `FK__flow_level_child_key_log` FOREIGN KEY (`flow_level_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK__users_key_log` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.all_user_approval_for_flow_level_log: ~0 rows (approximately)
DELETE FROM `all_user_approval_for_flow_level_log`;
/*!40000 ALTER TABLE `all_user_approval_for_flow_level_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `all_user_approval_for_flow_level_log` ENABLE KEYS */;

-- Dumping structure for table license_db.api_configuration
DROP TABLE IF EXISTS `api_configuration`;
CREATE TABLE IF NOT EXISTS `api_configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `endpoint_url` varchar(500) NOT NULL,
  `api_key` varchar(500) DEFAULT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `frequency` varchar(50) DEFAULT NULL,
  `org_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `mapping_id` bigint(20) unsigned DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `delete_flag` varchar(1) NOT NULL,
  `background_job` varchar(1) NOT NULL,
  `raw_data_file_type` varchar(50) DEFAULT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_api_configuration_organization_info` (`org_id`),
  KEY `FK_api_configuration_project_setup` (`project_id`),
  KEY `FK_api_configuration_users` (`updated_by`),
  KEY `FK_api_configuration_permissions` (`document_type`),
  KEY `FK_api_configuration_master_form_mapping` (`mapping_id`),
  CONSTRAINT `FK_api_configuration_master_form_mapping` FOREIGN KEY (`mapping_id`) REFERENCES `master_form_mapping` (`id`),
  CONSTRAINT `FK_api_configuration_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_api_configuration_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_api_configuration_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_api_configuration_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.api_configuration: ~0 rows (approximately)
DELETE FROM `api_configuration`;
/*!40000 ALTER TABLE `api_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_configuration` ENABLE KEYS */;

-- Dumping structure for table license_db.api_configuration_field_mapping
DROP TABLE IF EXISTS `api_configuration_field_mapping`;
CREATE TABLE IF NOT EXISTS `api_configuration_field_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `api_configuration_id` bigint(20) unsigned NOT NULL,
  `form_name` varchar(50) NOT NULL,
  `form_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_data`)),
  `display_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__api_configuration` (`api_configuration_id`),
  CONSTRAINT `FK__api_configuration` FOREIGN KEY (`api_configuration_id`) REFERENCES `api_configuration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.api_configuration_field_mapping: ~0 rows (approximately)
DELETE FROM `api_configuration_field_mapping`;
/*!40000 ALTER TABLE `api_configuration_field_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_configuration_field_mapping` ENABLE KEYS */;

-- Dumping structure for table license_db.api_configuration_parameters
DROP TABLE IF EXISTS `api_configuration_parameters`;
CREATE TABLE IF NOT EXISTS `api_configuration_parameters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `api_configuration_id` bigint(20) unsigned NOT NULL,
  `parameter_name` varchar(50) NOT NULL,
  `parameter_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_api_configuration_parameters_api_configuration` (`api_configuration_id`),
  CONSTRAINT `FK_api_configuration_parameters_api_configuration` FOREIGN KEY (`api_configuration_id`) REFERENCES `api_configuration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.api_configuration_parameters: ~0 rows (approximately)
DELETE FROM `api_configuration_parameters`;
/*!40000 ALTER TABLE `api_configuration_parameters` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_configuration_parameters` ENABLE KEYS */;

-- Dumping structure for table license_db.api_configuration_raw_data_columns
DROP TABLE IF EXISTS `api_configuration_raw_data_columns`;
CREATE TABLE IF NOT EXISTS `api_configuration_raw_data_columns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `api_configuration_id` bigint(20) unsigned NOT NULL,
  `column_name` varchar(50) NOT NULL,
  `json_key` varchar(50) NOT NULL,
  `display_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_api_configuration_raw_data_columns_api_configuration` (`api_configuration_id`),
  CONSTRAINT `FK_api_configuration_raw_data_columns_api_configuration` FOREIGN KEY (`api_configuration_id`) REFERENCES `api_configuration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.api_configuration_raw_data_columns: ~0 rows (approximately)
DELETE FROM `api_configuration_raw_data_columns`;
/*!40000 ALTER TABLE `api_configuration_raw_data_columns` DISABLE KEYS */;
/*!40000 ALTER TABLE `api_configuration_raw_data_columns` ENABLE KEYS */;

-- Dumping structure for table license_db.api_constants
DROP TABLE IF EXISTS `api_constants`;
CREATE TABLE IF NOT EXISTS `api_constants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `constant_name` varchar(50) NOT NULL,
  `constant_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.api_constants: ~2 rows (approximately)
DELETE FROM `api_constants`;
/*!40000 ALTER TABLE `api_constants` DISABLE KEYS */;
INSERT INTO `api_constants` (`id`, `constant_name`, `constant_value`) VALUES
	(1, 'DH/R', '10000'),
	(2, 'kelvin', '273.1');
/*!40000 ALTER TABLE `api_constants` ENABLE KEYS */;

-- Dumping structure for table license_db.audit_trail
DROP TABLE IF EXISTS `audit_trail`;
CREATE TABLE IF NOT EXISTS `audit_trail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` bigint(20) unsigned NOT NULL,
  `event` varchar(200) NOT NULL,
  `ip_address` varchar(50) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `system_remarks` text DEFAULT NULL,
  `user_remarks` text DEFAULT NULL,
  `browser` text DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL DEFAULT 1,
  `unique_doc_code` varchar(50) DEFAULT NULL,
  `doc_type` varchar(50) DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `documentId` bigint(20) unsigned DEFAULT NULL,
  `project_version` bigint(20) unsigned DEFAULT NULL,
  `old_table_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`old_table_json`)),
  `new_table_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`new_table_json`)),
  PRIMARY KEY (`id`),
  KEY `FK_audit_trail_users` (`username`),
  KEY `FK_audit_trail_organization_info` (`organization_id`),
  KEY `FK3_for_project_id` (`project_id`),
  KEY `FK4_for_doc_type` (`doc_type`),
  KEY `FK5_for_project_version` (`project_version`),
  CONSTRAINT `FK3_for_project_id` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK4_for_doc_type` FOREIGN KEY (`doc_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK5_for_project_version` FOREIGN KEY (`project_version`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_audit_trail_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_audit_trail_users` FOREIGN KEY (`username`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.audit_trail: ~0 rows (approximately)
DELETE FROM `audit_trail`;
/*!40000 ALTER TABLE `audit_trail` DISABLE KEYS */;
/*!40000 ALTER TABLE `audit_trail` ENABLE KEYS */;

-- Dumping structure for table license_db.batch_creation
DROP TABLE IF EXISTS `batch_creation`;
CREATE TABLE IF NOT EXISTS `batch_creation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `batch_no` varchar(50) NOT NULL,
  `batch_quantity` bigint(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  `workflow_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `completed_flag` varchar(1) DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  PRIMARY KEY (`id`),
  KEY `FK_batch_creation_organization_info` (`org_id`),
  CONSTRAINT `FK_batch_creation_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.batch_creation: ~0 rows (approximately)
DELETE FROM `batch_creation`;
/*!40000 ALTER TABLE `batch_creation` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_creation` ENABLE KEYS */;

-- Dumping structure for table license_db.batch_equipment
DROP TABLE IF EXISTS `batch_equipment`;
CREATE TABLE IF NOT EXISTS `batch_equipment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `batch_creation_id` bigint(20) unsigned NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_batch_forms_batch_creation` (`batch_creation_id`),
  KEY `FK_batch_forms_master_dynamic_form` (`equipment_id`),
  CONSTRAINT `FK_batch_equipment_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_batch_forms_batch_creation` FOREIGN KEY (`batch_creation_id`) REFERENCES `batch_creation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.batch_equipment: ~0 rows (approximately)
DELETE FROM `batch_equipment`;
/*!40000 ALTER TABLE `batch_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_equipment` ENABLE KEYS */;

-- Dumping structure for table license_db.batch_forms
DROP TABLE IF EXISTS `batch_forms`;
CREATE TABLE IF NOT EXISTS `batch_forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `batch_creation_id` bigint(20) NOT NULL,
  `form_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7m6ekbhy08xayv3gn38vnwapj` (`batch_creation_id`),
  KEY `FK5msxq62iyu2kpdakjter6in24` (`form_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.batch_forms: 0 rows
DELETE FROM `batch_forms`;
/*!40000 ALTER TABLE `batch_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `batch_forms` ENABLE KEYS */;

-- Dumping structure for table license_db.business_owner_for_project
DROP TABLE IF EXISTS `business_owner_for_project`;
CREATE TABLE IF NOT EXISTS `business_owner_for_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `users_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_business_owner_for_project_project_setup` (`project_id`),
  KEY `FK_business_owner_for_project_users` (`users_id`),
  CONSTRAINT `FK_business_owner_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_business_owner_for_project_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.business_owner_for_project: ~0 rows (approximately)
DELETE FROM `business_owner_for_project`;
/*!40000 ALTER TABLE `business_owner_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `business_owner_for_project` ENABLE KEYS */;

-- Dumping structure for table license_db.calendar_events
DROP TABLE IF EXISTS `calendar_events`;
CREATE TABLE IF NOT EXISTS `calendar_events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `title` varchar(500) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `primary_color` varchar(50) NOT NULL,
  `secondary_color` varchar(50) DEFAULT NULL,
  `holiday_flag` varchar(1) NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `frequency` varchar(50) NOT NULL DEFAULT 'noreminder',
  `status` varchar(200) DEFAULT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `equipment_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_calendar_events_organization_info` (`org_id`),
  KEY `FK_calendar_events_users` (`updated_by`),
  KEY `FK_calendar_events_equipment` (`equipment_id`),
  KEY `FK_calendar_events_users_2` (`created_by`),
  CONSTRAINT `FK_calendar_events_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_calendar_events_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_calendar_events_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_calendar_events_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.calendar_events: ~0 rows (approximately)
DELETE FROM `calendar_events`;
/*!40000 ALTER TABLE `calendar_events` DISABLE KEYS */;
/*!40000 ALTER TABLE `calendar_events` ENABLE KEYS */;

-- Dumping structure for table license_db.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `deleted_flag` char(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `organization_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users` (`created_by`),
  KEY `FK__users_2` (`last_updated_by`),
  CONSTRAINT `FK__users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK__users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.category: ~5 rows (approximately)
DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `category_name`, `deleted_flag`, `created_by`, `created_time`, `last_updated_by`, `last_updated_time`, `organization_id`) VALUES
	(1, 'General Requirements', 'N', 1, '2020-03-04 21:23:28', 1, '2020-03-04 21:23:28', 1),
	(2, 'Electronic signature ', 'N', 1, '2021-06-10 00:07:26', 1, '2021-06-10 00:07:26', 1),
	(3, 'Data Security', 'N', 1, '2021-05-07 03:35:06', 1, '2021-05-07 03:35:06', 1),
	(4, 'Data Back  Requirements ', 'N', 1, '2021-06-12 15:02:03', 1, '2021-06-12 15:02:03', 1),
	(5, 'Data Integrity ', 'N', 1, '2021-06-12 15:02:03', 1, '2021-06-12 15:02:03', 1);
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Dumping structure for table license_db.ccf
DROP TABLE IF EXISTS `ccf`;
CREATE TABLE IF NOT EXISTS `ccf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `ccf_code` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `priority_id` bigint(20) unsigned NOT NULL,
  `reason` mediumtext NOT NULL,
  `impactassessment` mediumtext DEFAULT NULL,
  `assessment` mediumtext DEFAULT NULL,
  `regulatory_notification_flag` varchar(1) NOT NULL DEFAULT 'N',
  `status` varchar(50) DEFAULT NULL,
  `published` varchar(1) DEFAULT 'N',
  `dynamic_form_json` longtext DEFAULT NULL,
  `workflow_completion_flag` varbinary(1) DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_change_control_form_users` (`updated_by`),
  KEY `FK_change_control_form_users_2` (`created_by`),
  KEY `FK_change_control_form_priority` (`priority_id`),
  KEY `FK_ccf_organization_info` (`org_id`),
  CONSTRAINT `FK_ccf_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_change_control_form_priority` FOREIGN KEY (`priority_id`) REFERENCES `priority` (`id`),
  CONSTRAINT `FK_change_control_form_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_change_control_form_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ccf: ~0 rows (approximately)
DELETE FROM `ccf`;
/*!40000 ALTER TABLE `ccf` DISABLE KEYS */;
/*!40000 ALTER TABLE `ccf` ENABLE KEYS */;

-- Dumping structure for table license_db.ccf_dept
DROP TABLE IF EXISTS `ccf_dept`;
CREATE TABLE IF NOT EXISTS `ccf_dept` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccf_id` bigint(20) unsigned NOT NULL,
  `dept_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ccf_dept_ccf` (`ccf_id`),
  KEY `FK_ccf_dept_department` (`dept_id`),
  CONSTRAINT `FK_ccf_dept_ccf` FOREIGN KEY (`ccf_id`) REFERENCES `ccf` (`id`),
  CONSTRAINT `FK_ccf_dept_department` FOREIGN KEY (`dept_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ccf_dept: ~0 rows (approximately)
DELETE FROM `ccf_dept`;
/*!40000 ALTER TABLE `ccf_dept` DISABLE KEYS */;
/*!40000 ALTER TABLE `ccf_dept` ENABLE KEYS */;

-- Dumping structure for table license_db.ccf_dynamic_forms
DROP TABLE IF EXISTS `ccf_dynamic_forms`;
CREATE TABLE IF NOT EXISTS `ccf_dynamic_forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ccf_id` bigint(20) unsigned NOT NULL,
  `permission_constant_id` varchar(50) NOT NULL,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `mapping_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_ccf_dynamic_forms_ccf` (`ccf_id`),
  KEY `FK_ccf_dynamic_forms_master_dynamic_form` (`master_dynamic_form_id`),
  KEY `FK_ccf_dynamic_forms_master_form_mapping` (`mapping_id`),
  CONSTRAINT `FK_ccf_dynamic_forms_ccf` FOREIGN KEY (`ccf_id`) REFERENCES `ccf` (`id`),
  CONSTRAINT `FK_ccf_dynamic_forms_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_ccf_dynamic_forms_master_form_mapping` FOREIGN KEY (`mapping_id`) REFERENCES `master_form_mapping` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ccf_dynamic_forms: ~0 rows (approximately)
DELETE FROM `ccf_dynamic_forms`;
/*!40000 ALTER TABLE `ccf_dynamic_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `ccf_dynamic_forms` ENABLE KEYS */;

-- Dumping structure for table license_db.ccf_for_project
DROP TABLE IF EXISTS `ccf_for_project`;
CREATE TABLE IF NOT EXISTS `ccf_for_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `ccf_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ccf_for_project_project_setup` (`project_id`),
  KEY `FK_ccf_for_project_ccf` (`ccf_id`),
  CONSTRAINT `FK_ccf_for_project_ccf` FOREIGN KEY (`ccf_id`) REFERENCES `ccf` (`id`),
  CONSTRAINT `FK_ccf_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table license_db.ccf_for_project: ~0 rows (approximately)
DELETE FROM `ccf_for_project`;
/*!40000 ALTER TABLE `ccf_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `ccf_for_project` ENABLE KEYS */;

-- Dumping structure for table license_db.ccf_users
DROP TABLE IF EXISTS `ccf_users`;
CREATE TABLE IF NOT EXISTS `ccf_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cff_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_ccf_users_ccf` (`cff_id`),
  KEY `FK_ccf_users_users` (`user_id`),
  CONSTRAINT `FK_ccf_users_ccf` FOREIGN KEY (`cff_id`) REFERENCES `ccf` (`id`),
  CONSTRAINT `FK_ccf_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ccf_users: ~0 rows (approximately)
DELETE FROM `ccf_users`;
/*!40000 ALTER TABLE `ccf_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `ccf_users` ENABLE KEYS */;

-- Dumping structure for table license_db.checklist_for_equipment
DROP TABLE IF EXISTS `checklist_for_equipment`;
CREATE TABLE IF NOT EXISTS `checklist_for_equipment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `checklist_name` varchar(500) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_checklist_for_equipment_equipment` (`equipment_id`),
  KEY `FK_checklist_for_equipment_users` (`updated_by`),
  CONSTRAINT `FK_checklist_for_equipment_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_checklist_for_equipment_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.checklist_for_equipment: ~0 rows (approximately)
DELETE FROM `checklist_for_equipment`;
/*!40000 ALTER TABLE `checklist_for_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_for_equipment` ENABLE KEYS */;

-- Dumping structure for table license_db.checklist_for_project
DROP TABLE IF EXISTS `checklist_for_project`;
CREATE TABLE IF NOT EXISTS `checklist_for_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `checklist_name` varchar(500) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `display_order` int(10) unsigned NOT NULL DEFAULT 0,
  `completed_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_checklist_for_project_project_setup` (`project_id`),
  KEY `FK_checklist_for_project_users` (`created_by`),
  KEY `FK_checklist_for_project_users_2` (`updated_by`),
  CONSTRAINT `FK_checklist_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_checklist_for_project_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_checklist_for_project_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.checklist_for_project: ~0 rows (approximately)
DELETE FROM `checklist_for_project`;
/*!40000 ALTER TABLE `checklist_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_for_project` ENABLE KEYS */;

-- Dumping structure for table license_db.checklist_for_task
DROP TABLE IF EXISTS `checklist_for_task`;
CREATE TABLE IF NOT EXISTS `checklist_for_task` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` bigint(20) NOT NULL,
  `checklist_name` varchar(500) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `display_order` int(10) unsigned NOT NULL DEFAULT 0,
  `completed_flag` varchar(1) NOT NULL DEFAULT 'N',
  `updated_by` bigint(20) unsigned NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_checklist_for_task_project_tasks` (`task_id`),
  KEY `FK_checklist_for_task_users` (`updated_by`),
  CONSTRAINT `FK_checklist_for_task_project_tasks` FOREIGN KEY (`task_id`) REFERENCES `project_tasks` (`id`),
  CONSTRAINT `FK_checklist_for_task_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.checklist_for_task: ~0 rows (approximately)
DELETE FROM `checklist_for_task`;
/*!40000 ALTER TABLE `checklist_for_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_for_task` ENABLE KEYS */;

-- Dumping structure for table license_db.checklist_for_test_cases
DROP TABLE IF EXISTS `checklist_for_test_cases`;
CREATE TABLE IF NOT EXISTS `checklist_for_test_cases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_id` bigint(20) unsigned DEFAULT NULL,
  `discrepancy_id` bigint(20) unsigned DEFAULT NULL,
  `unscripted_id` bigint(20) unsigned DEFAULT NULL,
  `check_list_name` longtext NOT NULL,
  `completed_flag` varchar(1) NOT NULL DEFAULT 'N',
  `status` varchar(500) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `display_order` int(10) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expected_result` longtext DEFAULT NULL,
  `actual_result` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_checklist_for_test_cases_iq_test_cases` (`test_case_id`),
  KEY `FK_checklist_for_test_cases_users` (`updated_by`),
  KEY `FK_checklist_for_test_cases_df` (`discrepancy_id`),
  KEY `FK_checklist_for_test_cases_unscripted_test_case` (`unscripted_id`),
  CONSTRAINT `FK_checklist_for_test_cases_df` FOREIGN KEY (`discrepancy_id`) REFERENCES `discrepancy_form` (`id`),
  CONSTRAINT `FK_checklist_for_test_cases_iq_test_cases` FOREIGN KEY (`test_case_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK_checklist_for_test_cases_unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`),
  CONSTRAINT `FK_checklist_for_test_cases_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.checklist_for_test_cases: ~0 rows (approximately)
DELETE FROM `checklist_for_test_cases`;
/*!40000 ALTER TABLE `checklist_for_test_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_for_test_cases` ENABLE KEYS */;

-- Dumping structure for table license_db.checklist_for_urs
DROP TABLE IF EXISTS `checklist_for_urs`;
CREATE TABLE IF NOT EXISTS `checklist_for_urs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `urs_id` bigint(20) unsigned NOT NULL,
  `checklist_name` varchar(500) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `display_order` int(10) unsigned NOT NULL DEFAULT 0,
  `completed_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_checklist_for_urs_urs` (`urs_id`),
  CONSTRAINT `FK_checklist_for_urs_urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.checklist_for_urs: ~0 rows (approximately)
DELETE FROM `checklist_for_urs`;
/*!40000 ALTER TABLE `checklist_for_urs` DISABLE KEYS */;
/*!40000 ALTER TABLE `checklist_for_urs` ENABLE KEYS */;

-- Dumping structure for table license_db.clean_room
DROP TABLE IF EXISTS `clean_room`;
CREATE TABLE IF NOT EXISTS `clean_room` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clean_room_code` varchar(50) NOT NULL,
  `org_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `classification` varchar(50) DEFAULT NULL,
  `room_no` varchar(50) DEFAULT NULL,
  `room_name` varchar(50) NOT NULL,
  `building` varchar(50) DEFAULT NULL,
  `floor` varchar(50) DEFAULT NULL,
  `status` varchar(200) NOT NULL,
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_clean_room_organization_info` (`org_id`) USING BTREE,
  KEY `FK_clean_room_location` (`location_id`) USING BTREE,
  KEY `FK_clean_room_users` (`created_by`) USING BTREE,
  KEY `FK_clean_room_users_2` (`updated_by`) USING BTREE,
  KEY `FK_clean_room_project_setup` (`project_id`),
  KEY `FK_clean_room_project_version` (`version_id`),
  CONSTRAINT `FK_clean_room_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_clean_room_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_clean_room_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_clean_room_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_clean_room_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_clean_room_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clean_room: ~0 rows (approximately)
DELETE FROM `clean_room`;
/*!40000 ALTER TABLE `clean_room` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_room` ENABLE KEYS */;

-- Dumping structure for table license_db.clean_room_department
DROP TABLE IF EXISTS `clean_room_department`;
CREATE TABLE IF NOT EXISTS `clean_room_department` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clean_room_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_clean_room_department_clean_room` (`clean_room_id`) USING BTREE,
  KEY `FK_clean_room_department_department` (`department_id`) USING BTREE,
  CONSTRAINT `FK_clean_room_department_clean_room` FOREIGN KEY (`clean_room_id`) REFERENCES `clean_room` (`id`),
  CONSTRAINT `FK_clean_room_department_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clean_room_department: ~0 rows (approximately)
DELETE FROM `clean_room_department`;
/*!40000 ALTER TABLE `clean_room_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_room_department` ENABLE KEYS */;

-- Dumping structure for table license_db.clean_room_equipment
DROP TABLE IF EXISTS `clean_room_equipment`;
CREATE TABLE IF NOT EXISTS `clean_room_equipment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clean_room_id` bigint(20) unsigned NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_clean_room_equipment_clean_room` (`clean_room_id`) USING BTREE,
  KEY `FK_clean_room_equipment_equipment` (`equipment_id`) USING BTREE,
  CONSTRAINT `FK_clean_room_equipment_clean_room` FOREIGN KEY (`clean_room_id`) REFERENCES `clean_room` (`id`),
  CONSTRAINT `FK_clean_room_equipment_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clean_room_equipment: ~0 rows (approximately)
DELETE FROM `clean_room_equipment`;
/*!40000 ALTER TABLE `clean_room_equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_room_equipment` ENABLE KEYS */;

-- Dumping structure for table license_db.clean_room_specification
DROP TABLE IF EXISTS `clean_room_specification`;
CREATE TABLE IF NOT EXISTS `clean_room_specification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `clean_room_id` bigint(20) unsigned NOT NULL,
  `length` int(11) NOT NULL,
  `width` int(11) NOT NULL,
  `height` int(11) NOT NULL,
  `total_area` int(11) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_clean_room_specification_clean_room` (`clean_room_id`),
  KEY `FK_clean_room_specification_users` (`created_by`),
  KEY `FK_clean_room_specification_users_2` (`updated_by`),
  CONSTRAINT `FK_clean_room_specification_clean_room` FOREIGN KEY (`clean_room_id`) REFERENCES `clean_room` (`id`),
  CONSTRAINT `FK_clean_room_specification_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_clean_room_specification_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clean_room_specification: ~0 rows (approximately)
DELETE FROM `clean_room_specification`;
/*!40000 ALTER TABLE `clean_room_specification` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_room_specification` ENABLE KEYS */;

-- Dumping structure for table license_db.clean_room_specification_table_data
DROP TABLE IF EXISTS `clean_room_specification_table_data`;
CREATE TABLE IF NOT EXISTS `clean_room_specification_table_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `specification_id` bigint(20) unsigned NOT NULL,
  `category` varchar(250) DEFAULT NULL,
  `field` varchar(250) NOT NULL,
  `value` varchar(250) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_clean_room_specification_table_data_clean_room_specification` (`specification_id`),
  KEY `FK_clean_room_specification_table_data_users` (`created_by`),
  KEY `FK_clean_room_specification_table_data_users_2` (`updated_by`),
  CONSTRAINT `FK_clean_room_specification_table_data_clean_room_specification` FOREIGN KEY (`specification_id`) REFERENCES `clean_room_specification` (`id`),
  CONSTRAINT `FK_clean_room_specification_table_data_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_clean_room_specification_table_data_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clean_room_specification_table_data: ~0 rows (approximately)
DELETE FROM `clean_room_specification_table_data`;
/*!40000 ALTER TABLE `clean_room_specification_table_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `clean_room_specification_table_data` ENABLE KEYS */;

-- Dumping structure for table license_db.clone_project_with_data
DROP TABLE IF EXISTS `clone_project_with_data`;
CREATE TABLE IF NOT EXISTS `clone_project_with_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `with_data_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.clone_project_with_data: ~0 rows (approximately)
DELETE FROM `clone_project_with_data`;
/*!40000 ALTER TABLE `clone_project_with_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `clone_project_with_data` ENABLE KEYS */;

-- Dumping structure for table license_db.constant
DROP TABLE IF EXISTS `constant`;
CREATE TABLE IF NOT EXISTS `constant` (
  `constant_value` varchar(50) NOT NULL,
  `value` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`constant_value`),
  UNIQUE KEY `constant_value` (`constant_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.constant: ~4 rows (approximately)
DELETE FROM `constant`;
/*!40000 ALTER TABLE `constant` DISABLE KEYS */;
INSERT INTO `constant` (`constant_value`, `value`) VALUES
	('clone_schedular', '*/10 * * * * *'),
	('default_file_size', '10'),
	('mock_api', 'N'),
	('periodic_review', '1');
/*!40000 ALTER TABLE `constant` ENABLE KEYS */;

-- Dumping structure for table license_db.criticality_level
DROP TABLE IF EXISTS `criticality_level`;
CREATE TABLE IF NOT EXISTS `criticality_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `critical_level_name` varchar(50) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.criticality_level: ~3 rows (approximately)
DELETE FROM `criticality_level`;
/*!40000 ALTER TABLE `criticality_level` DISABLE KEYS */;
INSERT INTO `criticality_level` (`id`, `critical_level_name`, `order_id`) VALUES
	(1, 'Low', 1),
	(2, 'Medium', 2),
	(3, 'High', 3);
/*!40000 ALTER TABLE `criticality_level` ENABLE KEYS */;

-- Dumping structure for table license_db.csv_templates
DROP TABLE IF EXISTS `csv_templates`;
CREATE TABLE IF NOT EXISTS `csv_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `doc_type` varchar(50) NOT NULL,
  `template_name` varchar(150) DEFAULT NULL,
  `org_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_csv_templates_organization_info` (`org_id`),
  KEY `FK_csv_templates_project_setup` (`project_id`),
  KEY `FK_csv_templates_users` (`created_by`),
  KEY `FK_csv_templates_permissions` (`doc_type`),
  CONSTRAINT `FK_csv_templates_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_csv_templates_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_csv_templates_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.csv_templates: ~0 rows (approximately)
DELETE FROM `csv_templates`;
/*!40000 ALTER TABLE `csv_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `csv_templates` ENABLE KEYS */;

-- Dumping structure for table license_db.csv_templates_child
DROP TABLE IF EXISTS `csv_templates_child`;
CREATE TABLE IF NOT EXISTS `csv_templates_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `csv_temp_id` bigint(20) unsigned NOT NULL,
  `csv_variables` varchar(200) NOT NULL,
  `csv_lables` varchar(200) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_csv_templates_child_csv_templates` (`csv_temp_id`),
  CONSTRAINT `FK_csv_templates_child_csv_templates` FOREIGN KEY (`csv_temp_id`) REFERENCES `csv_templates` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.csv_templates_child: ~0 rows (approximately)
DELETE FROM `csv_templates_child`;
/*!40000 ALTER TABLE `csv_templates_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `csv_templates_child` ENABLE KEYS */;

-- Dumping structure for table license_db.current_project_of_user
DROP TABLE IF EXISTS `current_project_of_user`;
CREATE TABLE IF NOT EXISTS `current_project_of_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_current_project_of_user_users` (`user_id`),
  KEY `FK_current_project_of_user_project_setup` (`project_id`),
  KEY `FK_current_project_of_user_location` (`location_id`),
  CONSTRAINT `FK_current_project_of_user_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_current_project_of_user_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_current_project_of_user_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.current_project_of_user: ~0 rows (approximately)
DELETE FROM `current_project_of_user`;
/*!40000 ALTER TABLE `current_project_of_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `current_project_of_user` ENABLE KEYS */;

-- Dumping structure for table license_db.custom_excel_details
DROP TABLE IF EXISTS `custom_excel_details`;
CREATE TABLE IF NOT EXISTS `custom_excel_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `custom_pdf_settings_id` bigint(20) unsigned NOT NULL,
  `reference_id` varchar(50) NOT NULL,
  `sheet_no` int(11) NOT NULL,
  `row_no` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__custom_pdf_settings` (`custom_pdf_settings_id`),
  CONSTRAINT `FK__custom_pdf_settings` FOREIGN KEY (`custom_pdf_settings_id`) REFERENCES `custom_pdf_settings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.custom_excel_details: ~0 rows (approximately)
DELETE FROM `custom_excel_details`;
/*!40000 ALTER TABLE `custom_excel_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_excel_details` ENABLE KEYS */;

-- Dumping structure for table license_db.custom_pdf_settings
DROP TABLE IF EXISTS `custom_pdf_settings`;
CREATE TABLE IF NOT EXISTS `custom_pdf_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `org_id` bigint(20) unsigned NOT NULL DEFAULT 2,
  `doc_type` varchar(50) NOT NULL,
  `single_doc` varchar(1) NOT NULL DEFAULT 'Y',
  `workFlow` varchar(1) NOT NULL DEFAULT 'Y',
  `freeze_history` varchar(1) NOT NULL DEFAULT 'N',
  `file_path` varchar(300) DEFAULT NULL,
  `mapping_id` bigint(20) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `watermark` varchar(100) DEFAULT NULL,
  `updatedBy` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `prefix` varchar(50) NOT NULL DEFAULT '',
  `suffix` varchar(50) NOT NULL DEFAULT '',
  `sequence_number_limit` int(11) NOT NULL DEFAULT 4,
  `sequence_number_start_from` int(11) NOT NULL DEFAULT 0,
  `use_in_bulk_approval` varchar(1) NOT NULL DEFAULT 'Y',
  `customised_file_name` varchar(150) DEFAULT NULL,
  `reference_file_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_for_custom_pdf_project_against` (`project_id`),
  KEY `FK2_for_updated_by_pdf` (`updatedBy`),
  KEY `FK3_for_dco_type` (`doc_type`),
  KEY `FK_custom_pdf_settings_organization1_info` (`org_id`),
  CONSTRAINT `FK1_for_custom_pdf_project_against` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK2_for_updated_by_pdf` FOREIGN KEY (`updatedBy`) REFERENCES `users` (`id`),
  CONSTRAINT `FK3_for_dco_type` FOREIGN KEY (`doc_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_custom_pdf_settings_organization1_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.custom_pdf_settings: ~0 rows (approximately)
DELETE FROM `custom_pdf_settings`;
/*!40000 ALTER TABLE `custom_pdf_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_pdf_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.default_pdf
DROP TABLE IF EXISTS `default_pdf`;
CREATE TABLE IF NOT EXISTS `default_pdf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `org_id` bigint(20) unsigned NOT NULL DEFAULT 2,
  `document_type` varchar(50) DEFAULT NULL,
  `document_number` varchar(100) DEFAULT NULL,
  `form_mapping_id` bigint(20) unsigned DEFAULT NULL,
  `font_family` varchar(50) NOT NULL DEFAULT 'TIMES_ROMAN',
  `pdf_password` varchar(50) DEFAULT NULL,
  `pdf_water_mark` varchar(50) DEFAULT NULL,
  `pdf_doc_status_water_mark` varchar(50) DEFAULT NULL,
  `border_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) NOT NULL,
  `landscape_flag` varchar(1) NOT NULL DEFAULT 'N',
  `toc_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_application_css_styles_project_setup` (`project_id`) USING BTREE,
  KEY `FK_application_css_styles_users1` (`created_by`) USING BTREE,
  KEY `FK_application_css_styles_master_form_mapping1` (`form_mapping_id`) USING BTREE,
  KEY `FK_application_css_styles_permissions1` (`document_type`) USING BTREE,
  KEY `FK_default_pdf_organization_info` (`org_id`),
  CONSTRAINT `FK_application_css_styles_master_form_mapping1` FOREIGN KEY (`form_mapping_id`) REFERENCES `master_form_mapping` (`id`),
  CONSTRAINT `FK_application_css_styles_permissions1` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_application_css_styles_project_setup1` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_application_css_styles_users1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_default_pdf_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_pdf: ~0 rows (approximately)
DELETE FROM `default_pdf`;
/*!40000 ALTER TABLE `default_pdf` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_pdf` ENABLE KEYS */;

-- Dumping structure for table license_db.default_pdf_checklist
DROP TABLE IF EXISTS `default_pdf_checklist`;
CREATE TABLE IF NOT EXISTS `default_pdf_checklist` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `checklist_id` bigint(20) NOT NULL DEFAULT 0,
  `default_pdf_id` bigint(20) unsigned NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `page_break_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_default_pdf_checklist_pdf_chapter_check_list` (`checklist_id`) USING BTREE,
  KEY `FK_default_pdf_checklist_application_css_styles` (`default_pdf_id`) USING BTREE,
  CONSTRAINT `FK_default_pdf_checklist_application_css_styles` FOREIGN KEY (`default_pdf_id`) REFERENCES `default_pdf` (`id`),
  CONSTRAINT `FK_default_pdf_checklist_pdf_chapter_check_list` FOREIGN KEY (`checklist_id`) REFERENCES `pdf_chapter_check_list` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_pdf_checklist: ~0 rows (approximately)
DELETE FROM `default_pdf_checklist`;
/*!40000 ALTER TABLE `default_pdf_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_pdf_checklist` ENABLE KEYS */;

-- Dumping structure for table license_db.default_pdf_select_variables
DROP TABLE IF EXISTS `default_pdf_select_variables`;
CREATE TABLE IF NOT EXISTS `default_pdf_select_variables` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `default_pdf_id` bigint(20) NOT NULL,
  `document_constant_id` bigint(20) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  `variable_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_pdf_select_variables: ~0 rows (approximately)
DELETE FROM `default_pdf_select_variables`;
/*!40000 ALTER TABLE `default_pdf_select_variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_pdf_select_variables` ENABLE KEYS */;

-- Dumping structure for table license_db.default_project_for_user
DROP TABLE IF EXISTS `default_project_for_user`;
CREATE TABLE IF NOT EXISTS `default_project_for_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_default_proejct_for_user_users` (`user_id`),
  KEY `FK_default_proejct_for_user_project_setup` (`project_id`),
  KEY `FK_default_project_for_user_location` (`location_id`),
  CONSTRAINT `FK_default_proejct_for_user_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_default_proejct_for_user_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_default_project_for_user_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_project_for_user: ~0 rows (approximately)
DELETE FROM `default_project_for_user`;
/*!40000 ALTER TABLE `default_project_for_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_project_for_user` ENABLE KEYS */;

-- Dumping structure for table license_db.default_risk_matrix_size
DROP TABLE IF EXISTS `default_risk_matrix_size`;
CREATE TABLE IF NOT EXISTS `default_risk_matrix_size` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `value` bigint(20) NOT NULL DEFAULT 0,
  `type` varchar(50) DEFAULT NULL,
  `min` int(11) DEFAULT NULL,
  `max` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_default_risk_matrix_size_project_setup` (`project_id`),
  CONSTRAINT `FK_default_risk_matrix_size_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_risk_matrix_size: ~0 rows (approximately)
DELETE FROM `default_risk_matrix_size`;
/*!40000 ALTER TABLE `default_risk_matrix_size` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_risk_matrix_size` ENABLE KEYS */;

-- Dumping structure for table license_db.default_template_for_org
DROP TABLE IF EXISTS `default_template_for_org`;
CREATE TABLE IF NOT EXISTS `default_template_for_org` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned DEFAULT 0,
  `template_for` varchar(50) DEFAULT NULL,
  `template_id` bigint(20) unsigned DEFAULT 0,
  `created_by` bigint(20) unsigned DEFAULT 0,
  `updated_by` bigint(20) unsigned DEFAULT 0,
  `created_time` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_time` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_project_template_project_setup` (`org_id`),
  KEY `FK_project_template_email_template_config` (`template_id`),
  KEY `FK_project_template_users` (`created_by`),
  KEY `FK_project_template_users_2` (`updated_by`),
  CONSTRAINT `FK_project_template_settings_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_template_email_template_config` FOREIGN KEY (`template_id`) REFERENCES `email_template_config` (`id`),
  CONSTRAINT `FK_template_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_template_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.default_template_for_org: ~0 rows (approximately)
DELETE FROM `default_template_for_org`;
/*!40000 ALTER TABLE `default_template_for_org` DISABLE KEYS */;
/*!40000 ALTER TABLE `default_template_for_org` ENABLE KEYS */;

-- Dumping structure for table license_db.department
DROP TABLE IF EXISTS `department`;
CREATE TABLE IF NOT EXISTS `department` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `department_name` varchar(50) NOT NULL,
  `department_code` varchar(50) NOT NULL DEFAULT '',
  `location` bigint(20) unsigned DEFAULT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `organization_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_department_users` (`created_by`),
  KEY `FK_department_users_2` (`last_updated_by`),
  KEY `FK_department_location` (`location`),
  CONSTRAINT `FK_department_location` FOREIGN KEY (`location`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_department_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_department_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.department: ~0 rows (approximately)
DELETE FROM `department`;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
/*!40000 ALTER TABLE `department` ENABLE KEYS */;

-- Dumping structure for table license_db.department_for_master_forms
DROP TABLE IF EXISTS `department_for_master_forms`;
CREATE TABLE IF NOT EXISTS `department_for_master_forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_form_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__master_dynamic_form` (`master_form_id`),
  KEY `FK__department` (`department_id`),
  CONSTRAINT `FK__department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `FK__master_dynamic_form` FOREIGN KEY (`master_form_id`) REFERENCES `master_dynamic_form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.department_for_master_forms: ~0 rows (approximately)
DELETE FROM `department_for_master_forms`;
/*!40000 ALTER TABLE `department_for_master_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_for_master_forms` ENABLE KEYS */;

-- Dumping structure for table license_db.department_for_master_templates
DROP TABLE IF EXISTS `department_for_master_templates`;
CREATE TABLE IF NOT EXISTS `department_for_master_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_template_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_department_for_master_templates_master_dynamic_template` (`master_template_id`),
  KEY `FK_department_for_master_templates_department` (`department_id`),
  CONSTRAINT `FK_department_for_master_templates_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `FK_department_for_master_templates_master_dynamic_template` FOREIGN KEY (`master_template_id`) REFERENCES `master_dynamic_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.department_for_master_templates: ~0 rows (approximately)
DELETE FROM `department_for_master_templates`;
/*!40000 ALTER TABLE `department_for_master_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `department_for_master_templates` ENABLE KEYS */;

-- Dumping structure for table license_db.device_master
DROP TABLE IF EXISTS `device_master`;
CREATE TABLE IF NOT EXISTS `device_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) DEFAULT NULL,
  `device_mc_id` varchar(50) DEFAULT NULL,
  `device_ip_address` varchar(50) DEFAULT NULL,
  `device_os` varchar(50) DEFAULT NULL,
  `asset_id` varchar(50) DEFAULT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  `file_name` varchar(200) DEFAULT NULL,
  `purchase_date` timestamp NULL DEFAULT NULL,
  `activeFlag` varchar(1) DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_device_master_organization_info` (`org_id`),
  KEY `FK_device_master_users` (`created_by`),
  CONSTRAINT `FK_device_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_device_master_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.device_master: ~0 rows (approximately)
DELETE FROM `device_master`;
/*!40000 ALTER TABLE `device_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `device_master` ENABLE KEYS */;

-- Dumping structure for table license_db.discrepancy_form
DROP TABLE IF EXISTS `discrepancy_form`;
CREATE TABLE IF NOT EXISTS `discrepancy_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `protocol_no` int(11) DEFAULT NULL,
  `document_type` int(11) DEFAULT NULL,
  `document_code` varchar(50) DEFAULT NULL,
  `discrepancy_description` longtext DEFAULT NULL,
  `action_taken` longtext DEFAULT NULL,
  `request_raised` varchar(1) DEFAULT NULL,
  `request_no` varchar(50) DEFAULT NULL,
  `result_for_action` longtext DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT current_timestamp(),
  `delete_flag` char(1) DEFAULT 'N',
  `publish_flag` char(1) DEFAULT 'N',
  `execution_flag` char(1) DEFAULT 'N',
  `workflow_completion_flag` char(1) DEFAULT 'N',
  `version_id` bigint(20) unsigned NOT NULL,
  `investigation` longtext DEFAULT NULL,
  `root_cause` longtext DEFAULT NULL,
  `create_version` varchar(1) DEFAULT NULL,
  `category` varchar(50) DEFAULT NULL,
  `discrepancy_comment` text DEFAULT NULL,
  `solution` text DEFAULT NULL,
  `re_test_flag` varchar(1) NOT NULL DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  PRIMARY KEY (`id`),
  KEY `FK_discrepancy_form_project_setup` (`project_id`),
  KEY `FK_discrepancy_form_project_version` (`version_id`),
  KEY `FK4_user_create` (`created_by`),
  KEY `FK5_user_update` (`updated_by`),
  CONSTRAINT `FK4_user_create` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK5_user_update` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_discrepancy_form_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_discrepancy_form_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.discrepancy_form: ~0 rows (approximately)
DELETE FROM `discrepancy_form`;
/*!40000 ALTER TABLE `discrepancy_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `discrepancy_form` ENABLE KEYS */;

-- Dumping structure for table license_db.discrepancy_form_testcases
DROP TABLE IF EXISTS `discrepancy_form_testcases`;
CREATE TABLE IF NOT EXISTS `discrepancy_form_testcases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `discrepancy_form_id` bigint(20) unsigned NOT NULL,
  `test_case_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_discrepancy_form_testcases_discrepancy_form` (`discrepancy_form_id`),
  KEY `FK_discrepancy_form_testcases_iq_test_cases` (`test_case_id`),
  CONSTRAINT `FK_discrepancy_form_testcases_discrepancy_form` FOREIGN KEY (`discrepancy_form_id`) REFERENCES `discrepancy_form` (`id`),
  CONSTRAINT `FK_discrepancy_form_testcases_iq_test_cases` FOREIGN KEY (`test_case_id`) REFERENCES `iq_test_cases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.discrepancy_form_testcases: ~0 rows (approximately)
DELETE FROM `discrepancy_form_testcases`;
/*!40000 ALTER TABLE `discrepancy_form_testcases` DISABLE KEYS */;
/*!40000 ALTER TABLE `discrepancy_form_testcases` ENABLE KEYS */;

-- Dumping structure for table license_db.discrepancy_log
DROP TABLE IF EXISTS `discrepancy_log`;
CREATE TABLE IF NOT EXISTS `discrepancy_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `df_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK1_for_testcase` (`testcase_id`),
  KEY `FK2_df` (`df_id`),
  CONSTRAINT `FK1_for_testcase` FOREIGN KEY (`testcase_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK2_df` FOREIGN KEY (`df_id`) REFERENCES `discrepancy_form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.discrepancy_log: ~0 rows (approximately)
DELETE FROM `discrepancy_log`;
/*!40000 ALTER TABLE `discrepancy_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `discrepancy_log` ENABLE KEYS */;

-- Dumping structure for table license_db.document_constants
DROP TABLE IF EXISTS `document_constants`;
CREATE TABLE IF NOT EXISTS `document_constants` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `variable_name` varchar(500) NOT NULL,
  `unique_code` varchar(100) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_constants: ~168 rows (approximately)
DELETE FROM `document_constants`;
/*!40000 ALTER TABLE `document_constants` DISABLE KEYS */;
INSERT INTO `document_constants` (`id`, `document_type`, `variable_name`, `unique_code`, `order`) VALUES
	(1, '107', 'Code', 'ursCode', 1),
	(2, '107', 'Requirement', 'ursRequirement', 2),
	(3, '107', 'Description', 'ursDescription', 3),
	(4, '107', 'Category', 'ursCategory', 4),
	(5, '107', 'Priority', 'ursPriority', 5),
	(6, 'WorkFlow', 'Code', 'wfdocCode', 1),
	(7, 'WorkFlow', 'Type', 'wfType', 2),
	(8, 'WorkFlow', 'Level Name', 'wfLevelName', 3),
	(9, 'WorkFlow', 'Action Taken', 'wfActionTaken', 4),
	(10, 'WorkFlow', 'Date Time', 'wfDateTime', 5),
	(11, 'WorkFlow', 'Comments', 'wfComment', 6),
	(12, 'WorkFlow', 'ESign', 'wfEsign', 7),
	(13, '108', 'Testcase Code', 'tcIqtcCode', 1),
	(14, '108', 'Test Description', 'tcIqtcDescription', 2),
	(15, '108', 'Urs', 'tcIqtcURS', 3),
	(16, '108', 'Expected Result', 'tcIqtcExpectedResult', 4),
	(17, '108', 'Status', 'tcIqtcStatus', 6),
	(18, '109', 'Testcase Code', 'tcPqtcCode', 1),
	(19, '109', 'Test Description', 'tcPqtcDescription', 2),
	(20, '109', 'Urs', 'tcPqtcURS', 3),
	(21, '109', 'Expected Result', 'tcPqtcExpectedResult', 4),
	(22, '109', 'Actual Result', 'tcPqtcActualResult', 5),
	(23, '109', 'Status', 'tcPqtcStatus', 6),
	(24, '110', 'Testcase Code', 'tcOqtcCode', 1),
	(25, '110', 'Test Description', 'tcOqtcDescription', 2),
	(26, '110', 'Urs', 'tcOqtcURS', 3),
	(27, '110', 'Expected Result', 'tcOqtcExpectedResult', 4),
	(28, '110', 'Actual Result', 'tcOqtcActualResult', 5),
	(29, '110', 'Status', 'tcOqtcStatus', 6),
	(30, '113', 'Risk Code', 'riskCode', 1),
	(31, '113', 'Risk Factor', 'riskFactor', 3),
	(32, '113', 'Risk Scenario', 'riskScnerio', 4),
	(33, '113', 'Urs', 'riskURS', 2),
	(34, '113', 'Cause of Risk', 'riskCauseOfRisk', 5),
	(35, '113', 'Proposed Mitigation', 'riskProposedMigration', 10),
	(36, '113', 'Probability', 'riskProbability', 6),
	(37, '113', 'Severity', 'riskSeverity', 7),
	(38, '113', 'Detectability', 'riskDetectablity', 8),
	(39, '113', 'Priority', 'riskPriority', 9),
	(40, '113', 'RPN', 'riskRPN', 11),
	(41, '137', 'Objective & Purpose', 'vsrObjectiveAndPurpose', 1),
	(42, '137', 'Scope', 'vsrScope', 2),
	(43, '137', 'Validation Summary', 'vsrValidationSummary', 3),
	(45, '137', 'Risk Assessment', 'vsrRiskAssessment', 5),
	(46, '137', 'Summary of Deviations', 'vsrSummaryOfDeviations', 6),
	(47, '137', 'Observations and Recommendation', 'vsrObserationsAndRecommendation', 7),
	(49, '137', 'Validation Expiry Date', 'vsrValidationExpiryDate', 9),
	(50, '134', 'Discrepancy Description', 'dfDescription', 2),
	(51, '134', 'Change Request No', 'dfChangeRequestNo', 3),
	(52, '134', 'Action to be taken', 'dfActionToBeTaken', 4),
	(53, '134', 'Result from action', 'dfResultFromAction', 5),
	(54, '134', 'Status', 'dfStatus', 6),
	(55, '100', 'Project Name', 'projectProjectName', 1),
	(56, '100', 'Project Code', 'projectProjectCode', 2),
	(57, '100', 'Department', 'projectDepartment', 7),
	(58, '100', 'Introduction', 'projectIntroduction', 8),
	(59, '100', 'Purpose', 'projectPurposeAndScope', 9),
	(60, '100', 'Scope', 'projectDescription', 10),
	(61, '141', 'Equipment Name', 'eqEquipmentName', 1),
	(62, '141', 'Equipment Code', 'eqEquipmentCode', 2),
	(63, '141', 'Date Of Purchase', 'eqDateOfPurchase', 3),
	(64, '141', 'Make / Manufactured By', 'eqMakeOrManufactureBy', 4),
	(65, '141', 'Supplied / Sold By', 'eqSuppliedOrSoldBy', 5),
	(66, '141', 'Model', 'eqModel', 6),
	(67, '141', 'Total Capacity', 'eqTotalCapacity', 7),
	(68, '141', 'Recommended usage Capacity', 'eqRecommendedUsageCapacity', 8),
	(69, '141', 'Location', 'eqLocation', 9),
	(70, '141', 'Initial IQ completion Date', 'eqIQCompletionDate', 10),
	(71, '141', 'Initial OQ completion Date', 'eqOQCompeletionDate', 11),
	(77, '141', 'Facility', 'eqFacility', 17),
	(78, '163', 'Product Name', 'batchProductName', 1),
	(79, '163', 'Batch No', 'batchBatchNo', 2),
	(80, '163', 'Batch Quantity', 'batchBatchQuantity', 3),
	(81, '163', 'Status', 'batchStatus', 4),
	(82, '191', 'Department', 'ccDepartment', 2),
	(83, '191', 'type', 'ccType', 3),
	(84, '191', 'title', 'ccTitle', 4),
	(85, '191', 'Description', 'ccDescription', 6),
	(86, '191', 'priority', 'ccPriority', 7),
	(87, '191', 'status', 'ccStatus', 11),
	(88, '100', 'Expected Start Date', 'projectExpStartDate', 3),
	(89, '100', 'Expected End Date', 'projectExpEndDate', 4),
	(90, '100', 'Change Control Number', 'projectCCFNumber', 6),
	(91, '100', 'GAMP Category', 'projectGAMPCategory', 11),
	(92, '100', 'Project Version', 'projectProjectVersion', 0),
	(93, 'WorkFlowIndividual', 'Type', 'wfiType', 1),
	(94, 'WorkFlowIndividual', 'Level Name', 'wfiLevelName', 2),
	(95, 'WorkFlowIndividual', 'Action Taken', 'wfiActionTaken', 3),
	(96, 'WorkFlowIndividual', 'Date Time', 'wfiDateTime', 4),
	(97, 'WorkFlowIndividual', 'Comments', 'wfiComments', 5),
	(98, 'WorkFlowIndividual', 'ESign', 'wfiEsign', 6),
	(99, 'WorkFlowIndividual', 'Action Taken Department', 'wfiActionTakenDept', 7),
	(100, 'WorkFlowIndividual', 'Action Taken Designation', 'wfiActionTakenDesigation', 8),
	(101, 'WorkFlowIndividual', 'Action Taken Role', 'wfiActionTakenRole', 9),
	(102, 'FreezeHistory', 'Lock/Unlock', 'fhLockOrUnLock', 1),
	(103, 'FreezeHistory', 'Revision Number', 'fhRevisionNumber', 2),
	(104, 'FreezeHistory', 'Action Taken', 'fhActionTaken', 3),
	(105, 'FreezeHistory', 'Date Time', 'fhDateTime', 4),
	(106, 'FreezeHistory', 'Comments', 'fhComment', 5),
	(107, '108', 'Actual Result', 'tcIqtcActualResult', 5),
	(108, '134', 'Category', 'dfCategory', 7),
	(109, '134', 'Document Type', 'dfDocumentType', 1),
	(110, 'WorkFlowIndividual', 'Code', 'wfiCode', 0),
	(111, 'WorkFlow', 'Action Taken Department', 'wfActionTakenDept', 8),
	(112, 'WorkFlow', 'Action Taken Designation', 'wfActionTakenDesigation', 9),
	(113, 'WorkFlow', 'Action Taken Role', 'wfActionTakenRole', 0),
	(114, '128', 'Vendor Code', 'vendorCode', 1),
	(115, '128', 'Document Name', 'vendorDocumentName', 2),
	(118, '191', 'ImpactAssessment', 'ccImpactAssessment', 9),
	(119, '191', 'Reason', 'ccReason', 8),
	(120, '191', 'RiskAssessment', 'ccRiskAssement', 10),
	(121, '191', 'code', 'ccCode', 1),
	(122, '191', 'users', 'ccUsers', 5),
	(123, '100', 'Location', 'projectLocation', 13),
	(124, '100', 'Type', 'projectType', 14),
	(125, '100', 'Software Name', 'projectSoftwareName', 15),
	(126, '100', 'Software Version', 'projectSoftwareVersion', 16),
	(127, '100', 'Use', 'projectUse', 17),
	(128, '100', 'GXP Criticality', 'projectGXPCriticality', 18),
	(129, '100', 'ER Applicability', 'projectERApplicability', 19),
	(130, '100', 'ES Applicability', 'projectESApplicability', 20),
	(131, '100', 'Type Of System', 'projectTypeOfSystem', 21),
	(132, '100', 'Validation Status', 'projectValidationStatus', 22),
	(133, '100', 'Validation Strategy', 'projectValidationStrategy', 23),
	(134, '100', 'Acceptance Criteria', 'projectAcceptanceCriteria', 24),
	(135, 'Template', 'Template Code', 'templateCode', 1),
	(136, 'Template', 'Template Name', 'templateDocumentName', 2),
	(137, 'WorkFlowIndividual', 'Date', 'wfiDate', 10),
	(138, 'WorkFlowIndividual', 'Time', 'wfiTime', 11),
	(139, 'FreezeHistory', 'Date', 'fhDate', 6),
	(140, 'FreezeHistory', 'Time', 'fhTime', 7),
	(141, 'WorkFlow', 'Date', 'wfDate', 10),
	(142, 'WorkFlow', 'Time', 'wfTime', 11),
	(143, '200', 'SpType', 'spType', 3),
	(144, '200', 'SpDescription', 'spDescription', 4),
	(145, '200', 'SpCode', 'spCode', 1),
	(146, '200', 'SpURS', 'spURS', 2),
	(147, 'WorkFlowIndividual', 'Responsibility', 'wfiResponsibility', 12),
	(148, 'WorkFlow', 'Responsibility', 'wfResponsibility', 12),
	(149, '108', 'Specification', 'tcIqtcSpecification', 3),
	(150, '109', 'Specification', 'tcPqtcSpecification', 3),
	(151, '110', 'Specification', 'tcOqtcSpecification', 3),
	(152, '113', 'Specification', 'riskSpecification', 2),
	(153, '113', 'Criticality', 'riskCriticality', 12),
	(154, '108', 'Risk Assessment', 'tcIqtcRiskAssessment', 3),
	(155, '109', 'Risk Assessment', 'tcPqtcRiskAssessment', 3),
	(156, '110', 'Risk Assessment', 'tcOqtcRiskAssessment', 3),
	(157, '207', 'Testcase Code', 'tcIoqtcCode', 1),
	(158, '207', 'Test Description', 'tcIoqtcDescription', 2),
	(159, '207', 'Urs', 'tcIoqtcURS', 3),
	(160, '207', 'Specification', 'tcIoqtcSpecification', 3),
	(161, '207', 'Risk Assessment', 'tcIoqtcRiskAssessment', 3),
	(162, '207', 'Expected Result', 'tcIoqtcExpectedResult', 4),
	(163, '207', 'Actual Result', 'tcIoqtcActualResult', 5),
	(164, '207', 'Status', 'tcIoqtcStatus', 6),
	(165, '208', 'Testcase Code', 'tcOpqtcCode', 1),
	(166, '208', 'Test Description', 'tcOpqtcDescription', 2),
	(167, '208', 'Urs', 'tcOpqtcURS', 3),
	(168, '208', 'Specification', 'tcOpqtcSpecification', 3),
	(169, '208', 'Risk Assessment', 'tcOpqtcRiskAssessment', 3),
	(170, '208', 'Expected Result', 'tcOpqtcExpectedResult', 4),
	(171, '208', 'Actual Result', 'tcOpqtcActualResult', 5),
	(172, '208', 'Status', 'tcOpqtcStatus', 6),
	(173, '100', 'System Status', 'projectSystemStatus', 25),
	(174, '100', 'Supplier Name', 'projectSupplierName', 26),
	(175, '100', 'Hosting Type', 'projectHostingType', 27),
	(176, '100', 'Release Date', 'projectReleaseDate', 28),
	(177, '219', 'Cleanroom code', 'code', 1);
/*!40000 ALTER TABLE `document_constants` ENABLE KEYS */;

-- Dumping structure for table license_db.document_constants_default_pdf
DROP TABLE IF EXISTS `document_constants_default_pdf`;
CREATE TABLE IF NOT EXISTS `document_constants_default_pdf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `variable_name` varchar(50) NOT NULL,
  `variable_key` varchar(50) NOT NULL,
  `variable_order` int(11) NOT NULL DEFAULT 0,
  `table_width` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_constants_default_pdf: ~184 rows (approximately)
DELETE FROM `document_constants_default_pdf`;
/*!40000 ALTER TABLE `document_constants_default_pdf` DISABLE KEYS */;
INSERT INTO `document_constants_default_pdf` (`id`, `document_type`, `variable_name`, `variable_key`, `variable_order`, `table_width`) VALUES
	(1, '107', 'URS ID', 'ursId', 1, 2),
	(2, '108', 'Test Case Id', 'testCaseId', 1, 2),
	(3, '200', 'Type', 'type', 1, 4),
	(4, '113', 'Risk ID', 'riskId', 1, 2),
	(5, '201', 'SPEC ID', 'specId', 1, 2),
	(6, '100', 'Sr No', 'srNo', 1, 2),
	(7, 'revision', 'Version', 'version', 1, 4),
	(8, '137', 'Sl no', 'slno', 1, 1),
	(9, '109', 'Test Case Id', 'testCaseId', 1, 2),
	(10, '207', 'Test Case Id', 'testCaseId', 1, 2),
	(11, '208', 'Test Case Id', 'testCaseId', 1, 2),
	(12, '107', 'Requirement', 'ursRequirement', 2, 4),
	(13, '108', 'Mapped Document', 'mappedDocument', 2, 4),
	(14, '200', 'Description', 'description', 2, 4),
	(15, '113', 'Severity', 'severity', 2, 2),
	(16, '201', 'Test Description', 'testDescription', 2, 4),
	(17, '100', 'User Name', 'userName', 2, 4),
	(18, 'approval', 'User Name', 'userName', 2, 4),
	(19, '203', 'Project Name', 'projectName', 2, 4),
	(20, 'revision', 'Date', 'date', 2, 4),
	(21, '102', 'User Name', 'userName', 2, 4),
	(22, '137', 'Document Name', 'documentName', 2, 5),
	(23, '109', 'Mapped Document', 'mappedDocument', 2, 4),
	(24, '207', 'Mapped Document', 'mappedDocument', 2, 4),
	(25, '208', 'Mapped Document', 'mappedDocument', 2, 4),
	(26, '107', 'Description', 'ursDescription', 3, 8),
	(27, '108', 'Environment ', 'environment', 3, 2),
	(28, '200', 'URS', 'mappedDocument', 3, 4),
	(29, '113', 'Risk Factor', 'riskFactor', 3, 2),
	(30, '201', 'Type', 'type', 3, 4),
	(31, '100', 'First Name', 'fName', 3, 4),
	(32, 'approval', 'First Name', 'fName', 3, 4),
	(33, '203', 'Project Code', 'projectCode', 3, 4),
	(34, 'revision', 'Date Time', 'datetime', 3, 4),
	(35, '102', 'Event', 'event', 3, 4),
	(36, '137', 'Document Number', 'documentNumber', 3, 3),
	(37, '109', 'Environment ', 'environment', 3, 2),
	(38, '207', 'Environment ', 'environment', 3, 2),
	(39, '208', 'Environment ', 'environment', 3, 2),
	(40, '107', 'Category', 'ursCategory', 4, 4),
	(41, '108', 'Test Run', 'testRun', 4, 2),
	(42, '200', 'SPEC ID', 'specId', 4, 2),
	(43, '200', 'Created By', 'createdBy', 4, 2),
	(44, '200', 'Created Time', 'createdTime', 4, 2),
	(45, '113', 'Detectability', 'detectability', 4, 2),
	(46, '201', 'Environment ', 'environment', 4, 4),
	(47, '100', 'Last Name', 'lName', 4, 4),
	(48, 'approval', 'Last Name', 'lName', 4, 4),
	(49, '203', 'Validation Status', 'validationStatus', 4, 4),
	(50, 'revision', 'Time', 'time', 4, 4),
	(51, '102', 'IP', 'ip', 4, 4),
	(52, '137', 'Approval Date', 'approvalDate', 4, 4),
	(53, '109', 'Test Run', 'testRun', 4, 2),
	(54, '207', 'Test Run', 'testRun', 4, 2),
	(55, '208', 'Test Run', 'testRun', 4, 2),
	(56, '107', 'Priority Name', 'ursPriorityName', 5, 4),
	(57, '108', 'Test Description', 'testDescription', 5, 4),
	(58, '113', 'Risk Scenario', 'riskScenario', 5, 2),
	(59, '201', 'Status', 'status', 5, 4),
	(60, '100', 'Full Name', 'fullName', 5, 4),
	(61, 'approval', 'Full Name', 'fullName', 5, 4),
	(62, '203', 'System Status', 'systemStatus', 5, 4),
	(63, 'revision', 'Revision Summary', 'comment', 5, 4),
	(64, '102', 'Created Time', 'createdTime', 5, 4),
	(65, '109', 'Test Description', 'testDescription', 5, 4),
	(66, '207', 'Test Description', 'testDescription', 5, 4),
	(67, '208', 'Test Description', 'testDescription', 5, 4),
	(68, '107', 'Priority Code', 'urspriorityCode', 6, 4),
	(69, '108', 'Acceptance Criteria', 'acceptanceCriteria', 6, 4),
	(70, '113', 'RPN', 'rpn', 6, 2),
	(71, '201', 'Test Result', 'testResult', 6, 4),
	(72, '100', 'Role', 'role', 6, 4),
	(73, 'approval', 'Role', 'role', 6, 4),
	(74, '203', 'Department', 'department', 6, 4),
	(75, '102', 'System Remarks', 'systemRemarks', 6, 8),
	(76, '109', 'Acceptance Criteria', 'acceptanceCriteria', 6, 4),
	(77, '207', 'Acceptance Criteria', 'acceptanceCriteria', 6, 4),
	(78, '208', 'Acceptance Criteria', 'acceptanceCriteria', 6, 4),
	(79, '107', 'Testing Required', 'ursTestingRequired', 7, 2),
	(80, '108', 'Pre Requisites ', 'preRequisites', 7, 4),
	(81, '113', 'Probable Cause of Risk', 'probableCauseOfRisk', 7, 2),
	(82, '201', 'Business Impact', 'businessImpact', 7, 4),
	(83, '100', 'Department', 'dept', 7, 4),
	(84, 'approval', 'Department', 'dept', 7, 4),
	(85, '203', 'System Owner', 'systemOwner', 7, 4),
	(86, '102', 'Device Info', 'deviceInfo', 7, 4),
	(87, '109', 'Pre Requisites ', 'preRequisites', 7, 4),
	(88, '207', 'Pre Requisites ', 'preRequisites', 7, 4),
	(89, '208', 'Pre Requisites ', 'preRequisites', 7, 4),
	(90, '107', 'Potential risk', 'ursPotentialRisk ', 8, 2),
	(91, '108', 'Expected Result', 'expectedResult', 8, 4),
	(92, '113', 'Criticality', 'criticality', 8, 2),
	(93, '201', 'URS', 'urs', 8, 4),
	(94, '100', 'Designation', 'designation', 8, 4),
	(95, 'approval', 'Designation', 'designation', 8, 4),
	(96, '203', 'Business Owner', 'businessOwner', 8, 4),
	(97, '102', 'User Remarks', 'userRemarks', 8, 8),
	(98, '109', 'Expected Result', 'expectedResult', 8, 4),
	(99, '207', 'Expected Result', 'expectedResult', 8, 4),
	(100, '208', 'Expected Result', 'expectedResult', 8, 4),
	(101, '107', 'Implementation Method', 'ursImplementationMethod', 9, 2),
	(102, '108', 'Actual Result', 'actualResult', 9, 4),
	(103, '113', 'Probability Of Occurance ', 'probabilityOfOccurance', 9, 2),
	(104, '201', 'Specification', 'specification', 9, 4),
	(105, 'approval', 'Signature', 'signature', 9, 4),
	(106, '203', 'Release Date', 'releaseDate', 9, 4),
	(107, '109', 'Actual Result', 'actualResult', 9, 4),
	(108, '207', 'Actual Result', 'actualResult', 9, 4),
	(109, '208', 'Actual Result', 'actualResult', 9, 4),
	(110, '107', 'Testing Method', 'ursTestingMethod', 10, 2),
	(111, '108', 'Executed By', 'testCaseExecutedBy', 10, 2),
	(112, '113', 'Priority', 'priority', 10, 2),
	(113, '201', 'Risk Assessment', 'riskAssessment', 10, 4),
	(114, 'approval', 'Date', 'date', 10, 4),
	(115, '203', 'Next Review Date', 'nextReviewDate', 10, 4),
	(116, '109', 'Executed By', 'testCaseExecutedBy', 10, 2),
	(117, '207', 'Executed By', 'testCaseExecutedBy', 10, 2),
	(118, '208', 'Executed By', 'testCaseExecutedBy', 10, 2),
	(119, '107', 'Created By', 'ursCreatedBy', 11, 2),
	(120, '108', 'Executed Time', 'testCaseExecutedTime', 11, 2),
	(121, '113', 'Proposed Mitigation', 'proposedMitigation', 11, 2),
	(122, 'approval', 'Date Time', 'datetime', 11, 4),
	(123, '203', 'GAMP Category', 'gampCategory', 11, 4),
	(124, '109', 'Executed Time', 'testCaseExecutedTime', 11, 2),
	(125, '207', 'Executed Time', 'testCaseExecutedTime', 11, 2),
	(126, '208', 'Executed Time', 'testCaseExecutedTime', 11, 2),
	(127, '107', 'Created Time', 'ursCreatedTime', 12, 2),
	(128, '108', 'Created By', 'testCaseCreatedBy', 12, 2),
	(129, '113', 'Residual Risk', 'residualRisk', 12, 6),
	(130, 'approval', 'Time', 'time', 12, 4),
	(131, '203', 'Equipment Name', 'eqName', 12, 4),
	(132, '109', 'Created By', 'testCaseCreatedBy', 12, 2),
	(133, '207', 'Created By', 'testCaseCreatedBy', 12, 2),
	(134, '208', 'Created By', 'testCaseCreatedBy', 12, 2),
	(135, '108', 'Created Time', 'testCaseCreatedTime', 13, 2),
	(136, '113', 'Created by', 'createdBy', 13, 2),
	(137, 'approval', 'Comments', 'comment', 13, 4),
	(138, '203', 'Software Name', 'softName', 13, 4),
	(139, '109', 'Created Time', 'testCaseCreatedTime', 13, 2),
	(140, '207', 'Created Time', 'testCaseCreatedTime', 13, 2),
	(141, '208', 'Created Time', 'testCaseCreatedTime', 13, 2),
	(142, '108', 'Status', 'testStatus', 14, 2),
	(143, '113', 'Created time', 'createdTime', 14, 2),
	(144, '203', 'GxP Criticality', 'gxpCriticality', 14, 4),
	(145, '109', 'Status', 'testStatus', 14, 2),
	(146, '207', 'Status', 'testStatus', 14, 2),
	(147, '208', 'Status', 'testStatus', 14, 2),
	(148, '113', 'Mapped Document', 'mappedDocument', 15, 2),
	(149, '110', 'Test Case Id', 'testCaseId', 1, 2),
	(150, '110', 'Mapped Document', 'mappedDocument', 2, 4),
	(151, '110', 'Environment ', 'environment', 3, 2),
	(152, '110', 'Test Run', 'testRun', 4, 2),
	(153, '110', 'Test Description', 'testDescription', 5, 4),
	(154, '110', 'Acceptance Criteria', 'acceptanceCriteria', 6, 4),
	(155, '110', 'Pre Requisites ', 'preRequisites', 7, 4),
	(156, '110', 'Expected Result', 'expectedResult', 8, 4),
	(157, '110', 'Actual Result', 'actualResult', 9, 4),
	(158, '110', 'Executed By', 'testCaseExecutedBy', 10, 2),
	(159, '110', 'Executed Time', 'testCaseExecutedTime', 11, 2),
	(160, '110', 'Created By', 'testCaseCreatedBy', 12, 2),
	(161, '110', 'Created Time', 'testCaseCreatedTime', 13, 2),
	(162, '110', 'Status', 'testStatus', 14, 2),
	(163, '129', 'Req ID', '107', 1, 4),
	(164, '129', 'Spec', '200', 2, 3),
	(165, '129', 'IQTC', '108', 3, 4),
	(166, '129', 'OQTC', '110', 4, 4),
	(167, '129', 'PQTC', '109', 5, 4),
	(168, '129', 'IOQTC', '207', 6, 4),
	(169, '129', 'OPQTC', '208', 7, 4),
	(170, '129', 'Unscripted Test Case', '201', 7, 4),
	(171, '129', 'Risk', '113', 8, 4),
	(172, 'pre-approval', 'User Name', 'userName', 2, 4),
	(173, 'pre-approval', 'First Name', 'fName', 3, 4),
	(174, 'pre-approval', 'Last Name', 'lName', 4, 4),
	(175, 'pre-approval', 'Full Name', 'fullName', 5, 4),
	(176, 'pre-approval', 'Role', 'role', 6, 4),
	(177, 'pre-approval', 'Department', 'dept', 7, 4),
	(178, 'pre-approval', 'Designation', 'designation', 8, 4),
	(179, 'pre-approval', 'Signature', 'signature', 9, 4),
	(180, 'pre-approval', 'Date', 'date', 10, 4),
	(181, 'pre-approval', 'Date Time', 'datetime', 11, 4),
	(182, 'pre-approval', 'Time', 'time', 12, 4),
	(183, 'pre-approval', 'Comments', 'comment', 13, 4),
	(184, 'pre-approval', 'Test Run', 'testrun', 13, 4);
/*!40000 ALTER TABLE `document_constants_default_pdf` ENABLE KEYS */;

-- Dumping structure for table license_db.document_form
DROP TABLE IF EXISTS `document_form`;
CREATE TABLE IF NOT EXISTS `document_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_validaiton_id` bigint(20) unsigned NOT NULL,
  `form_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_data`)),
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_document_form_vendor_validation` (`vendor_validaiton_id`),
  KEY `FK_document_form_users` (`created_by`),
  KEY `FK_document_form_users_2` (`updated_by`),
  CONSTRAINT `FK_document_form_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_document_form_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_document_form_vendor_validation` FOREIGN KEY (`vendor_validaiton_id`) REFERENCES `vendor_validation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_form: ~0 rows (approximately)
DELETE FROM `document_form`;
/*!40000 ALTER TABLE `document_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_form` ENABLE KEYS */;

-- Dumping structure for table license_db.document_form_rows
DROP TABLE IF EXISTS `document_form_rows`;
CREATE TABLE IF NOT EXISTS `document_form_rows` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_form_id` bigint(20) unsigned NOT NULL,
  `table_id` bigint(20) unsigned NOT NULL,
  `row_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`row_json`)),
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_document_form_rows_document_form` (`document_form_id`),
  KEY `FK_document_form_rows_users` (`created_by`),
  KEY `FK_document_form_rows_users_2` (`updated_by`),
  CONSTRAINT `FK_document_form_rows_document_form` FOREIGN KEY (`document_form_id`) REFERENCES `document_form` (`id`),
  CONSTRAINT `FK_document_form_rows_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_document_form_rows_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_form_rows: ~0 rows (approximately)
DELETE FROM `document_form_rows`;
/*!40000 ALTER TABLE `document_form_rows` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_form_rows` ENABLE KEYS */;

-- Dumping structure for table license_db.document_forum
DROP TABLE IF EXISTS `document_forum`;
CREATE TABLE IF NOT EXISTS `document_forum` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `item_id` bigint(20) DEFAULT 0,
  `comments` varchar(500) NOT NULL,
  `comment_by` bigint(20) unsigned DEFAULT NULL,
  `comment_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `reply_flag` varchar(1) NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `delete_flag` varchar(1) DEFAULT NULL,
  `external_user` varchar(50) DEFAULT NULL,
  `checked_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_document_forum_users` (`comment_by`),
  KEY `FK_document_forum_project_version` (`version_id`),
  CONSTRAINT `FK_document_forum_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_document_forum_users` FOREIGN KEY (`comment_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_forum: ~0 rows (approximately)
DELETE FROM `document_forum`;
/*!40000 ALTER TABLE `document_forum` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_forum` ENABLE KEYS */;

-- Dumping structure for table license_db.document_forum_documents
DROP TABLE IF EXISTS `document_forum_documents`;
CREATE TABLE IF NOT EXISTS `document_forum_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_forum_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `document_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__document_forum` (`document_forum_id`),
  CONSTRAINT `FK__document_forum` FOREIGN KEY (`document_forum_id`) REFERENCES `document_forum` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_forum_documents: ~0 rows (approximately)
DELETE FROM `document_forum_documents`;
/*!40000 ALTER TABLE `document_forum_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_forum_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.document_forum_likes
DROP TABLE IF EXISTS `document_forum_likes`;
CREATE TABLE IF NOT EXISTS `document_forum_likes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_forum_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_document_forum_likes_document_forum` (`document_forum_id`),
  KEY `FK_document_forum_likes_users` (`user_id`),
  CONSTRAINT `FK_document_forum_likes_document_forum` FOREIGN KEY (`document_forum_id`) REFERENCES `document_forum` (`id`),
  CONSTRAINT `FK_document_forum_likes_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_forum_likes: ~0 rows (approximately)
DELETE FROM `document_forum_likes`;
/*!40000 ALTER TABLE `document_forum_likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_forum_likes` ENABLE KEYS */;

-- Dumping structure for table license_db.document_forum_reply
DROP TABLE IF EXISTS `document_forum_reply`;
CREATE TABLE IF NOT EXISTS `document_forum_reply` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_forum_id` bigint(20) unsigned NOT NULL,
  `document_forum_reply_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_document_forum_reply_document_forum` (`document_forum_id`),
  KEY `FK_document_forum_reply_users` (`user_id`),
  KEY `FK_document_forum_reply_document_forum_2` (`document_forum_reply_id`),
  CONSTRAINT `FK_document_forum_reply_document_forum` FOREIGN KEY (`document_forum_id`) REFERENCES `document_forum` (`id`),
  CONSTRAINT `FK_document_forum_reply_document_forum_2` FOREIGN KEY (`document_forum_reply_id`) REFERENCES `document_forum` (`id`),
  CONSTRAINT `FK_document_forum_reply_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_forum_reply: ~0 rows (approximately)
DELETE FROM `document_forum_reply`;
/*!40000 ALTER TABLE `document_forum_reply` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_forum_reply` ENABLE KEYS */;

-- Dumping structure for table license_db.document_forum_users
DROP TABLE IF EXISTS `document_forum_users`;
CREATE TABLE IF NOT EXISTS `document_forum_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_forum_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_document_forum_users_document_forum` (`document_forum_id`),
  KEY `FK_document_forum_users_users` (`user_id`),
  CONSTRAINT `FK_document_forum_users_document_forum` FOREIGN KEY (`document_forum_id`) REFERENCES `document_forum` (`id`),
  CONSTRAINT `FK_document_forum_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_forum_users: ~0 rows (approximately)
DELETE FROM `document_forum_users`;
/*!40000 ALTER TABLE `document_forum_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_forum_users` ENABLE KEYS */;

-- Dumping structure for table license_db.document_numbering_config
DROP TABLE IF EXISTS `document_numbering_config`;
CREATE TABLE IF NOT EXISTS `document_numbering_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `specific` varchar(50) NOT NULL,
  `prefix` varchar(50) NOT NULL DEFAULT '',
  `suffix` varchar(50) NOT NULL DEFAULT '',
  `year_auto_rest` varchar(1) NOT NULL DEFAULT 'N',
  `serial_number_start_from` int(11) NOT NULL DEFAULT 0,
  `serial_number_length` int(11) NOT NULL DEFAULT 3,
  `created_by` bigint(20) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `current_serial_value` int(11) DEFAULT NULL,
  `version_prefix` varchar(50) NOT NULL DEFAULT 'V',
  `version_start_from` varchar(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_numbering_config: ~0 rows (approximately)
DELETE FROM `document_numbering_config`;
/*!40000 ALTER TABLE `document_numbering_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_numbering_config` ENABLE KEYS */;

-- Dumping structure for table license_db.document_numbering_for_document
DROP TABLE IF EXISTS `document_numbering_for_document`;
CREATE TABLE IF NOT EXISTS `document_numbering_for_document` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_master_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `document_number` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_flow_document_master` (`flow_master_id`),
  KEY `FK_project_version` (`version_id`),
  CONSTRAINT `FK_flow_document_master` FOREIGN KEY (`flow_master_id`) REFERENCES `flow_document_master` (`id`),
  CONSTRAINT `FK_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_numbering_for_document: ~0 rows (approximately)
DELETE FROM `document_numbering_for_document`;
/*!40000 ALTER TABLE `document_numbering_for_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_numbering_for_document` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_flow_levels
DROP TABLE IF EXISTS `document_specific_flow_levels`;
CREATE TABLE IF NOT EXISTS `document_specific_flow_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  `option_id` bigint(20) unsigned NOT NULL,
  `order_number` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_document_specific_flow_levels_document_specified_form_data` (`master_id`),
  KEY `FK_document_specific_flow_levels_flow_level_master` (`level_id`),
  KEY `FK_document_specific_flow_levels_flow_settings_master` (`option_id`),
  CONSTRAINT `FK_document_specific_flow_levels_document_specified_form_data` FOREIGN KEY (`master_id`) REFERENCES `document_specific_form_master` (`id`),
  CONSTRAINT `FK_document_specific_flow_levels_flow_level_master` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_document_specific_flow_levels_flow_settings_master` FOREIGN KEY (`option_id`) REFERENCES `flow_settings_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_flow_levels: ~0 rows (approximately)
DELETE FROM `document_specific_flow_levels`;
/*!40000 ALTER TABLE `document_specific_flow_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_flow_levels` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_flow_level_users
DROP TABLE IF EXISTS `document_specific_flow_level_users`;
CREATE TABLE IF NOT EXISTS `document_specific_flow_level_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_level_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_flow_level_users_document_specific_flow_levels` (`flow_level_id`),
  KEY `FK_document_specific_flow_level_users_users` (`user_id`),
  CONSTRAINT `FK_document_specific_flow_level_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_flow_level_users_document_specific_flow_levels` FOREIGN KEY (`flow_level_id`) REFERENCES `document_specific_flow_levels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_flow_level_users: ~0 rows (approximately)
DELETE FROM `document_specific_flow_level_users`;
/*!40000 ALTER TABLE `document_specific_flow_level_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_flow_level_users` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_flow_logs
DROP TABLE IF EXISTS `document_specific_flow_logs`;
CREATE TABLE IF NOT EXISTS `document_specific_flow_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `form_data_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) NOT NULL,
  `status` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_document_specific_flow_logs_users` (`updated_by`),
  KEY `FK_document_specific_flow_logs_document_specific_flow_levels` (`level_id`),
  KEY `FK_document_specific_flow_logs_document_specific_form_data` (`form_data_id`),
  CONSTRAINT `FK_document_specific_flow_logs_document_specific_flow_levels` FOREIGN KEY (`level_id`) REFERENCES `document_specific_flow_levels` (`id`),
  CONSTRAINT `FK_document_specific_flow_logs_document_specific_form_data` FOREIGN KEY (`form_data_id`) REFERENCES `document_specific_form_data` (`id`),
  CONSTRAINT `FK_document_specific_flow_logs_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_flow_logs: ~0 rows (approximately)
DELETE FROM `document_specific_flow_logs`;
/*!40000 ALTER TABLE `document_specific_flow_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_flow_logs` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_form_data
DROP TABLE IF EXISTS `document_specific_form_data`;
CREATE TABLE IF NOT EXISTS `document_specific_form_data` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_id` bigint(20) unsigned NOT NULL,
  `dynamic_form_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_document_specific_form_data_document_specific_form_master` (`master_id`),
  KEY `FK_document_specific_form_data_dynamic_form` (`dynamic_form_id`),
  CONSTRAINT `FK_document_specific_form_data_document_specific_form_master` FOREIGN KEY (`master_id`) REFERENCES `document_specific_form_master` (`id`),
  CONSTRAINT `FK_document_specific_form_data_dynamic_form` FOREIGN KEY (`dynamic_form_id`) REFERENCES `dynamic_form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_form_data: ~0 rows (approximately)
DELETE FROM `document_specific_form_data`;
/*!40000 ALTER TABLE `document_specific_form_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_form_data` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_form_master
DROP TABLE IF EXISTS `document_specific_form_master`;
CREATE TABLE IF NOT EXISTS `document_specific_form_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_document_specified_form_data_project_version` (`version_id`),
  KEY `FK_document_specific_form_master_users` (`updated_by`),
  KEY `FK_document_specific_form_master_master_dynamic_form` (`master_dynamic_form_id`),
  KEY `FK_document_specific_form_master_organization_info` (`org_id`),
  CONSTRAINT `FK_document_specific_form_master_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_document_specific_form_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_document_specific_form_master_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_document_specified_form_data_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_form_master: ~0 rows (approximately)
DELETE FROM `document_specific_form_master`;
/*!40000 ALTER TABLE `document_specific_form_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_form_master` ENABLE KEYS */;

-- Dumping structure for table license_db.document_specific_numbering
DROP TABLE IF EXISTS `document_specific_numbering`;
CREATE TABLE IF NOT EXISTS `document_specific_numbering` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL DEFAULT '',
  `current_serial_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_specific_numbering: ~0 rows (approximately)
DELETE FROM `document_specific_numbering`;
/*!40000 ALTER TABLE `document_specific_numbering` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_specific_numbering` ENABLE KEYS */;

-- Dumping structure for table license_db.document_version
DROP TABLE IF EXISTS `document_version`;
CREATE TABLE IF NOT EXISTS `document_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `project_version_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_version_name` varchar(50) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_document_version_project_setup` (`project_id`),
  KEY `FK_document_version_project_version` (`project_version_id`),
  KEY `FK_document_version_users` (`created_by`),
  CONSTRAINT `FK_document_version_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_document_version_project_version` FOREIGN KEY (`project_version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_document_version_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.document_version: ~0 rows (approximately)
DELETE FROM `document_version`;
/*!40000 ALTER TABLE `document_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `document_version` ENABLE KEYS */;

-- Dumping structure for table license_db.draft_workflow_level
DROP TABLE IF EXISTS `draft_workflow_level`;
CREATE TABLE IF NOT EXISTS `draft_workflow_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `doctype` bigint(20) unsigned NOT NULL,
  `projectid` bigint(20) unsigned NOT NULL,
  `sla` varchar(50) DEFAULT NULL,
  `start_date` varchar(50) DEFAULT NULL,
  `end_date` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `responsibility` longtext DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.draft_workflow_level: ~0 rows (approximately)
DELETE FROM `draft_workflow_level`;
/*!40000 ALTER TABLE `draft_workflow_level` DISABLE KEYS */;
/*!40000 ALTER TABLE `draft_workflow_level` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_form
DROP TABLE IF EXISTS `dynamic_form`;
CREATE TABLE IF NOT EXISTS `dynamic_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT 'primary key for the table',
  `org_id` bigint(20) unsigned NOT NULL,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL COMMENT 'mapping the master form',
  `workflow_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  `form_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'compelete data with form structure' CHECK (json_valid(`form_data`)),
  `dynamic_form_code` varchar(100) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `delete_flag` varchar(1) DEFAULT 'N',
  `publish_flag` varchar(1) DEFAULT 'N',
  `updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `equipment_id` bigint(20) unsigned DEFAULT NULL,
  `batch_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `equipment_status_id` bigint(20) unsigned DEFAULT NULL,
  `ccf_id` bigint(20) unsigned DEFAULT NULL,
  `master_form_mapping` bigint(20) unsigned DEFAULT NULL,
  `revision_number` bigint(20) DEFAULT NULL,
  `unique_id` bigint(20) NOT NULL DEFAULT 0,
  `api_raw_data_file_path` varchar(100) DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `clean_room_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `newtable_fk_1` (`master_dynamic_form_id`),
  KEY `newtable_fk_2` (`created_by`),
  KEY `newtable_fk_3` (`updated_by`),
  KEY `FK_dynamic_form_equipment` (`equipment_id`),
  KEY `FK_dynamic_form_batch_creation` (`batch_id`),
  KEY `FK_dynamic_form_project_version` (`version_id`),
  KEY `FK_dynamic_form_master_form_mapping` (`master_form_mapping`),
  KEY `FKhhgx7km5qviktahwjkyb7mrtk` (`equipment_status_id`),
  KEY `FK_dynamic_form_ccf` (`ccf_id`),
  KEY `FK_dynamic_form_organization_info` (`org_id`),
  KEY `FK_dynamic_form_project_setup` (`project_id`),
  KEY `FK_dynamic_form_clean_room` (`clean_room_id`),
  CONSTRAINT `FK_dynamic_form_batch_creation` FOREIGN KEY (`batch_id`) REFERENCES `batch_creation` (`id`),
  CONSTRAINT `FK_dynamic_form_ccf` FOREIGN KEY (`ccf_id`) REFERENCES `ccf` (`id`),
  CONSTRAINT `FK_dynamic_form_clean_room` FOREIGN KEY (`clean_room_id`) REFERENCES `clean_room` (`id`),
  CONSTRAINT `FK_dynamic_form_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_dynamic_form_master_form_mapping` FOREIGN KEY (`master_form_mapping`) REFERENCES `master_form_mapping` (`id`),
  CONSTRAINT `FK_dynamic_form_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_dynamic_form_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_dynamic_form_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FKhhgx7km5qviktahwjkyb7mrtk` FOREIGN KEY (`equipment_status_id`) REFERENCES `equipment_status` (`id`),
  CONSTRAINT `newtable_fk_1` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `newtable_fk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `newtable_fk_3` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.dynamic_form: ~0 rows (approximately)
DELETE FROM `dynamic_form`;
/*!40000 ALTER TABLE `dynamic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_form` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_form_equipments
DROP TABLE IF EXISTS `dynamic_form_equipments`;
CREATE TABLE IF NOT EXISTS `dynamic_form_equipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `equipment_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK1_for_master_id_of_dynamic_form_equipments` (`parent_id`),
  KEY `FK2_for_equipment` (`equipment_id`),
  CONSTRAINT `FK1_for_master_id_of_dynamic_form_equipments` FOREIGN KEY (`parent_id`) REFERENCES `equipments_for_master_dynamic_form` (`id`),
  CONSTRAINT `FK2_for_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.dynamic_form_equipments: ~0 rows (approximately)
DELETE FROM `dynamic_form_equipments`;
/*!40000 ALTER TABLE `dynamic_form_equipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_form_equipments` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_form_table_rows
DROP TABLE IF EXISTS `dynamic_form_table_rows`;
CREATE TABLE IF NOT EXISTS `dynamic_form_table_rows` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `table_id` bigint(20) unsigned NOT NULL,
  `dynamic_form_id` bigint(20) unsigned NOT NULL,
  `row_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`row_json`)),
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_dynamic_form_table_rows_dynamic_form` (`dynamic_form_id`),
  KEY `FK_dynamic_form_table_rows_users` (`created_by`),
  KEY `FK_dynamic_form_table_rows_users_2` (`updated_by`),
  CONSTRAINT `FK_dynamic_form_table_rows_dynamic_form` FOREIGN KEY (`dynamic_form_id`) REFERENCES `dynamic_form` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_dynamic_form_table_rows_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_dynamic_form_table_rows_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Rows data of the dynamic form';

-- Dumping data for table license_db.dynamic_form_table_rows: ~0 rows (approximately)
DELETE FROM `dynamic_form_table_rows`;
/*!40000 ALTER TABLE `dynamic_form_table_rows` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_form_table_rows` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_template
DROP TABLE IF EXISTS `dynamic_template`;
CREATE TABLE IF NOT EXISTS `dynamic_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_template_name` varchar(100) NOT NULL,
  `dynamic_template_code` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ftp_path` text DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `revision_number` bigint(20) DEFAULT NULL,
  `workflow_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  `master_dt_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_dynamic_template_users` (`created_by`),
  KEY `FK_dynamic_template_users_2` (`updated_by`),
  KEY `FK_dynamic_template_master_dynamic_template` (`master_dt_id`),
  KEY `FK_dynamic_template_project_version` (`version_id`),
  CONSTRAINT `FK_dynamic_template_master_dynamic_template` FOREIGN KEY (`master_dt_id`) REFERENCES `master_dynamic_template` (`id`),
  CONSTRAINT `FK_dynamic_template_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_dynamic_template_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_dynamic_template_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Dynamic Template';

-- Dumping data for table license_db.dynamic_template: ~0 rows (approximately)
DELETE FROM `dynamic_template`;
/*!40000 ALTER TABLE `dynamic_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_template` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_templates
DROP TABLE IF EXISTS `dynamic_templates`;
CREATE TABLE IF NOT EXISTS `dynamic_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved_time` datetime DEFAULT NULL,
  `approver_comment` varchar(255) DEFAULT NULL,
  `body` varchar(255) DEFAULT NULL,
  `created_time` datetime NOT NULL,
  `deleted_flag` char(1) NOT NULL,
  `document_status` int(11) DEFAULT NULL,
  `last_updated_time` datetime NOT NULL,
  `organization_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `published` varchar(1) DEFAULT NULL,
  `reviewed_time` datetime DEFAULT NULL,
  `reviewer_comment` varchar(255) DEFAULT NULL,
  `template_code` varchar(50) DEFAULT NULL,
  `tittle` varchar(50) DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `reviewed_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKknd1dfxvmle9tx9saaaqnbabk` (`approved_by`),
  KEY `FKd4ipblet49g4cn3qntgnyg1ah` (`created_by`),
  KEY `FK78fx9nreikm5ry4xjq7mwk06k` (`last_updated_by`),
  KEY `FKm7ak4y64fblv9m3dg5r2m4nwt` (`reviewed_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.dynamic_templates: ~0 rows (approximately)
DELETE FROM `dynamic_templates`;
/*!40000 ALTER TABLE `dynamic_templates` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_templates` ENABLE KEYS */;

-- Dumping structure for table license_db.dynamic_template_log
DROP TABLE IF EXISTS `dynamic_template_log`;
CREATE TABLE IF NOT EXISTS `dynamic_template_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_template_id` bigint(20) unsigned NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ftp_path` varchar(100) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_dynamic_template_log_dynamic_template` (`dynamic_template_id`),
  KEY `FK_dynamic_template_log_users` (`created_by`),
  CONSTRAINT `FK_dynamic_template_log_dynamic_template` FOREIGN KEY (`dynamic_template_id`) REFERENCES `dynamic_template` (`id`),
  CONSTRAINT `FK_dynamic_template_log_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.dynamic_template_log: ~0 rows (approximately)
DELETE FROM `dynamic_template_log`;
/*!40000 ALTER TABLE `dynamic_template_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `dynamic_template_log` ENABLE KEYS */;

-- Dumping structure for table license_db.email_history
DROP TABLE IF EXISTS `email_history`;
CREATE TABLE IF NOT EXISTS `email_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organisation_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `email_template` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `sendby` bigint(20) unsigned DEFAULT NULL,
  `document_code` varchar(50) DEFAULT NULL,
  `event` varchar(200) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `system_remarks` varchar(500) DEFAULT NULL,
  `created_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_email_history_organization_info` (`organisation_id`),
  KEY `FK_email_history_project_setup` (`project_id`),
  KEY `FK_email_history_project_version` (`version_id`),
  KEY `FK_email_history_email_template_config` (`email_template`),
  KEY `FK_email_history_users` (`sendby`),
  KEY `FK_email_history_permissions` (`document_type`),
  CONSTRAINT `FK_email_history_email_template_config` FOREIGN KEY (`email_template`) REFERENCES `email_template_config` (`id`),
  CONSTRAINT `FK_email_history_organization_info` FOREIGN KEY (`organisation_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_email_history_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_email_history_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_email_history_users` FOREIGN KEY (`sendby`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.email_history: ~0 rows (approximately)
DELETE FROM `email_history`;
/*!40000 ALTER TABLE `email_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_history` ENABLE KEYS */;

-- Dumping structure for table license_db.email_rule
DROP TABLE IF EXISTS `email_rule`;
CREATE TABLE IF NOT EXISTS `email_rule` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `job_id` bigint(20) unsigned DEFAULT NULL,
  `rule_name` varchar(100) NOT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `document` varchar(50) DEFAULT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_for_project` (`project_id`),
  KEY `FK_for_created_by` (`created_by`),
  KEY `FK_for_updtaed_by` (`updated_by`),
  KEY `FK_for_document` (`document`),
  KEY `FK_for_org` (`organization_id`),
  CONSTRAINT `FK_for_created_by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_for_document` FOREIGN KEY (`document`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_for_org` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_for_project` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_for_updtaed_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.email_rule: ~0 rows (approximately)
DELETE FROM `email_rule`;
/*!40000 ALTER TABLE `email_rule` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_rule` ENABLE KEYS */;

-- Dumping structure for table license_db.email_rule_action
DROP TABLE IF EXISTS `email_rule_action`;
CREATE TABLE IF NOT EXISTS `email_rule_action` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_id` bigint(20) unsigned NOT NULL,
  `email_rule_id` bigint(20) unsigned NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `frequency` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__email_rule_parent` (`email_rule_id`),
  KEY `FK_email_rule_action_email_template_config` (`template_id`),
  CONSTRAINT `FK__email_rule_parent` FOREIGN KEY (`email_rule_id`) REFERENCES `email_rule` (`id`),
  CONSTRAINT `FK_email_rule_action_email_template_config` FOREIGN KEY (`template_id`) REFERENCES `email_template_config` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Action for can rule can be done';

-- Dumping data for table license_db.email_rule_action: ~0 rows (approximately)
DELETE FROM `email_rule_action`;
/*!40000 ALTER TABLE `email_rule_action` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_rule_action` ENABLE KEYS */;

-- Dumping structure for table license_db.email_rule_users
DROP TABLE IF EXISTS `email_rule_users`;
CREATE TABLE IF NOT EXISTS `email_rule_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user` bigint(20) unsigned NOT NULL,
  `email_rule_action_id` bigint(20) unsigned NOT NULL,
  `flag` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK_users` (`user`),
  KEY `FK_email_rule_users_email_rule_action` (`email_rule_action_id`),
  CONSTRAINT `FK_email_rule_users_email_rule_action` FOREIGN KEY (`email_rule_action_id`) REFERENCES `email_rule_action` (`id`),
  CONSTRAINT `FK_users` FOREIGN KEY (`user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.email_rule_users: ~0 rows (approximately)
DELETE FROM `email_rule_users`;
/*!40000 ALTER TABLE `email_rule_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_rule_users` ENABLE KEYS */;

-- Dumping structure for table license_db.email_template_config
DROP TABLE IF EXISTS `email_template_config`;
CREATE TABLE IF NOT EXISTS `email_template_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned DEFAULT 0,
  `rule_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `template_name` varchar(200) NOT NULL,
  `sample_template` longtext NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_for_organization` (`organization_id`),
  KEY `FK_for_created_ by` (`created_by`),
  KEY `FK_for_updated_by` (`updated_by`),
  CONSTRAINT `FK_for_created_ by` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_for_organization` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_for_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.email_template_config: ~0 rows (approximately)
DELETE FROM `email_template_config`;
/*!40000 ALTER TABLE `email_template_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_template_config` ENABLE KEYS */;

-- Dumping structure for table license_db.email_to_project_config
DROP TABLE IF EXISTS `email_to_project_config`;
CREATE TABLE IF NOT EXISTS `email_to_project_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_email_sending_config_for_project_project_setup` (`project_id`),
  KEY `FK_email_sending_config_for_project_users` (`created_by`),
  KEY `FK_email_sending_config_for_project_users_2` (`updated_by`),
  KEY `FK_email_sending_config_for_project_organization_info` (`organization_id`),
  CONSTRAINT `FK_email_sending_config_for_project_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_email_sending_config_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_email_sending_config_for_project_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_email_sending_config_for_project_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Email to be send for the user for document of the project';

-- Dumping data for table license_db.email_to_project_config: ~0 rows (approximately)
DELETE FROM `email_to_project_config`;
/*!40000 ALTER TABLE `email_to_project_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_to_project_config` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment
DROP TABLE IF EXISTS `equipment`;
CREATE TABLE IF NOT EXISTS `equipment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `component` longtext DEFAULT NULL,
  `qualification_status` varchar(50) NOT NULL,
  `gxp_relevence` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `date_of_purchase` timestamp NULL DEFAULT NULL,
  `sold_by` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `total_capacity` varchar(50) DEFAULT NULL,
  `usage_capacity` varchar(50) DEFAULT NULL,
  `IQ_completion_date` timestamp NULL DEFAULT NULL,
  `OQ_completion_date` timestamp NULL DEFAULT NULL,
  `release_date` timestamp NULL DEFAULT NULL,
  `periodic_review` timestamp NULL DEFAULT NULL,
  `active` varchar(1) NOT NULL,
  `status_sequence` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `image` mediumtext DEFAULT NULL,
  `image_name` varchar(250) DEFAULT NULL,
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_equipment_location` (`location_id`),
  KEY `FK_equipment_users` (`updated_by`),
  KEY `FK_equipment_organization_info` (`org_id`),
  CONSTRAINT `FK_equipment_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_equipment_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_equipment_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment: ~0 rows (approximately)
DELETE FROM `equipment`;
/*!40000 ALTER TABLE `equipment` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment` ENABLE KEYS */;

-- Dumping structure for table license_db.equipments_for_master_dynamic_form
DROP TABLE IF EXISTS `equipments_for_master_dynamic_form`;
CREATE TABLE IF NOT EXISTS `equipments_for_master_dynamic_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `stages` varchar(50) NOT NULL,
  `form_mapping_id` bigint(20) unsigned DEFAULT 0,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `org_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_equipments_for_master_dynamic_form_master_dynamic_form` (`master_dynamic_form_id`),
  KEY `FK_equipments_for_master_dynamic_form_users` (`created_by`),
  KEY `FK_equipments_for_master_dynamic_form_master_form_mapping` (`form_mapping_id`),
  KEY `FK_equipments_for_master_dynamic_form_users_2` (`updated_by`),
  KEY `FK_equipments_for_master_dynamic_form_organization_info` (`org_id`),
  CONSTRAINT `FK_equipments_for_master_dynamic_form_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_equipments_for_master_dynamic_form_master_form_mapping` FOREIGN KEY (`form_mapping_id`) REFERENCES `master_form_mapping` (`id`),
  CONSTRAINT `FK_equipments_for_master_dynamic_form_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_equipments_for_master_dynamic_form_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_equipments_for_master_dynamic_form_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipments_for_master_dynamic_form: ~0 rows (approximately)
DELETE FROM `equipments_for_master_dynamic_form`;
/*!40000 ALTER TABLE `equipments_for_master_dynamic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipments_for_master_dynamic_form` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment_department
DROP TABLE IF EXISTS `equipment_department`;
CREATE TABLE IF NOT EXISTS `equipment_department` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_equipment_department_equipment` (`equipment_id`) USING BTREE,
  KEY `FK_equipment_department_department` (`department_id`) USING BTREE,
  CONSTRAINT `FK_equipment_department_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `FK_equipment_department_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment_department: ~0 rows (approximately)
DELETE FROM `equipment_department`;
/*!40000 ALTER TABLE `equipment_department` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_department` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment_status
DROP TABLE IF EXISTS `equipment_status`;
CREATE TABLE IF NOT EXISTS `equipment_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `org_id` bigint(20) unsigned NOT NULL,
  `batch_id` bigint(20) unsigned DEFAULT NULL,
  `status` bigint(20) unsigned NOT NULL,
  `status_active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `completed_flag` varchar(1) DEFAULT 'N',
  `task_description` varchar(200) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_equipment_status_equipment` (`equipment_id`),
  KEY `FK_equipment_status_batch_creation` (`batch_id`),
  KEY `FK_equipment_status_users` (`updated_by`),
  KEY `FK_equipment_status_organization_info` (`org_id`),
  KEY `FK_equipment_status_checklist_for_equipment` (`status`),
  KEY `FK_equipment_status_users_2` (`created_by`),
  CONSTRAINT `FK_equipment_status_batch_creation` FOREIGN KEY (`batch_id`) REFERENCES `batch_creation` (`id`),
  CONSTRAINT `FK_equipment_status_checklist_for_equipment` FOREIGN KEY (`status`) REFERENCES `checklist_for_equipment` (`id`),
  CONSTRAINT `FK_equipment_status_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_equipment_status_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_equipment_status_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_equipment_status_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment_status: ~0 rows (approximately)
DELETE FROM `equipment_status`;
/*!40000 ALTER TABLE `equipment_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_status` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment_status_dynamic_forms
DROP TABLE IF EXISTS `equipment_status_dynamic_forms`;
CREATE TABLE IF NOT EXISTS `equipment_status_dynamic_forms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_status_id` bigint(20) unsigned NOT NULL,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `master_form_mapping` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_equipment_status_dynamic_forms_equipment_status` (`equipment_status_id`),
  KEY `FK_equipment_status_dynamic_forms_master_dynamic_form` (`master_dynamic_form_id`),
  KEY `FKs3d4ylreqkbm1ioj0m7kbqio8` (`master_form_mapping`),
  CONSTRAINT `FK_equipment_status_dynamic_forms_equipment_status` FOREIGN KEY (`equipment_status_id`) REFERENCES `equipment_status` (`id`),
  CONSTRAINT `FK_equipment_status_dynamic_forms_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FKs3d4ylreqkbm1ioj0m7kbqio8` FOREIGN KEY (`master_form_mapping`) REFERENCES `master_form_mapping` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment_status_dynamic_forms: ~0 rows (approximately)
DELETE FROM `equipment_status_dynamic_forms`;
/*!40000 ALTER TABLE `equipment_status_dynamic_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_status_dynamic_forms` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment_system_owner
DROP TABLE IF EXISTS `equipment_system_owner`;
CREATE TABLE IF NOT EXISTS `equipment_system_owner` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_equipment_system_owner_equipment` (`equipment_id`) USING BTREE,
  KEY `FK_equipment_system_owner_users` (`user_id`) USING BTREE,
  CONSTRAINT `FK_equipment_system_owner_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_equipment_system_owner_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment_system_owner: ~0 rows (approximately)
DELETE FROM `equipment_system_owner`;
/*!40000 ALTER TABLE `equipment_system_owner` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_system_owner` ENABLE KEYS */;

-- Dumping structure for table license_db.equipment_user_master
DROP TABLE IF EXISTS `equipment_user_master`;
CREATE TABLE IF NOT EXISTS `equipment_user_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `create_by` bigint(20) unsigned NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `template_id` bigint(20) unsigned NOT NULL,
  `email_flag` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK_Equipment_user_master_equipment` (`equipment_id`),
  KEY `FK_Equipment_user_master_users` (`user_id`),
  KEY `FK_Equipment_user_master_users_2` (`create_by`),
  KEY `FK_equipment_user_master_organization_info` (`org_id`),
  KEY `FK_equipment_user_master_email_template_config` (`template_id`),
  CONSTRAINT `FK_Equipment_user_master_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_Equipment_user_master_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_Equipment_user_master_users_2` FOREIGN KEY (`create_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_equipment_user_master_email_template_config` FOREIGN KEY (`template_id`) REFERENCES `email_template_config` (`id`),
  CONSTRAINT `FK_equipment_user_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.equipment_user_master: ~0 rows (approximately)
DELETE FROM `equipment_user_master`;
/*!40000 ALTER TABLE `equipment_user_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipment_user_master` ENABLE KEYS */;

-- Dumping structure for table license_db.esign_master
DROP TABLE IF EXISTS `esign_master`;
CREATE TABLE IF NOT EXISTS `esign_master` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `creator` bigint(20) DEFAULT NULL,
  `approver` bigint(20) DEFAULT NULL,
  `reviewer` bigint(20) DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `approver_comments` varchar(100) DEFAULT NULL,
  `approver_esign_time` datetime DEFAULT NULL,
  `creater_esign_time` datetime DEFAULT NULL,
  `reviewer_esign_time` datetime DEFAULT NULL,
  `creator_comments` varchar(100) DEFAULT NULL,
  `esign_flag` varchar(1) NOT NULL,
  `reviewer_comments` varchar(100) DEFAULT NULL,
  `document_number` varchar(50) DEFAULT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKeaav49r5fjeksnrdhocdfu5bl` (`document_type`),
  KEY `FK9nxdxpikp22valmt92qtgligp` (`project_id`),
  KEY `FKrrnxi56ifloj3a03dapfcuodq` (`approver`),
  KEY `FK40c1f8s0a4wo22dmv32pudd96` (`creator`),
  KEY `FKocplduc1c295els2uoudu41sw` (`reviewer`),
  CONSTRAINT `FKeaav49r5fjeksnrdhocdfu5bl` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.esign_master: ~0 rows (approximately)
DELETE FROM `esign_master`;
/*!40000 ALTER TABLE `esign_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `esign_master` ENABLE KEYS */;

-- Dumping structure for table license_db.exceptions
DROP TABLE IF EXISTS `exceptions`;
CREATE TABLE IF NOT EXISTS `exceptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `environment` varchar(50) NOT NULL,
  `module_name` varchar(200) NOT NULL,
  `exception` longtext NOT NULL,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_exceptions_organization_info` (`org_id`),
  KEY `FK_exceptions_project_setup` (`project_id`),
  KEY `FK_exceptions_users` (`user_id`),
  CONSTRAINT `FK_exceptions_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_exceptions_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_exceptions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.exceptions: ~2 rows (approximately)
DELETE FROM `exceptions`;
/*!40000 ALTER TABLE `exceptions` DISABLE KEYS */;
INSERT INTO `exceptions` (`id`, `environment`, `module_name`, `exception`, `org_id`, `project_id`, `user_id`, `created_time`) VALUES
	(95, 'dev', 'Exception', 'java.lang.NullPointerException\r\n	at com.atpl.ival.servicesImpl.TaskReportServiceImpl.loadIndividualTaskReoprtForProject(TaskReportServiceImpl.java:443)\r\n	at com.atpl.ival.Controller.TaskReportController.loadIndividualtaskData(TaskReportController.java:67)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)\r\n	at sun.reflect.NativeMethodAccessorImpl.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)\r\n	at java.lang.reflect.Method.invoke(Unknown Source)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.doInvoke(InvocableHandlerMethod.java:189)\r\n	at org.springframework.web.method.support.InvocableHandlerMethod.invokeForRequest(InvocableHandlerMethod.java:138)\r\n	at org.springframework.web.servlet.mvc.method.annotation.ServletInvocableHandlerMethod.invokeAndHandle(ServletInvocableHandlerMethod.java:102)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.invokeHandlerMethod(RequestMappingHandlerAdapter.java:895)\r\n	at org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter.handleInternal(RequestMappingHandlerAdapter.java:800)\r\n	at org.springframework.web.servlet.mvc.method.AbstractHandlerMethodAdapter.handle(AbstractHandlerMethodAdapter.java:87)\r\n	at org.springframework.web.servlet.DispatcherServlet.doDispatch(DispatcherServlet.java:1038)\r\n	at org.springframework.web.servlet.DispatcherServlet.doService(DispatcherServlet.java:942)\r\n	at org.springframework.web.servlet.FrameworkServlet.processRequest(FrameworkServlet.java:1005)\r\n	at org.springframework.web.servlet.FrameworkServlet.doPost(FrameworkServlet.java:908)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:660)\r\n	at org.springframework.web.servlet.FrameworkServlet.service(FrameworkServlet.java:882)\r\n	at javax.servlet.http.HttpServlet.service(HttpServlet.java:741)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:231)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.tomcat.websocket.server.WsFilter.doFilter(WsFilter.java:53)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:101)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:320)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.invoke(FilterSecurityInterceptor.java:127)\r\n	at org.springframework.security.web.access.intercept.FilterSecurityInterceptor.doFilter(FilterSecurityInterceptor.java:91)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.access.ExceptionTranslationFilter.doFilter(ExceptionTranslationFilter.java:119)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.session.SessionManagementFilter.doFilter(SessionManagementFilter.java:137)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.AnonymousAuthenticationFilter.doFilter(AnonymousAuthenticationFilter.java:111)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestFilter.doFilter(SecurityContextHolderAwareRequestFilter.java:170)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.savedrequest.RequestCacheAwareFilter.doFilter(RequestCacheAwareFilter.java:63)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at com.atpl.ival.security.AppAuthenticationFilter.doFilterInternal(AppAuthenticationFilter.java:76)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.authentication.logout.LogoutFilter.doFilter(LogoutFilter.java:116)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.web.filter.CorsFilter.doFilterInternal(CorsFilter.java:96)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.header.HeaderWriterFilter.doFilterInternal(HeaderWriterFilter.java:74)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.SecurityContextPersistenceFilter.doFilter(SecurityContextPersistenceFilter.java:105)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.context.request.async.WebAsyncManagerIntegrationFilter.doFilterInternal(WebAsyncManagerIntegrationFilter.java:56)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.springframework.security.web.FilterChainProxy$VirtualFilterChain.doFilter(FilterChainProxy.java:334)\r\n	at org.springframework.security.web.FilterChainProxy.doFilterInternal(FilterChainProxy.java:215)\r\n	at org.springframework.security.web.FilterChainProxy.doFilter(FilterChainProxy.java:178)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.invokeDelegate(DelegatingFilterProxy.java:357)\r\n	at org.springframework.web.filter.DelegatingFilterProxy.doFilter(DelegatingFilterProxy.java:270)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.RequestContextFilter.doFilterInternal(RequestContextFilter.java:99)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.FormContentFilter.doFilterInternal(FormContentFilter.java:92)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.HiddenHttpMethodFilter.doFilterInternal(HiddenHttpMethodFilter.java:93)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.session.web.http.SessionRepositoryFilter.doFilterInternal(SessionRepositoryFilter.java:151)\r\n	at org.springframework.session.web.http.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:81)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.springframework.web.filter.CharacterEncodingFilter.doFilterInternal(CharacterEncodingFilter.java:200)\r\n	at org.springframework.web.filter.OncePerRequestFilter.doFilter(OncePerRequestFilter.java:107)\r\n	at org.apache.catalina.core.ApplicationFilterChain.internalDoFilter(ApplicationFilterChain.java:193)\r\n	at org.apache.catalina.core.ApplicationFilterChain.doFilter(ApplicationFilterChain.java:166)\r\n	at org.apache.catalina.core.StandardWrapperValve.invoke(StandardWrapperValve.java:200)\r\n	at org.apache.catalina.core.StandardContextValve.invoke(StandardContextValve.java:96)\r\n	at org.apache.catalina.authenticator.AuthenticatorBase.invoke(AuthenticatorBase.java:490)\r\n	at org.apache.catalina.core.StandardHostValve.invoke(StandardHostValve.java:139)\r\n	at org.apache.catalina.valves.ErrorReportValve.invoke(ErrorReportValve.java:92)\r\n	at org.apache.catalina.core.StandardEngineValve.invoke(StandardEngineValve.java:74)\r\n	at org.apache.catalina.connector.CoyoteAdapter.service(CoyoteAdapter.java:343)\r\n	at org.apache.coyote.http11.Http11Processor.service(Http11Processor.java:408)\r\n	at org.apache.coyote.AbstractProcessorLight.process(AbstractProcessorLight.java:66)\r\n	at org.apache.coyote.AbstractProtocol$ConnectionHandler.process(AbstractProtocol.java:834)\r\n	at org.apache.tomcat.util.net.NioEndpoint$SocketProcessor.doRun(NioEndpoint.java:1415)\r\n	at org.apache.tomcat.util.net.SocketProcessorBase.run(SocketProcessorBase.java:49)\r\n	at java.util.concurrent.ThreadPoolExecutor.runWorker(Unknown Source)\r\n	at java.util.concurrent.ThreadPoolExecutor$Worker.run(Unknown Source)\r\n	at org.apache.tomcat.util.threads.TaskThread$WrappingRunnable.run(TaskThread.java:61)\r\n	at java.lang.Thread.run(Unknown Source)\r\n', 1, NULL, 1, '2021-11-30 09:14:01'),
	(114, 'dev', 'Audit Trail Exception', 'org.springframework.dao.DataIntegrityViolationException: could not execute statement; SQL [n/a]; constraint [null]; nested exception is org.hibernate.exception.ConstraintViolationException: could not execute statement\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.convertHibernateAccessException(HibernateJpaDialect.java:296)\r\n	at org.springframework.orm.jpa.vendor.HibernateJpaDialect.translateExceptionIfPossible(HibernateJpaDialect.java:253)\r\n	at org.springframework.orm.jpa.AbstractEntityManagerFactoryBean.translateExceptionIfPossible(AbstractEntityManagerFactoryBean.java:527)\r\n	at org.springframework.dao.support.ChainedPersistenceExceptionTranslator.translateExceptionIfPossible(ChainedPersistenceExceptionTranslator.java:61)\r\n	at org.springframework.dao.support.DataAccessUtils.translateIfNecessary(DataAccessUtils.java:242)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:153)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.jpa.repository.support.CrudMethodMetadataPostProcessor$CrudMethodMetadataPopulatingMethodInterceptor.invoke(CrudMethodMetadataPostProcessor.java:135)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.interceptor.ExposeInvocationInterceptor.invoke(ExposeInvocationInterceptor.java:93)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.repository.core.support.SurroundingTransactionDetectorMethodInterceptor.invoke(SurroundingTransactionDetectorMethodInterceptor.java:61)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.aop.framework.JdkDynamicAopProxy.invoke(JdkDynamicAopProxy.java:212)\r\n	at com.sun.proxy.$Proxy1511.save(Unknown Source)\r\n	at com.atpl.ival.servicesImpl.CommonServiceImpl.lambda$0(CommonServiceImpl.java:641)\r\n	at java.util.concurrent.CompletableFuture$AsyncRun.run(Unknown Source)\r\n	at java.util.concurrent.CompletableFuture$AsyncRun.exec(Unknown Source)\r\n	at java.util.concurrent.ForkJoinTask.doExec(Unknown Source)\r\n	at java.util.concurrent.ForkJoinPool$WorkQueue.runTask(Unknown Source)\r\n	at java.util.concurrent.ForkJoinPool.runWorker(Unknown Source)\r\n	at java.util.concurrent.ForkJoinWorkerThread.run(Unknown Source)\r\nCaused by: org.hibernate.exception.ConstraintViolationException: could not execute statement\r\n	at org.hibernate.exception.internal.SQLExceptionTypeDelegate.convert(SQLExceptionTypeDelegate.java:59)\r\n	at org.hibernate.exception.internal.StandardSQLExceptionConverter.convert(StandardSQLExceptionConverter.java:42)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:113)\r\n	at org.hibernate.engine.jdbc.spi.SqlExceptionHelper.convert(SqlExceptionHelper.java:99)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:178)\r\n	at org.hibernate.dialect.identity.GetGeneratedKeysDelegate.executeAndExtract(GetGeneratedKeysDelegate.java:57)\r\n	at org.hibernate.id.insert.AbstractReturningDelegate.performInsert(AbstractReturningDelegate.java:42)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3072)\r\n	at org.hibernate.persister.entity.AbstractEntityPersister.insert(AbstractEntityPersister.java:3663)\r\n	at org.hibernate.action.internal.EntityIdentityInsertAction.execute(EntityIdentityInsertAction.java:81)\r\n	at org.hibernate.engine.spi.ActionQueue.execute(ActionQueue.java:645)\r\n	at org.hibernate.engine.spi.ActionQueue.addResolvedEntityInsertAction(ActionQueue.java:282)\r\n	at org.hibernate.engine.spi.ActionQueue.addInsertAction(ActionQueue.java:263)\r\n	at org.hibernate.engine.spi.ActionQueue.addAction(ActionQueue.java:317)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.addInsertAction(AbstractSaveEventListener.java:359)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSaveOrReplicate(AbstractSaveEventListener.java:292)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.performSave(AbstractSaveEventListener.java:200)\r\n	at org.hibernate.event.internal.AbstractSaveEventListener.saveWithGeneratedId(AbstractSaveEventListener.java:131)\r\n	at org.hibernate.event.internal.DefaultPersistEventListener.entityIsTransient(DefaultPersistEventListener.java:192)\r\n	at org.hibernate.event.internal.DefaultPersistEventListener.onPersist(DefaultPersistEventListener.java:135)\r\n	at org.hibernate.event.internal.DefaultPersistEventListener.onPersist(DefaultPersistEventListener.java:62)\r\n	at org.hibernate.internal.SessionImpl.firePersist(SessionImpl.java:800)\r\n	at org.hibernate.internal.SessionImpl.persist(SessionImpl.java:785)\r\n	at sun.reflect.GeneratedMethodAccessor2255.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)\r\n	at java.lang.reflect.Method.invoke(Unknown Source)\r\n	at org.springframework.orm.jpa.SharedEntityManagerCreator$SharedEntityManagerInvocationHandler.invoke(SharedEntityManagerCreator.java:308)\r\n	at com.sun.proxy.$Proxy1500.persist(Unknown Source)\r\n	at org.springframework.data.jpa.repository.support.SimpleJpaRepository.save(SimpleJpaRepository.java:489)\r\n	at sun.reflect.GeneratedMethodAccessor2254.invoke(Unknown Source)\r\n	at sun.reflect.DelegatingMethodAccessorImpl.invoke(Unknown Source)\r\n	at java.lang.reflect.Method.invoke(Unknown Source)\r\n	at org.springframework.data.repository.core.support.RepositoryComposition$RepositoryFragments.invoke(RepositoryComposition.java:359)\r\n	at org.springframework.data.repository.core.support.RepositoryComposition.invoke(RepositoryComposition.java:200)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$ImplementationMethodExecutionInterceptor.invoke(RepositoryFactorySupport.java:644)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$QueryExecutorMethodInterceptor.doInvoke(RepositoryFactorySupport.java:608)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$QueryExecutorMethodInterceptor.lambda$invoke$3(RepositoryFactorySupport.java:595)\r\n	at org.springframework.data.repository.core.support.RepositoryFactorySupport$QueryExecutorMethodInterceptor.invoke(RepositoryFactorySupport.java:595)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.data.projection.DefaultMethodInvokingMethodInterceptor.invoke(DefaultMethodInvokingMethodInterceptor.java:59)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.transaction.interceptor.TransactionAspectSupport.invokeWithinTransaction(TransactionAspectSupport.java:294)\r\n	at org.springframework.transaction.interceptor.TransactionInterceptor.invoke(TransactionInterceptor.java:98)\r\n	at org.springframework.aop.framework.ReflectiveMethodInvocation.proceed(ReflectiveMethodInvocation.java:186)\r\n	at org.springframework.dao.support.PersistenceExceptionTranslationInterceptor.invoke(PersistenceExceptionTranslationInterceptor.java:139)\r\n	... 16 more\r\nCaused by: java.sql.SQLIntegrityConstraintViolationException: Column \'organization_id\' cannot be null\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:117)\r\n	at com.mysql.cj.jdbc.exceptions.SQLError.createSQLException(SQLError.java:97)\r\n	at com.mysql.cj.jdbc.exceptions.SQLExceptionsMapping.translateException(SQLExceptionsMapping.java:122)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeInternal(ClientPreparedStatement.java:970)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdateInternal(ClientPreparedStatement.java:1109)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdateInternal(ClientPreparedStatement.java:1057)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeLargeUpdate(ClientPreparedStatement.java:1377)\r\n	at com.mysql.cj.jdbc.ClientPreparedStatement.executeUpdate(ClientPreparedStatement.java:1042)\r\n	at org.hibernate.engine.jdbc.internal.ResultSetReturnImpl.executeUpdate(ResultSetReturnImpl.java:175)\r\n	... 57 more\r\n', NULL, NULL, 1, '2022-01-04 06:49:53');
/*!40000 ALTER TABLE `exceptions` ENABLE KEYS */;

-- Dumping structure for table license_db.external_approval
DROP TABLE IF EXISTS `external_approval`;
CREATE TABLE IF NOT EXISTS `external_approval` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `remarks` varchar(500) NOT NULL,
  `validity` int(11) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `file_path` varchar(500) NOT NULL,
  `completion_flag` varchar(1) NOT NULL,
  `flow_level_id` bigint(20) unsigned DEFAULT NULL,
  `individual_flow_level_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `referenceId` (`reference_id`),
  KEY `FK_external_approval_document_project_version` (`version_id`),
  KEY `FK_external_approval_document_users` (`updated_by`),
  KEY `FK_external_approval_flow_level_child` (`flow_level_id`),
  KEY `FK_external_approval_individual_document_flow_levels` (`individual_flow_level_id`),
  CONSTRAINT `FK_external_approval_document_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_external_approval_document_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_external_approval_flow_level_child` FOREIGN KEY (`flow_level_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_external_approval_individual_document_flow_levels` FOREIGN KEY (`individual_flow_level_id`) REFERENCES `individual_document_flow_levels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.external_approval: ~0 rows (approximately)
DELETE FROM `external_approval`;
/*!40000 ALTER TABLE `external_approval` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_approval` ENABLE KEYS */;

-- Dumping structure for table license_db.external_approval_comments
DROP TABLE IF EXISTS `external_approval_comments`;
CREATE TABLE IF NOT EXISTS `external_approval_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_approval_id` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) NOT NULL,
  `sign_image` longtext DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `approve_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_external_approval_comments_external_approval` (`external_approval_id`),
  CONSTRAINT `FK_external_approval_comments_external_approval` FOREIGN KEY (`external_approval_id`) REFERENCES `external_approval` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.external_approval_comments: ~0 rows (approximately)
DELETE FROM `external_approval_comments`;
/*!40000 ALTER TABLE `external_approval_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_approval_comments` ENABLE KEYS */;

-- Dumping structure for table license_db.external_approval_documents
DROP TABLE IF EXISTS `external_approval_documents`;
CREATE TABLE IF NOT EXISTS `external_approval_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_approval_id` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `document_code` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_external_approval_documents_external_approval` (`external_approval_id`),
  CONSTRAINT `FK_external_approval_documents_external_approval` FOREIGN KEY (`external_approval_id`) REFERENCES `external_approval` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.external_approval_documents: ~0 rows (approximately)
DELETE FROM `external_approval_documents`;
/*!40000 ALTER TABLE `external_approval_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_approval_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.external_approval_otp
DROP TABLE IF EXISTS `external_approval_otp`;
CREATE TABLE IF NOT EXISTS `external_approval_otp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `external_approval_id` bigint(20) unsigned NOT NULL,
  `otp` varchar(50) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_external_approval_otp_external_approval` (`external_approval_id`),
  CONSTRAINT `FK_external_approval_otp_external_approval` FOREIGN KEY (`external_approval_id`) REFERENCES `external_approval` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.external_approval_otp: ~0 rows (approximately)
DELETE FROM `external_approval_otp`;
/*!40000 ALTER TABLE `external_approval_otp` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_approval_otp` ENABLE KEYS */;

-- Dumping structure for table license_db.external_dynamic_form
DROP TABLE IF EXISTS `external_dynamic_form`;
CREATE TABLE IF NOT EXISTS `external_dynamic_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reference_id` varchar(50) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `dynamic_form_id` bigint(20) NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `remarks` varchar(500) NOT NULL,
  `validity` int(11) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `otp` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `referenceId` (`reference_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.external_dynamic_form: ~0 rows (approximately)
DELETE FROM `external_dynamic_form`;
/*!40000 ALTER TABLE `external_dynamic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `external_dynamic_form` ENABLE KEYS */;

-- Dumping structure for table license_db.e_signature_documents
DROP TABLE IF EXISTS `e_signature_documents`;
CREATE TABLE IF NOT EXISTS `e_signature_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `document_name` varchar(50) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `published` varchar(1) DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_e_signature_documents_user` (`created_by`),
  KEY `FK_e_signature_documents_user_1` (`last_updated_by`),
  KEY `FK_e_signature_documents_organization_info` (`org_id`),
  CONSTRAINT `FK_e_signature_documents_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_e_signature_documents_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_e_signature_documents_user_1` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.e_signature_documents: ~0 rows (approximately)
DELETE FROM `e_signature_documents`;
/*!40000 ALTER TABLE `e_signature_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_signature_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.e_signature_external_approval_otp
DROP TABLE IF EXISTS `e_signature_external_approval_otp`;
CREATE TABLE IF NOT EXISTS `e_signature_external_approval_otp` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `e_signature_approval_id` bigint(20) unsigned NOT NULL,
  `otp` varchar(50) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_e_signature_external_approval_otp` (`e_signature_approval_id`),
  CONSTRAINT `FK_e_signature_external_approval_otp` FOREIGN KEY (`e_signature_approval_id`) REFERENCES `e_signature_external_approval_workflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.e_signature_external_approval_otp: ~0 rows (approximately)
DELETE FROM `e_signature_external_approval_otp`;
/*!40000 ALTER TABLE `e_signature_external_approval_otp` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_signature_external_approval_otp` ENABLE KEYS */;

-- Dumping structure for table license_db.e_signature_external_approval_workflow
DROP TABLE IF EXISTS `e_signature_external_approval_workflow`;
CREATE TABLE IF NOT EXISTS `e_signature_external_approval_workflow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `e_signature_details_id` bigint(20) unsigned NOT NULL,
  `reference_id` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `remarks` varchar(50) NOT NULL,
  `validity` int(11) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `mail_time` timestamp NULL DEFAULT NULL,
  `file_path` varchar(500) NOT NULL,
  `completion_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reference_id_UNIQUE` (`reference_id`),
  KEY `FK_approval_signature_details_id` (`e_signature_details_id`),
  KEY `FK_approval_user` (`updated_by`),
  CONSTRAINT `FK_approval_signature_details_id` FOREIGN KEY (`e_signature_details_id`) REFERENCES `e_signature_documents` (`id`),
  CONSTRAINT `FK_approval_user` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.e_signature_external_approval_workflow: ~0 rows (approximately)
DELETE FROM `e_signature_external_approval_workflow`;
/*!40000 ALTER TABLE `e_signature_external_approval_workflow` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_signature_external_approval_workflow` ENABLE KEYS */;

-- Dumping structure for table license_db.e_sign_external_approval_comments
DROP TABLE IF EXISTS `e_sign_external_approval_comments`;
CREATE TABLE IF NOT EXISTS `e_sign_external_approval_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `e_sign_approval_id` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) NOT NULL,
  `sign_image` longtext DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `location_ip` varchar(100) DEFAULT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`),
  KEY `FK_e_signature_external_approval_comments` (`e_sign_approval_id`),
  CONSTRAINT `FK_e_signature_external_approval_comments` FOREIGN KEY (`e_sign_approval_id`) REFERENCES `e_signature_external_approval_workflow` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.e_sign_external_approval_comments: ~0 rows (approximately)
DELETE FROM `e_sign_external_approval_comments`;
/*!40000 ALTER TABLE `e_sign_external_approval_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `e_sign_external_approval_comments` ENABLE KEYS */;

-- Dumping structure for table license_db.facility
DROP TABLE IF EXISTS `facility`;
CREATE TABLE IF NOT EXISTS `facility` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `location_id` bigint(20) unsigned NOT NULL,
  `active` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_facility_location` (`location_id`),
  KEY `FK_facility_users` (`updated_by`),
  KEY `FK_facility_organization_info` (`org_id`),
  CONSTRAINT `FK_facility_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_facility_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_facility_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.facility: ~0 rows (approximately)
DELETE FROM `facility`;
/*!40000 ALTER TABLE `facility` DISABLE KEYS */;
/*!40000 ALTER TABLE `facility` ENABLE KEYS */;

-- Dumping structure for table license_db.facility_equipments
DROP TABLE IF EXISTS `facility_equipments`;
CREATE TABLE IF NOT EXISTS `facility_equipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `facility_id` bigint(20) unsigned NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_facility_equipments_facility` (`facility_id`),
  KEY `FK_facility_equipments_equipment` (`equipment_id`),
  CONSTRAINT `FK_facility_equipments_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_facility_equipments_facility` FOREIGN KEY (`facility_id`) REFERENCES `facility` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.facility_equipments: ~0 rows (approximately)
DELETE FROM `facility_equipments`;
/*!40000 ALTER TABLE `facility_equipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `facility_equipments` ENABLE KEYS */;

-- Dumping structure for table license_db.file_upload_for_documents
DROP TABLE IF EXISTS `file_upload_for_documents`;
CREATE TABLE IF NOT EXISTS `file_upload_for_documents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `project` bigint(20) DEFAULT NULL,
  `version` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `uploaded_by` bigint(20) unsigned NOT NULL,
  `uploaded_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_file_upload_for_documents_organization_info` (`org_id`),
  KEY `FK_file_upload_for_documents_project_version` (`version`),
  KEY `FK_file_upload_for_documents_permissions` (`document_type`),
  KEY `FK_file_upload_for_documents_users` (`uploaded_by`),
  CONSTRAINT `FK_file_upload_for_documents_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_file_upload_for_documents_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_file_upload_for_documents_project_version` FOREIGN KEY (`version`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_file_upload_for_documents_users` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.file_upload_for_documents: ~8 rows (approximately)
DELETE FROM `file_upload_for_documents`;
/*!40000 ALTER TABLE `file_upload_for_documents` DISABLE KEYS */;
INSERT INTO `file_upload_for_documents` (`id`, `org_id`, `project`, `version`, `document_type`, `document_id`, `file_name`, `file_path`, `uploaded_by`, `uploaded_time`, `url`) VALUES
	(1, 1, NULL, NULL, '230', 10, 'Specification_2022-01-07 03-08.docx', 'IVAL//TemplateLibrary/Template Library/Attachments/1642391239894.docx', 1, '2022-01-17 03:47:42', ''),
	(2, 1, NULL, NULL, '230', 10, 'Compliance Report_certificate.pdf', 'IVAL//TemplateLibrary/Template Library/Attachments/1642391239894.pdf', 1, '2022-01-17 03:47:49', ''),
	(3, 1, NULL, NULL, '230', 10, 'GxP_Assessment.pdf', 'IVAL//TemplateLibrary/Template Library/Attachments/1642391239898.pdf', 1, '2022-01-17 03:47:57', ''),
	(4, 1, NULL, NULL, '230', 10, 'Traceability Matrix_certificate.pdf', 'IVAL//TemplateLibrary/Template Library/Attachments/1642391239894.pdf', 1, '2022-01-17 03:48:02', ''),
	(5, 1, NULL, NULL, '230', 12, 'GxP_Assessment.pdf', 'IVAL//TemplateLibrary/Template Library 2/Attachments/1642391356344.pdf', 1, '2022-01-17 03:49:37', ''),
	(6, 1, NULL, NULL, '230', 12, 'Compliance Report_certificate.pdf', 'IVAL//TemplateLibrary/Template Library 2/Attachments/1642391356340.pdf', 1, '2022-01-17 03:49:43', ''),
	(7, 1, NULL, NULL, '230', 12, 'Traceability Matrix_certificate.pdf', 'IVAL//TemplateLibrary/Template Library 2/Attachments/1642391356340.pdf', 1, '2022-01-17 03:49:49', ''),
	(8, 1, NULL, NULL, '230', 12, 'Sample OQ for Testing.docx', 'IVAL//TemplateLibrary/Template Library 2/Attachments/1642391356348.docx', 1, '2022-01-17 03:49:58', '');
/*!40000 ALTER TABLE `file_upload_for_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_data_documents_child
DROP TABLE IF EXISTS `flow_data_documents_child`;
CREATE TABLE IF NOT EXISTS `flow_data_documents_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_type` bigint(20) unsigned NOT NULL,
  `flow_data_parent` bigint(20) unsigned NOT NULL,
  `flow_data_id` bigint(20) unsigned NOT NULL,
  `action_by` bigint(20) unsigned NOT NULL,
  `comments` longtext DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `current_session` bigint(20) DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `statusflag` varchar(1) DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK_workflow_document_child_workflow_for_documents12` (`flow_data_parent`),
  KEY `FK_workflow_document_child_work_flow_levels12` (`flow_data_id`),
  KEY `FK_workflow_document_child_users12` (`action_by`),
  KEY `FK_flow_data_documents_child_flow_settings_master12` (`flow_type`),
  CONSTRAINT `FK_flow_data_documents_child_flow_level_child` FOREIGN KEY (`flow_data_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_flow_data_documents_child_flow_settings_master12` FOREIGN KEY (`flow_type`) REFERENCES `flow_settings_master` (`id`),
  CONSTRAINT `FK_workflow_document_child_users12` FOREIGN KEY (`action_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_workflow_document_child_workflow_for_documents12` FOREIGN KEY (`flow_data_parent`) REFERENCES `flow_data_documents_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_data_documents_child: ~0 rows (approximately)
DELETE FROM `flow_data_documents_child`;
/*!40000 ALTER TABLE `flow_data_documents_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_data_documents_child` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_data_documents_master
DROP TABLE IF EXISTS `flow_data_documents_master`;
CREATE TABLE IF NOT EXISTS `flow_data_documents_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_id` bigint(20) NOT NULL,
  `currentlevel` bigint(20) unsigned NOT NULL DEFAULT 0,
  `workflow_completed_Flag` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_workflow_documents_master_project_setup1` (`project_id`),
  KEY `FK_workflow_documents_master_permissions1` (`document_type`),
  KEY `FK_workflow_documents_master_project_version1` (`version_id`),
  KEY `FK_flow_data_documents_master_flow_level_child` (`currentlevel`),
  KEY `FK_flow_data_documents_master_organization_info` (`org_id`),
  CONSTRAINT `FK_flow_data_documents_master_flow_level_child` FOREIGN KEY (`currentlevel`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_flow_data_documents_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_workflow_documents_master_permissions1` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_workflow_documents_master_project_setup1` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_workflow_documents_master_project_version1` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_data_documents_master: ~0 rows (approximately)
DELETE FROM `flow_data_documents_master`;
/*!40000 ALTER TABLE `flow_data_documents_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_data_documents_master` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_document_master
DROP TABLE IF EXISTS `flow_document_master`;
CREATE TABLE IF NOT EXISTS `flow_document_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `created_user` bigint(20) unsigned NOT NULL DEFAULT 0,
  `updated_user` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_time` datetime NOT NULL DEFAULT current_timestamp(),
  `display_order` bigint(20) NOT NULL DEFAULT 0,
  `document_number` varchar(50) DEFAULT '0',
  `updated_time` datetime NOT NULL DEFAULT current_timestamp(),
  `active_flag` char(50) NOT NULL DEFAULT 'Y',
  `freeze_flag` char(50) NOT NULL DEFAULT 'N',
  `auto_lock_flag` varchar(1) NOT NULL DEFAULT 'N',
  `active_revision_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_work_flow_users_for_project_project_setup1` (`project_id`),
  KEY `FK_work_flow_users_for_project_permissions1` (`document_type`),
  KEY `FK_work_flow_users_for_project_project_version1` (`version_id`),
  KEY `FK_workflow_document_flow_users1` (`created_user`),
  KEY `FK_workflow_document_flow_users_21` (`updated_user`),
  KEY `FK_flow_document_master_organization_info` (`org_id`),
  CONSTRAINT `FK_flow_document_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_work_flow_users_for_project_permissions1` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_work_flow_users_for_project_project_setup1` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_work_flow_users_for_project_project_version1` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_workflow_document_flow_users1` FOREIGN KEY (`created_user`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_workflow_document_flow_users_21` FOREIGN KEY (`updated_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_document_master: ~0 rows (approximately)
DELETE FROM `flow_document_master`;
/*!40000 ALTER TABLE `flow_document_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_document_master` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_form_group_settings
DROP TABLE IF EXISTS `flow_form_group_settings`;
CREATE TABLE IF NOT EXISTS `flow_form_group_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `mapping_id` bigint(20) unsigned NOT NULL,
  `common_approval_flag` varchar(1) NOT NULL,
  `workflow_sequence_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_flow_form_group_settings_project_setup` (`project_id`),
  KEY `FK_flow_form_group_settings_master_form_mapping` (`mapping_id`),
  CONSTRAINT `FK_flow_form_group_settings_master_form_mapping` FOREIGN KEY (`mapping_id`) REFERENCES `master_form_mapping` (`id`),
  CONSTRAINT `FK_flow_form_group_settings_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_form_group_settings: ~0 rows (approximately)
DELETE FROM `flow_form_group_settings`;
/*!40000 ALTER TABLE `flow_form_group_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_form_group_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_level_child
DROP TABLE IF EXISTS `flow_level_child`;
CREATE TABLE IF NOT EXISTS `flow_level_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_document_master_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `level_id` bigint(20) NOT NULL DEFAULT 0,
  `order_number` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_user` bigint(20) unsigned NOT NULL DEFAULT 0,
  `updated_user` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `sla` varchar(50) DEFAULT NULL,
  `end_date` varchar(50) DEFAULT NULL,
  `start_date` varchar(50) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `responsibility` longtext DEFAULT NULL,
  `all_user_approval` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_workflow_document_flow_child_users` (`created_user`),
  KEY `FK_workflow_document_flow_child_users_2` (`updated_user`),
  KEY `FK_flow_level_child_flow_document_master` (`flow_document_master_id`),
  KEY `FK_flow_level_child_flow_level_master` (`level_id`),
  CONSTRAINT `FK_flow_level_child_flow_document_master` FOREIGN KEY (`flow_document_master_id`) REFERENCES `flow_document_master` (`id`),
  CONSTRAINT `FK_flow_level_child_flow_level_master` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_workflow_document_flow_child_users` FOREIGN KEY (`created_user`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_workflow_document_flow_child_users_2` FOREIGN KEY (`updated_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_level_child: ~0 rows (approximately)
DELETE FROM `flow_level_child`;
/*!40000 ALTER TABLE `flow_level_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_level_child` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_level_child_settings
DROP TABLE IF EXISTS `flow_level_child_settings`;
CREATE TABLE IF NOT EXISTS `flow_level_child_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_level_child_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `option_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_flow_level_child_settings_flow_level_child` (`flow_level_child_id`),
  KEY `FK_flow_level_child_settings_flow_settings_master` (`option_id`),
  CONSTRAINT `FK_flow_level_child_settings_flow_level_child` FOREIGN KEY (`flow_level_child_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_flow_level_child_settings_flow_settings_master` FOREIGN KEY (`option_id`) REFERENCES `flow_settings_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_level_child_settings: ~0 rows (approximately)
DELETE FROM `flow_level_child_settings`;
/*!40000 ALTER TABLE `flow_level_child_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_level_child_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_level_child_sub_settings
DROP TABLE IF EXISTS `flow_level_child_sub_settings`;
CREATE TABLE IF NOT EXISTS `flow_level_child_sub_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level_settings_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `sub_settings_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_flow_level_child_sub_settings_flow_settings_sub_master` (`sub_settings_id`),
  KEY `FK_flow_level_child_sub_settings_flow_level_child` (`level_settings_id`),
  CONSTRAINT `FK_flow_level_child_sub_settings_flow_level_child` FOREIGN KEY (`level_settings_id`) REFERENCES `flow_level_child_settings` (`id`),
  CONSTRAINT `FK_flow_level_child_sub_settings_flow_settings_sub_master` FOREIGN KEY (`sub_settings_id`) REFERENCES `flow_settings_sub_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_level_child_sub_settings: ~0 rows (approximately)
DELETE FROM `flow_level_child_sub_settings`;
/*!40000 ALTER TABLE `flow_level_child_sub_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_level_child_sub_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_level_child_users
DROP TABLE IF EXISTS `flow_level_child_users`;
CREATE TABLE IF NOT EXISTS `flow_level_child_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_level_child_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `display_order` int(11) DEFAULT 0,
  `notification_flag` varchar(1) DEFAULT 'Y',
  `email_flag` varchar(1) DEFAULT 'Y',
  `follow_up_flag` varchar(1) DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK_flow_level_users_flow_level_child` (`flow_level_child_id`),
  KEY `FK_flow_level_users_users` (`user_id`),
  CONSTRAINT `FK_flow_level_users_flow_level_child` FOREIGN KEY (`flow_level_child_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_flow_level_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_level_child_users: ~0 rows (approximately)
DELETE FROM `flow_level_child_users`;
/*!40000 ALTER TABLE `flow_level_child_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_level_child_users` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_level_master
DROP TABLE IF EXISTS `flow_level_master`;
CREATE TABLE IF NOT EXISTS `flow_level_master` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `work_flow_level_name` varchar(50) DEFAULT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `org_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_work_flow_levels_users1` (`updated_by`),
  KEY `FK_work_flow_levels_organization_info1` (`org_id`),
  CONSTRAINT `FK_work_flow_levels_organization_info1` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_work_flow_levels_users1` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_level_master: ~0 rows (approximately)
DELETE FROM `flow_level_master`;
/*!40000 ALTER TABLE `flow_level_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_level_master` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_logs
DROP TABLE IF EXISTS `flow_logs`;
CREATE TABLE IF NOT EXISTS `flow_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_data_document_master` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) unsigned NOT NULL,
  `session` bigint(20) unsigned NOT NULL,
  `createdby` bigint(20) unsigned NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `event` bigint(20) unsigned NOT NULL,
  `status` varchar(1) NOT NULL,
  `comments` longtext DEFAULT NULL,
  `signature` longtext DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_flow_logs_flow_data_documents_master` (`flow_data_document_master`),
  KEY `FK_flow_logs_flow_level_child` (`level_id`),
  KEY `FK_flow_logs_users` (`createdby`),
  KEY `FK_flow_logs_flow_settings_master` (`event`),
  CONSTRAINT `FK_flow_logs_flow_data_documents_master` FOREIGN KEY (`flow_data_document_master`) REFERENCES `flow_data_documents_master` (`id`),
  CONSTRAINT `FK_flow_logs_flow_level_child` FOREIGN KEY (`level_id`) REFERENCES `flow_level_child` (`id`),
  CONSTRAINT `FK_flow_logs_flow_settings_master` FOREIGN KEY (`event`) REFERENCES `flow_settings_master` (`id`),
  CONSTRAINT `FK_flow_logs_users` FOREIGN KEY (`createdby`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_logs: ~0 rows (approximately)
DELETE FROM `flow_logs`;
/*!40000 ALTER TABLE `flow_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_logs` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_settings_master
DROP TABLE IF EXISTS `flow_settings_master`;
CREATE TABLE IF NOT EXISTS `flow_settings_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(50) NOT NULL DEFAULT '0',
  `mainpage` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_settings_master: ~2 rows (approximately)
DELETE FROM `flow_settings_master`;
/*!40000 ALTER TABLE `flow_settings_master` DISABLE KEYS */;
INSERT INTO `flow_settings_master` (`id`, `option_name`, `mainpage`) VALUES
	(1, 'Approval', 'Y'),
	(2, 'Esign', 'Y');
/*!40000 ALTER TABLE `flow_settings_master` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_settings_sub_master
DROP TABLE IF EXISTS `flow_settings_sub_master`;
CREATE TABLE IF NOT EXISTS `flow_settings_sub_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `settings_master_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `sub_settings_name` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_flow_sub_settings_master_flow_settings_master` (`settings_master_id`),
  CONSTRAINT `FK_flow_sub_settings_master_flow_settings_master` FOREIGN KEY (`settings_master_id`) REFERENCES `flow_settings_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_settings_sub_master: ~0 rows (approximately)
DELETE FROM `flow_settings_sub_master`;
/*!40000 ALTER TABLE `flow_settings_sub_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_settings_sub_master` ENABLE KEYS */;

-- Dumping structure for table license_db.flow_static_document_settings
DROP TABLE IF EXISTS `flow_static_document_settings`;
CREATE TABLE IF NOT EXISTS `flow_static_document_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `workflow_sequence_flag` varchar(1) NOT NULL,
  `default_project_for_creator` varchar(1) NOT NULL DEFAULT 'N',
  `default_project_workflow_users` varchar(1) NOT NULL DEFAULT 'N',
  `auto_lock` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_flow_static_form_settings_project_setup` (`project_id`),
  CONSTRAINT `FK_flow_static_form_settings_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.flow_static_document_settings: ~0 rows (approximately)
DELETE FROM `flow_static_document_settings`;
/*!40000 ALTER TABLE `flow_static_document_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `flow_static_document_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.form_extend_for_static_document
DROP TABLE IF EXISTS `form_extend_for_static_document`;
CREATE TABLE IF NOT EXISTS `form_extend_for_static_document` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `document_constant` varchar(50) NOT NULL,
  `json_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`json_structure`)),
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_master_form_extend_for_static_document_organization_info` (`organization_id`),
  KEY `FK_master_form_extend_for_static_document_project_setup` (`project_id`),
  KEY `FK_master_form_extend_for_static_document_permissions` (`document_constant`),
  KEY `FK_master_form_extend_for_static_document_users` (`created_by`),
  KEY `FK_master_form_extend_for_static_document_users_2` (`updated_by`),
  CONSTRAINT `FK_master_form_extend_for_static_document_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_master_form_extend_for_static_document_permissions` FOREIGN KEY (`document_constant`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_master_form_extend_for_static_document_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_master_form_extend_for_static_document_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_form_extend_for_static_document_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.form_extend_for_static_document: ~0 rows (approximately)
DELETE FROM `form_extend_for_static_document`;
/*!40000 ALTER TABLE `form_extend_for_static_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_extend_for_static_document` ENABLE KEYS */;

-- Dumping structure for table license_db.form_link_selected_project
DROP TABLE IF EXISTS `form_link_selected_project`;
CREATE TABLE IF NOT EXISTS `form_link_selected_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_get_form_link_data_project_project_setup` (`project_id`) USING BTREE,
  KEY `FK_form_link_selected_project_master_for_dynamic_form_link` (`parent_id`) USING BTREE,
  CONSTRAINT `FK_form_link_selected_project_master_for_dynamic_form_link` FOREIGN KEY (`parent_id`) REFERENCES `master_for_dynamic_form_link` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_get_form_link_data_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='This table is used to load the data of dynamic form from which project ';

-- Dumping data for table license_db.form_link_selected_project: ~0 rows (approximately)
DELETE FROM `form_link_selected_project`;
/*!40000 ALTER TABLE `form_link_selected_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `form_link_selected_project` ENABLE KEYS */;

-- Dumping structure for table license_db.ftp_file_path
DROP TABLE IF EXISTS `ftp_file_path`;
CREATE TABLE IF NOT EXISTS `ftp_file_path` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iq_test_case_id` bigint(20) unsigned DEFAULT NULL,
  `discrepancy_form_id` bigint(20) unsigned DEFAULT NULL,
  `unscripted_id` bigint(20) unsigned DEFAULT NULL,
  `file_name` varchar(200) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `file_type` varchar(50) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK1_video_path` (`iq_test_case_id`),
  KEY `FK2_file_path` (`discrepancy_form_id`),
  KEY `FK3_users` (`created_by`),
  KEY `FK_ftp_file_path_unscripted_test_case` (`unscripted_id`),
  CONSTRAINT `FK1_video_path` FOREIGN KEY (`iq_test_case_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK2_file_path` FOREIGN KEY (`discrepancy_form_id`) REFERENCES `discrepancy_form` (`id`),
  CONSTRAINT `FK3_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ftp_file_path_unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ftp_file_path: ~0 rows (approximately)
DELETE FROM `ftp_file_path`;
/*!40000 ALTER TABLE `ftp_file_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftp_file_path` ENABLE KEYS */;

-- Dumping structure for table license_db.ftp_video_path
DROP TABLE IF EXISTS `ftp_video_path`;
CREATE TABLE IF NOT EXISTS `ftp_video_path` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iq_test_case_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `file_name` varchar(200) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_video_path` (`iq_test_case_id`),
  CONSTRAINT `FK_video_path` FOREIGN KEY (`iq_test_case_id`) REFERENCES `iq_test_cases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ftp_video_path: ~0 rows (approximately)
DELETE FROM `ftp_video_path`;
/*!40000 ALTER TABLE `ftp_video_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `ftp_video_path` ENABLE KEYS */;

-- Dumping structure for table license_db.gamp_categories
DROP TABLE IF EXISTS `gamp_categories`;
CREATE TABLE IF NOT EXISTS `gamp_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gamp_name` varchar(50) NOT NULL,
  `gamp_description` varchar(200) NOT NULL,
  `order_id` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gamp_categories: ~4 rows (approximately)
DELETE FROM `gamp_categories`;
/*!40000 ALTER TABLE `gamp_categories` DISABLE KEYS */;
INSERT INTO `gamp_categories` (`id`, `gamp_name`, `gamp_description`, `order_id`) VALUES
	(1, 'Category 1', 'Infrastructure software\r\n(Category 1)', 1),
	(2, 'Category 3', 'Non-configured software\r\n(Category 3)', 2),
	(3, 'Category 4', 'Configured software\r\n(Category 4) ', 3),
	(4, 'Category 5', 'Customized software\r\n(Category 5) ', 4);
/*!40000 ALTER TABLE `gamp_categories` ENABLE KEYS */;

-- Dumping structure for table license_db.gamp_critical_array
DROP TABLE IF EXISTS `gamp_critical_array`;
CREATE TABLE IF NOT EXISTS `gamp_critical_array` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gamp_id` bigint(20) unsigned NOT NULL,
  `critical_level_id` bigint(20) unsigned NOT NULL,
  `row_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `column_order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `value` varchar(50) NOT NULL DEFAULT '0',
  `key_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_gamp_critical_array_gamp_categories` (`gamp_id`) USING BTREE,
  KEY `FK_gamp_critical_array_criticality_level` (`critical_level_id`) USING BTREE,
  CONSTRAINT `FK_gamp_critical_array_criticality_level` FOREIGN KEY (`critical_level_id`) REFERENCES `criticality_level` (`id`),
  CONSTRAINT `FK_gamp_critical_array_gamp_categories` FOREIGN KEY (`gamp_id`) REFERENCES `gamp_categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gamp_critical_array: ~12 rows (approximately)
DELETE FROM `gamp_critical_array`;
/*!40000 ALTER TABLE `gamp_critical_array` DISABLE KEYS */;
INSERT INTO `gamp_critical_array` (`id`, `gamp_id`, `critical_level_id`, `row_order_id`, `column_order_id`, `value`, `key_value`) VALUES
	(16, 1, 1, 1, 1, 'A', 'A-Low'),
	(17, 1, 2, 1, 2, 'A', 'A-Low'),
	(18, 1, 3, 1, 3, 'A', 'A-Low'),
	(19, 2, 1, 2, 1, 'A', 'A-Low'),
	(20, 2, 2, 2, 2, 'A', 'A-Low'),
	(21, 2, 3, 2, 3, 'B', 'B-Medium'),
	(22, 3, 1, 3, 1, 'B', 'B-Medium'),
	(23, 3, 2, 3, 2, 'B', 'B-Medium'),
	(24, 3, 3, 3, 3, 'C', 'C-High'),
	(25, 4, 1, 4, 1, 'B', 'B-Medium'),
	(26, 4, 2, 4, 2, 'C', 'C-High'),
	(27, 4, 3, 4, 3, 'C', 'C-High');
/*!40000 ALTER TABLE `gamp_critical_array` ENABLE KEYS */;

-- Dumping structure for table license_db.gxp_document_selection
DROP TABLE IF EXISTS `gxp_document_selection`;
CREATE TABLE IF NOT EXISTS `gxp_document_selection` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `gamp_id` bigint(20) unsigned NOT NULL,
  `critical_level_id` bigint(20) unsigned NOT NULL,
  `permission_id` varchar(50) NOT NULL DEFAULT '',
  `order_id` int(11) DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_criticality_gamp_document_gamp_categories` (`gamp_id`) USING BTREE,
  KEY `FK_criticality_gamp_document_criticality_level` (`critical_level_id`) USING BTREE,
  KEY `FK_criticality_gamp_document_permissions` (`permission_id`) USING BTREE,
  CONSTRAINT `FK_criticality_gamp_document_criticality_level` FOREIGN KEY (`critical_level_id`) REFERENCES `criticality_level` (`id`),
  CONSTRAINT `FK_criticality_gamp_document_gamp_categories` FOREIGN KEY (`gamp_id`) REFERENCES `gamp_categories` (`id`),
  CONSTRAINT `FK_criticality_gamp_document_permissions` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`permission_constant_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gxp_document_selection: ~60 rows (approximately)
DELETE FROM `gxp_document_selection`;
/*!40000 ALTER TABLE `gxp_document_selection` DISABLE KEYS */;
INSERT INTO `gxp_document_selection` (`id`, `gamp_id`, `critical_level_id`, `permission_id`, `order_id`) VALUES
	(1, 1, 1, '107', 1),
	(2, 1, 1, '108', 2),
	(3, 1, 2, '108', 2),
	(4, 1, 2, '107', 1),
	(7, 2, 1, '107', 1),
	(8, 2, 2, '107', 1),
	(10, 2, 1, '108', 2),
	(11, 2, 2, '108', 2),
	(13, 2, 1, '109', 3),
	(14, 2, 2, '109', 3),
	(16, 2, 1, '110', 4),
	(17, 2, 2, '110', 4),
	(19, 2, 2, '137', 5),
	(21, 2, 1, '137', 5),
	(63, 3, 1, '107', 1),
	(64, 3, 2, '107', 1),
	(65, 3, 3, '107', 1),
	(66, 3, 1, '108', 2),
	(67, 3, 2, '108', 4),
	(68, 3, 3, '108', 4),
	(69, 3, 1, '109', 3),
	(70, 3, 2, '109', 5),
	(71, 3, 3, '109', 5),
	(72, 3, 1, '110', 4),
	(73, 3, 2, '110', 6),
	(74, 3, 3, '110', 6),
	(75, 3, 1, '137', 5),
	(76, 3, 2, '137', 7),
	(77, 3, 3, '137', 7),
	(78, 3, 2, '200', 2),
	(79, 3, 3, '200', 2),
	(80, 4, 1, '107', 1),
	(81, 4, 2, '107', 1),
	(82, 4, 3, '107', 1),
	(83, 4, 1, '108', 2),
	(84, 4, 2, '108', 4),
	(85, 4, 3, '108', 4),
	(86, 4, 1, '109', 3),
	(87, 4, 2, '109', 5),
	(88, 4, 3, '109', 5),
	(89, 4, 1, '110', 4),
	(90, 4, 2, '110', 6),
	(91, 4, 3, '110', 6),
	(92, 4, 1, '137', 5),
	(93, 4, 2, '137', 7),
	(94, 4, 3, '137', 7),
	(95, 4, 2, '200', 2),
	(96, 4, 3, '200', 2),
	(98, 1, 3, '107', 1),
	(102, 1, 3, '108', 2),
	(103, 2, 3, '107', 1),
	(104, 2, 3, '113', 2),
	(105, 2, 3, '108', 3),
	(106, 2, 3, '109', 4),
	(108, 2, 3, '110', 5),
	(109, 2, 3, '137', 6),
	(110, 3, 2, '113', 3),
	(111, 3, 3, '113', 3),
	(112, 4, 2, '113', 3),
	(113, 4, 3, '113', 3);
/*!40000 ALTER TABLE `gxp_document_selection` ENABLE KEYS */;

-- Dumping structure for table license_db.gxp_form_for_project
DROP TABLE IF EXISTS `gxp_form_for_project`;
CREATE TABLE IF NOT EXISTS `gxp_form_for_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `form_type` varchar(50) NOT NULL DEFAULT '0',
  `section_two` varchar(50) DEFAULT '0',
  `gamp_id` bigint(20) unsigned DEFAULT 0,
  `critical_level_id` bigint(20) unsigned DEFAULT 0,
  `matrix_id` bigint(20) unsigned DEFAULT 0,
  `created_by` bigint(20) unsigned NOT NULL DEFAULT 0,
  `updated_by` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `freeze_flag` varchar(1) DEFAULT 'N',
  `gdpr_conclusion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gxp_form_for_project: ~0 rows (approximately)
DELETE FROM `gxp_form_for_project`;
/*!40000 ALTER TABLE `gxp_form_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `gxp_form_for_project` ENABLE KEYS */;

-- Dumping structure for table license_db.gxp_form_for_project_questions
DROP TABLE IF EXISTS `gxp_form_for_project_questions`;
CREATE TABLE IF NOT EXISTS `gxp_form_for_project_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `question_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `answer` varchar(50) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gxp_form_for_project_questions: ~0 rows (approximately)
DELETE FROM `gxp_form_for_project_questions`;
/*!40000 ALTER TABLE `gxp_form_for_project_questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `gxp_form_for_project_questions` ENABLE KEYS */;

-- Dumping structure for table license_db.gxp_questions
DROP TABLE IF EXISTS `gxp_questions`;
CREATE TABLE IF NOT EXISTS `gxp_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sr_no` varchar(50) NOT NULL DEFAULT '',
  `question_section_id` int(10) unsigned NOT NULL DEFAULT 0,
  `order_id` int(10) unsigned NOT NULL DEFAULT 0,
  `question` text NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `unique_key` varchar(50) NOT NULL DEFAULT 'uni',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.gxp_questions: ~46 rows (approximately)
DELETE FROM `gxp_questions`;
/*!40000 ALTER TABLE `gxp_questions` DISABLE KEYS */;
INSERT INTO `gxp_questions` (`id`, `sr_no`, `question_section_id`, `order_id`, `question`, `delete_flag`, `unique_key`) VALUES
	(17, 'GA-Q1', 1, 1, 'Does the system control, record, change, monitor, track, store, transmit or make decisions about data related to products, process or components?', 'N', 'ga1'),
	(18, 'GA-Q2', 1, 2, 'Is this system used to automate manufacturing / Packaging / Laboratory / QMS process?', 'N', 'ga2'),
	(19, 'GA-Q3', 1, 3, 'Does this system used to provide training to employees?', 'N', 'ga3'),
	(20, 'GA-Q4', 1, 4, 'Is this system used to monitor, control or supervise environment? (e.g.\r\nTemperature, Humidity) ', 'N', 'ga4'),
	(21, 'GA-Q5', 1, 5, 'Is the system used for physical access to manufacturing, laboratory, or\r\ndocumentation archives?', 'N', 'ga5'),
	(22, 'GA-Q6', 1, 6, 'Is the system used to maintain purchasing, inventory, or distribution data\r\nfor the company\'s products?', 'N', 'ga6'),
	(23, 'EA-Q1', 2, 1, 'Does the system create/modify/maintain/archive/retrieve or transmit GxP relevant electronic records? ', 'N', 'eaq1'),
	(24, 'EA-Q2', 2, 2, 'If the system processes electronic records as mentioned above, are these records used in their electronic form to support GxP decision?', 'N', 'eaq2'),
	(25, 'EA-Q3', 2, 3, 'Does the system involve e-signatures (as a part of a workflow and/or mandated by the predicate rules) that are intended to be the equivalent of handwritten signatures/initials?', 'N', 'eaq3'),
	(26, '1 (Infrastructure Software)', 3, 1, 'Is it an Infrastructure Software i.e. Layered software (i.e., upon\r\nwhich applications are built) or software used to manage the\r\noperating environment? If no then go to next question.\r\nTypical Examples: Operating Systems, Database Engines,\r\nMiddleware, Programming languages, Statistical packages,\r\nNetwork monitoring tools, Scheduling tools, Version control\r\ntools.\r', 'N', '1'),
	(27, '3\r\n(Non-Configured\r\nProducts)', 3, 2, 'Is it a Non-Configured Products? If no then go to next question.\r\nTypical Examples: COTS software.\r\nNote: Run-time parameters may be entered and stored, but the\r\nsoftware cannot be configured to suit the business process\r', 'N', '2'),
	(28, '4 (Configured Products)', 3, 3, 'Is it a commercially available package that involves configuring\r\npredefined software modules? If no then go to next question.\r\nTypical Examples: LMS, Data acquisition systems, ADR\r\nReporting, CDMS, EDMS, Spreadsheets.\r\nNote: Software, often very complex, that can be configured by the\r\nuser to meet the specific needs of the user\'s business process.\r\nSoftware code is not altered.', 'N', '3'),
	(29, '5\r\n(Custom\r\nApplications)', 3, 4, 'Is it a Custom Applications i.e. Software custom designed and\r\ncoded to suit the business process without any prior history of\r\nusage?\r\nTypical Examples: Internally and externally developed IT\r\napplications, Custom Firmware, Spreadsheet with macros,\r\ncustomized modules/functions in configurable software. ', 'N', '4'),
	(30, '1', 4, 1, 'Failure of the system has Insignificant impact on product quality and/or the\r\nimpact is under control / acceptable. Unlikely to result in a regulatory\r\ncitation and is non-reportable ', 'N', 'Low'),
	(31, '2', 4, 2, 'The system is not directly in contact with the product and generates data that\r\nmay or may not be used for product acceptance /rejection.\r\nFurther the failure of system can provoke minor regulatory observation for\r\nimprovement. It could have regulatory impact such as Health Authority\r\ninspection observations, e.g., FDA Form 483 observations that might require\r\nsignificant commitment of resources or money for remediation', 'N', 'Medium'),
	(32, '3', 4, 3, 'The system gets in direct contact with the product and generates data that is\r\nused for decision making of product acceptance and rejection.\r\nThe failure of such system could provoke warning or observations,\r\nseizer/recall of goods or more serious regulatory penalty. ', 'N', 'High'),
	(33, ' ', 5, 1, 'Does the system manage personal information?', 'N', 'pd'),
	(34, '', 5, 2, 'Does the system manage sensitive personal information?', 'N', 'sd'),
	(35, '', 6, 1, 'Is the system in scope of Financial regulations (e.g. SOX)?', 'N', 'uni'),
	(36, '', 6, 2, 'Is the system in scope of Health safety and environmental regulations?', 'N', 'uni'),
	(37, 'S. No', 1, 1, 'Question', 'N', 'ga1'),
	(38, 'GA-Q1', 1, 2, 'Is the system used to produce, collect or process data that may be used in (drug) regulatory submissions?', 'N', 'ga2'),
	(39, 'GA-Q2', 1, 3, 'Is the system involved in the environmental monitoring or control processes of facilities used for animals in GxP studies or for the manufacture, processing, packaging, holding or distribution of products?', 'N', 'ga3'),
	(40, 'GA-Q3', 1, 4, 'Is the system used in the collection, analysis or storage of data from clinical trials?', 'N', 'ga4'),
	(41, 'GA-Q4', 1, 5, 'Is the system used for processes concerned with drug safety, Pharmacovigilance and stability studies?', 'N', 'ga5'),
	(42, 'GA-Q5', 1, 6, 'Is the system used for distribution of information in the event of a commercial product recall, or inpatient follow-up of clinical trials?', 'N', 'ga6'),
	(43, 'GA-Q6', 1, 7, 'Is the system officially primary auditable part of a production/process liable to external audits or inspections by regulatory authorities?', 'N', 'ga7'),
	(44, 'GA-Q7', 1, 8, 'Is the application/system the official auditable, archive or record of any regulated activity?', 'N', 'ga8'),
	(45, 'GA-Q8', 1, 9, 'Does the system, either automatically or based on user inputs and/or Equipment Inputs or Outputs (I/O), formally control or impact any actions that affect the processing of a component or drug product like determining critical parameters of a component of drug product?', 'N', 'ga9'),
	(46, 'GA-Q9', 1, 10, 'Does the system store data that captures the actual manufacturing or packaging data for a given component or drug product? (e.g., quantity of materials added, missing time etc.)', 'N', 'ga10'),
	(47, 'GA-Q10', 1, 11, 'Does the system control any process in the manufacturing or packaging or distribution of a component or drug products?', 'N', 'ga11'),
	(48, 'GA-Q11', 1, 12, 'Does the system affect calculations that are used to determine any quality attributes affecting the component or drug product release?', 'N', 'ga12'),
	(49, 'GA-Q12', 1, 13, 'Does the system store data that is the result of the testing performed on the component or drug product? (Note that this includes raw data and test results)', 'N', 'ga13'),
	(50, 'GA-Q13', 1, 14, 'Does the system maintain any formal procedure, work instruction or product or process information details, training details (e.g., SOPs, Batch Sheets, BMR, BPR, training records etc.) used in the manufacture of a component or drug products?', 'N', 'ga14'),
	(51, 'GA-Q14', 1, 15, 'Does the system record the lots or batches that have been produced using a given set of equipment or procedures?', 'N', 'ga15'),
	(52, 'GA-Q15', 1, 16, 'Does the application/system create, update or store data that is a direct input to regulated system?', 'N', 'ga16'),
	(53, 'GA-Q16', 1, 17, 'Does the system create/generate documents that can be used to modify the processing of a component of drug product? (e.g., work orders)', 'N', 'ga17'),
	(54, 'GA-Q17', 1, 18, 'Does the application/system control, record for use or monitor laboratory testing or clinical data? ', 'N', 'ga18'),
	(55, 'GA-Q18', 1, 19, 'Does the system support GxP applications? (e.g., LAN/WAN with GxP applications, Servers that host GxP applications, Desktops that contain or support GxP applications)', 'N', 'ga19'),
	(56, 'GA-Q19', 1, 20, 'The system requires validation as per GxP regulations \n[Note: The Project Validation and Qualification Plan including Qualification Protocols need approval by QA]', 'N', 'ga20'),
	(57, 'GA-Q20', 1, 21, 'Does the system create, modify, maintain, archive, retrieve or transmit GxP relevant records required to be retained in electronic format in place of paper format?', 'N', 'ga21'),
	(58, 'GA-Q21', 1, 22, 'Are the e-records (referred to in 2.22) transmitted to other systems to carry out the GxP activities?', 'N', 'ga22'),
	(59, 'GA-Q22', 1, 23, 'Does the system involve e-signatures (as a part of a workflow and/or mandated by the predicate rules) that are intended to be the equivalent of handwritten signatures/initials?', 'N', 'ga23'),
	(60, 'GA-Q23', 1, 24, 'Is which system access is controlled by person(s), who are responsible for the content of electronic records that are on the system?', 'N', 'ga24'),
	(61, 'GA-Q24', 1, 25, 'Specific controls for e-records must be implemented according to “Electronic Records / Electronic Signatures Guideline”', 'N', 'ga25'),
	(62, 'GA-Q25', 1, 26, 'Specific controls for e-signatures must be implemented according to “Electronic Records / Electronic Signatures Guideline”\nNote: “Please fill out this point ONLY if you have answered YES to the previous question”.', 'N', 'ga26');
/*!40000 ALTER TABLE `gxp_questions` ENABLE KEYS */;

-- Dumping structure for table license_db.import_template_file
DROP TABLE IF EXISTS `import_template_file`;
CREATE TABLE IF NOT EXISTS `import_template_file` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `file_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.import_template_file: ~0 rows (approximately)
DELETE FROM `import_template_file`;
/*!40000 ALTER TABLE `import_template_file` DISABLE KEYS */;
/*!40000 ALTER TABLE `import_template_file` ENABLE KEYS */;

-- Dumping structure for table license_db.individual_document_flow_levels
DROP TABLE IF EXISTS `individual_document_flow_levels`;
CREATE TABLE IF NOT EXISTS `individual_document_flow_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  `option_id` bigint(20) unsigned NOT NULL,
  `order_number` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_individual_document_flow_levels_master` (`master_id`),
  KEY `FK_individual_document_flow_levels_flow_level_master` (`level_id`),
  KEY `FK_individual_document_flow_levels_flow_settings_master` (`option_id`),
  KEY `FK_individual_document_flow_levels_users` (`updated_by`),
  CONSTRAINT `FK_individual_document_flow_levels_flow_level_master` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_individual_document_flow_levels_flow_settings_master` FOREIGN KEY (`option_id`) REFERENCES `flow_settings_master` (`id`),
  CONSTRAINT `FK_individual_document_flow_levels_master` FOREIGN KEY (`master_id`) REFERENCES `individual_document_flow_master` (`id`),
  CONSTRAINT `FK_individual_document_flow_levels_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.individual_document_flow_levels: ~0 rows (approximately)
DELETE FROM `individual_document_flow_levels`;
/*!40000 ALTER TABLE `individual_document_flow_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_document_flow_levels` ENABLE KEYS */;

-- Dumping structure for table license_db.individual_document_flow_level_users
DROP TABLE IF EXISTS `individual_document_flow_level_users`;
CREATE TABLE IF NOT EXISTS `individual_document_flow_level_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flow_level_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_individual_document_flow_level_users_levels` (`flow_level_id`),
  KEY `FK_individual_document_flow_level_users_users` (`user_id`),
  CONSTRAINT `FK_individual_document_flow_level_users_levels` FOREIGN KEY (`flow_level_id`) REFERENCES `individual_document_flow_levels` (`id`),
  CONSTRAINT `FK_individual_document_flow_level_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.individual_document_flow_level_users: ~0 rows (approximately)
DELETE FROM `individual_document_flow_level_users`;
/*!40000 ALTER TABLE `individual_document_flow_level_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_document_flow_level_users` ENABLE KEYS */;

-- Dumping structure for table license_db.individual_document_flow_logs
DROP TABLE IF EXISTS `individual_document_flow_logs`;
CREATE TABLE IF NOT EXISTS `individual_document_flow_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) NOT NULL,
  `signature` longtext DEFAULT NULL,
  `status` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_individual_document_flow_logs_individual_document_flow_master` (`master_id`),
  KEY `FK_individual_document_flow_logs_individual_document_flow_levels` (`level_id`),
  KEY `FK_individual_document_flow_logs_users` (`updated_by`),
  CONSTRAINT `FK_individual_document_flow_logs_individual_document_flow_levels` FOREIGN KEY (`level_id`) REFERENCES `individual_document_flow_levels` (`id`),
  CONSTRAINT `FK_individual_document_flow_logs_individual_document_flow_master` FOREIGN KEY (`master_id`) REFERENCES `individual_document_flow_master` (`id`),
  CONSTRAINT `FK_individual_document_flow_logs_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.individual_document_flow_logs: ~0 rows (approximately)
DELETE FROM `individual_document_flow_logs`;
/*!40000 ALTER TABLE `individual_document_flow_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_document_flow_logs` ENABLE KEYS */;

-- Dumping structure for table license_db.individual_document_flow_master
DROP TABLE IF EXISTS `individual_document_flow_master`;
CREATE TABLE IF NOT EXISTS `individual_document_flow_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_id` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_individual_document_flow_master_project_version` (`version_id`),
  KEY `FK_individual_document_flow_master_permissions` (`document_type`),
  KEY `FK_individual_document_flow_master_users` (`updated_by`),
  KEY `FK_individual_document_flow_master_organization_info` (`org_id`),
  CONSTRAINT `FK_individual_document_flow_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_individual_document_flow_master_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_individual_document_flow_master_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_individual_document_flow_master_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.individual_document_flow_master: ~0 rows (approximately)
DELETE FROM `individual_document_flow_master`;
/*!40000 ALTER TABLE `individual_document_flow_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_document_flow_master` ENABLE KEYS */;

-- Dumping structure for table license_db.iqtc_files
DROP TABLE IF EXISTS `iqtc_files`;
CREATE TABLE IF NOT EXISTS `iqtc_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `iqtc_id` bigint(20) unsigned DEFAULT NULL,
  `unscripted_id` bigint(20) unsigned DEFAULT NULL,
  `iqtc_file_path` longtext DEFAULT NULL,
  `file_name` longtext DEFAULT NULL,
  `display_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_iqtc_files_iq_test_cases` (`iqtc_id`),
  KEY `FK_iqtc_files_unscripted_test_case` (`unscripted_id`),
  CONSTRAINT `FK_iqtc_files_iq_test_cases` FOREIGN KEY (`iqtc_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK_iqtc_files_unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.iqtc_files: ~0 rows (approximately)
DELETE FROM `iqtc_files`;
/*!40000 ALTER TABLE `iqtc_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `iqtc_files` ENABLE KEYS */;

-- Dumping structure for table license_db.iqtc_risk_items
DROP TABLE IF EXISTS `iqtc_risk_items`;
CREATE TABLE IF NOT EXISTS `iqtc_risk_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `risk_id` bigint(20) unsigned NOT NULL,
  `iqtc_id` bigint(20) unsigned NOT NULL,
  `failed_test_case` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_iqtc_risk_items_risk_assessment` (`risk_id`),
  KEY `FK_iqtc_risk_items_iq_test_cases` (`iqtc_id`),
  CONSTRAINT `FK_iqtc_risk_items_iq_test_cases` FOREIGN KEY (`iqtc_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK_iqtc_risk_items_risk_assessment` FOREIGN KEY (`risk_id`) REFERENCES `risk_assessment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.iqtc_risk_items: ~0 rows (approximately)
DELETE FROM `iqtc_risk_items`;
/*!40000 ALTER TABLE `iqtc_risk_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `iqtc_risk_items` ENABLE KEYS */;

-- Dumping structure for table license_db.iqtc_specification_items
DROP TABLE IF EXISTS `iqtc_specification_items`;
CREATE TABLE IF NOT EXISTS `iqtc_specification_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `testcase_id` bigint(20) unsigned NOT NULL,
  `specification_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_iqtc_specification_items_iq_test_cases` (`testcase_id`),
  KEY `FK_iqtc_specification_items_specification_master` (`specification_id`),
  CONSTRAINT `FK_iqtc_specification_items_iq_test_cases` FOREIGN KEY (`testcase_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK_iqtc_specification_items_specification_master` FOREIGN KEY (`specification_id`) REFERENCES `specification_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.iqtc_specification_items: ~0 rows (approximately)
DELETE FROM `iqtc_specification_items`;
/*!40000 ALTER TABLE `iqtc_specification_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `iqtc_specification_items` ENABLE KEYS */;

-- Dumping structure for table license_db.iqtc_urs_items
DROP TABLE IF EXISTS `iqtc_urs_items`;
CREATE TABLE IF NOT EXISTS `iqtc_urs_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `urs_id` bigint(20) unsigned NOT NULL,
  `iqtc_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__urs` (`urs_id`),
  KEY `FK__iq_test_cases` (`iqtc_id`),
  CONSTRAINT `FK__iq_test_cases` FOREIGN KEY (`iqtc_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK__urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.iqtc_urs_items: ~0 rows (approximately)
DELETE FROM `iqtc_urs_items`;
/*!40000 ALTER TABLE `iqtc_urs_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `iqtc_urs_items` ENABLE KEYS */;

-- Dumping structure for table license_db.iq_test_cases
DROP TABLE IF EXISTS `iq_test_cases`;
CREATE TABLE IF NOT EXISTS `iq_test_cases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `description` longtext NOT NULL,
  `environment` varchar(50) DEFAULT NULL,
  `expected_result` longtext DEFAULT NULL,
  `actual_result` longtext DEFAULT NULL,
  `test_case_code` varchar(50) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `deleted_flag` char(1) DEFAULT 'N',
  `test_case_type` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `pre_requisites` text DEFAULT NULL,
  `acceptance_criteria` text DEFAULT NULL,
  `revision_number` bigint(20) DEFAULT 1,
  `published` varchar(1) DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `execution_flag` varchar(1) DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `discrepancy_form` int(11) DEFAULT 0,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `master_flag` varchar(1) DEFAULT 'N',
  `test_run_id` bigint(20) unsigned DEFAULT NULL,
  `master_id` bigint(20) unsigned DEFAULT NULL,
  `executed_by` bigint(20) unsigned DEFAULT NULL,
  `executed_time` timestamp NULL DEFAULT current_timestamp(),
  `display_order` bigint(20) DEFAULT 0,
  `re_test_flag` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK_iq_test_cases_users` (`created_by`),
  KEY `FK_iq_test_cases_users_2` (`last_updated_by`),
  KEY `FK_iq_test_cases_test_case_types` (`test_case_type`),
  KEY `FK_iq_test_cases_project_version` (`version_id`),
  KEY `FK_iq_test_cases_test_run` (`test_run_id`),
  KEY `FK_iq_test_cases_users_3` (`executed_by`),
  CONSTRAINT `FK_iq_test_cases_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_iq_test_cases_test_case_types` FOREIGN KEY (`test_case_type`) REFERENCES `test_case_types` (`id`),
  CONSTRAINT `FK_iq_test_cases_test_run` FOREIGN KEY (`test_run_id`) REFERENCES `test_run` (`id`),
  CONSTRAINT `FK_iq_test_cases_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_iq_test_cases_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_iq_test_cases_users_3` FOREIGN KEY (`executed_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.iq_test_cases: ~0 rows (approximately)
DELETE FROM `iq_test_cases`;
/*!40000 ALTER TABLE `iq_test_cases` DISABLE KEYS */;
/*!40000 ALTER TABLE `iq_test_cases` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledgebase_category
DROP TABLE IF EXISTS `knowledgebase_category`;
CREATE TABLE IF NOT EXISTS `knowledgebase_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `category_name` varchar(50) NOT NULL,
  `display_order` int(11) NOT NULL,
  `active_flag` varchar(1) NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `icon` mediumtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_knowledgebase_category_organization_info` (`org_id`),
  KEY `FK_knowledgebase_category_users` (`last_updated_by`),
  CONSTRAINT `FK_knowledgebase_category_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_knowledgebase_category_users` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledgebase_category: ~0 rows (approximately)
DELETE FROM `knowledgebase_category`;
/*!40000 ALTER TABLE `knowledgebase_category` DISABLE KEYS */;
INSERT INTO `knowledgebase_category` (`id`, `org_id`, `category_name`, `display_order`, `active_flag`, `last_updated_by`, `last_updated_time`, `icon`) VALUES
	(1, NULL, 'Category1', 1, 'Y', 1, '2022-01-04 06:49:53', NULL);
/*!40000 ALTER TABLE `knowledgebase_category` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledgebase_content
DROP TABLE IF EXISTS `knowledgebase_content`;
CREATE TABLE IF NOT EXISTS `knowledgebase_content` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sub_category_id` bigint(20) unsigned NOT NULL,
  `content` longtext NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `file_path` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_knowledgebase_content_knowledgebase_subcategory` (`sub_category_id`),
  KEY `FK_knowledgebase_content_users` (`last_updated_by`),
  CONSTRAINT `FK_knowledgebase_content_knowledgebase_subcategory` FOREIGN KEY (`sub_category_id`) REFERENCES `knowledgebase_sub_category` (`id`),
  CONSTRAINT `FK_knowledgebase_content_users` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledgebase_content: ~0 rows (approximately)
DELETE FROM `knowledgebase_content`;
/*!40000 ALTER TABLE `knowledgebase_content` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledgebase_content` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledgebase_content_for_modules
DROP TABLE IF EXISTS `knowledgebase_content_for_modules`;
CREATE TABLE IF NOT EXISTS `knowledgebase_content_for_modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `knowledgebase_content_id` bigint(20) unsigned NOT NULL,
  `permission_constant_name` varchar(50) NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_knowledgebase_content_for_modules_knowledgebase_content` (`knowledgebase_content_id`),
  KEY `FK_knowledgebase_content_for_modules_permissions` (`permission_constant_name`),
  KEY `FK_knowledgebase_content_for_modules_users` (`last_updated_by`),
  CONSTRAINT `FK_knowledgebase_content_for_modules_knowledgebase_content` FOREIGN KEY (`knowledgebase_content_id`) REFERENCES `knowledgebase_content` (`id`),
  CONSTRAINT `FK_knowledgebase_content_for_modules_permissions` FOREIGN KEY (`permission_constant_name`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_knowledgebase_content_for_modules_users` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledgebase_content_for_modules: ~0 rows (approximately)
DELETE FROM `knowledgebase_content_for_modules`;
/*!40000 ALTER TABLE `knowledgebase_content_for_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledgebase_content_for_modules` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledgebase_files
DROP TABLE IF EXISTS `knowledgebase_files`;
CREATE TABLE IF NOT EXISTS `knowledgebase_files` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sub_category_id` bigint(20) unsigned NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_knowledgebase_files_knowledgebase_subcategory` (`sub_category_id`),
  KEY `FK_knowledgebase_files_users` (`last_updated_by`),
  CONSTRAINT `FK_knowledgebase_files_knowledgebase_subcategory` FOREIGN KEY (`sub_category_id`) REFERENCES `knowledgebase_sub_category` (`id`),
  CONSTRAINT `FK_knowledgebase_files_users` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledgebase_files: ~0 rows (approximately)
DELETE FROM `knowledgebase_files`;
/*!40000 ALTER TABLE `knowledgebase_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `knowledgebase_files` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledgebase_sub_category
DROP TABLE IF EXISTS `knowledgebase_sub_category`;
CREATE TABLE IF NOT EXISTS `knowledgebase_sub_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `sub_category_name` varchar(50) NOT NULL,
  `display_order` smallint(6) NOT NULL,
  `active_flag` varchar(1) NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK__knowledgebase_category` (`category_id`),
  KEY `FK_knowledgebase_sub_category_users` (`last_updated_by`),
  CONSTRAINT `FK__knowledgebase_category` FOREIGN KEY (`category_id`) REFERENCES `knowledgebase_category` (`id`),
  CONSTRAINT `FK_knowledgebase_sub_category_users` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledgebase_sub_category: ~0 rows (approximately)
DELETE FROM `knowledgebase_sub_category`;
/*!40000 ALTER TABLE `knowledgebase_sub_category` DISABLE KEYS */;
INSERT INTO `knowledgebase_sub_category` (`id`, `category_id`, `sub_category_name`, `display_order`, `active_flag`, `last_updated_by`, `last_updated_time`) VALUES
	(1, 1, 'Sub Category 1', 1, 'Y', 1, '2022-01-04 06:50:10');
/*!40000 ALTER TABLE `knowledgebase_sub_category` ENABLE KEYS */;

-- Dumping structure for table license_db.knowledge_base_update_log
DROP TABLE IF EXISTS `knowledge_base_update_log`;
CREATE TABLE IF NOT EXISTS `knowledge_base_update_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `orgId` bigint(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.knowledge_base_update_log: 20 rows
DELETE FROM `knowledge_base_update_log`;
/*!40000 ALTER TABLE `knowledge_base_update_log` DISABLE KEYS */;
INSERT INTO `knowledge_base_update_log` (`id`, `orgId`, `status`) VALUES
	(1, 1, 'update'),
	(2, 16, 'update'),
	(3, 17, 'update'),
	(4, 18, 'update'),
	(5, 19, 'update'),
	(6, 20, 'update'),
	(7, 21, 'update'),
	(8, 22, 'update'),
	(9, 23, 'update'),
	(10, 24, 'update'),
	(11, 25, 'update'),
	(12, 26, 'update'),
	(13, 27, 'update'),
	(14, 28, 'update'),
	(15, 29, 'update'),
	(16, 30, 'update'),
	(17, 31, 'update'),
	(18, 32, 'update'),
	(19, 33, 'update'),
	(20, 34, 'update');
/*!40000 ALTER TABLE `knowledge_base_update_log` ENABLE KEYS */;

-- Dumping structure for table license_db.ldap_settings_info
DROP TABLE IF EXISTS `ldap_settings_info`;
CREATE TABLE IF NOT EXISTS `ldap_settings_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `host_name` varchar(50) DEFAULT NULL,
  `client_user_name` varchar(100) DEFAULT '',
  `client_password` varchar(100) DEFAULT '',
  `tenant_id` varchar(200) DEFAULT '',
  `client_id` varchar(200) DEFAULT '',
  `client_secret_id` varchar(200) DEFAULT '',
  `created_time` timestamp NULL DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_ldap_settings_info_organization_info` (`org_id`) USING BTREE,
  KEY `FK_ldap_settings_info_users` (`created_by`) USING BTREE,
  KEY `FK_ldap_settings_info_users_2` (`updated_by`) USING BTREE,
  CONSTRAINT `FK_ldap_settings_info_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_ldap_settings_info_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_ldap_settings_info_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.ldap_settings_info: ~0 rows (approximately)
DELETE FROM `ldap_settings_info`;
/*!40000 ALTER TABLE `ldap_settings_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `ldap_settings_info` ENABLE KEYS */;

-- Dumping structure for table license_db.levels_for_dynamic_form_work_flow
DROP TABLE IF EXISTS `levels_for_dynamic_form_work_flow`;
CREATE TABLE IF NOT EXISTS `levels_for_dynamic_form_work_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_form_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_levels_for_dynamic_form_work_flow_work_flow_levels` (`level_id`),
  KEY `FK_levels_for_dynamic_form_work_flow_dynamic_form` (`dynamic_form_id`),
  CONSTRAINT `FK_levels_for_dynamic_form_work_flow_dynamic_form` FOREIGN KEY (`dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FKc148xa0tg09gc1kuc7bwah4oa` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.levels_for_dynamic_form_work_flow: ~0 rows (approximately)
DELETE FROM `levels_for_dynamic_form_work_flow`;
/*!40000 ALTER TABLE `levels_for_dynamic_form_work_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `levels_for_dynamic_form_work_flow` ENABLE KEYS */;

-- Dumping structure for table license_db.levels_for_dynamic_template_work_flow
DROP TABLE IF EXISTS `levels_for_dynamic_template_work_flow`;
CREATE TABLE IF NOT EXISTS `levels_for_dynamic_template_work_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_template_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_levels_for_dynamic_template_work_flow_work_flow_levels` (`level_id`),
  KEY `FK_levels_for_dynamic_template_work_flow_dynamic_template` (`dynamic_template_id`),
  CONSTRAINT `FK4nvaggnv9gguooanfklj0326r` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_levels_for_dynamic_template_work_flow_dynamic_template` FOREIGN KEY (`dynamic_template_id`) REFERENCES `master_dynamic_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.levels_for_dynamic_template_work_flow: ~0 rows (approximately)
DELETE FROM `levels_for_dynamic_template_work_flow`;
/*!40000 ALTER TABLE `levels_for_dynamic_template_work_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `levels_for_dynamic_template_work_flow` ENABLE KEYS */;

-- Dumping structure for table license_db.location
DROP TABLE IF EXISTS `location`;
CREATE TABLE IF NOT EXISTS `location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `active` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `current_serialvalue` int(11) DEFAULT NULL,
  `disable_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_location_users` (`updated_by`),
  KEY `FK_location_organization_info` (`org_id`),
  CONSTRAINT `FK_location_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_location_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.location: ~0 rows (approximately)
DELETE FROM `location`;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;

-- Dumping structure for table license_db.location_step
DROP TABLE IF EXISTS `location_step`;
CREATE TABLE IF NOT EXISTS `location_step` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` bigint(20) unsigned NOT NULL,
  `step` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_for_location_id_1` (`location_id`),
  CONSTRAINT `FK1_for_location_id_1` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.location_step: ~0 rows (approximately)
DELETE FROM `location_step`;
/*!40000 ALTER TABLE `location_step` DISABLE KEYS */;
/*!40000 ALTER TABLE `location_step` ENABLE KEYS */;

-- Dumping structure for table license_db.lock_document_log
DROP TABLE IF EXISTS `lock_document_log`;
CREATE TABLE IF NOT EXISTS `lock_document_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `flag` char(1) NOT NULL DEFAULT 'N',
  `document_master` bigint(20) unsigned NOT NULL,
  `comments` varchar(100) NOT NULL,
  `revision_number` varchar(50) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL DEFAULT 0,
  `created_time` timestamp NULL DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT 0,
  `approval_time` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_freeze_document_log_flow_document_master` (`document_master`),
  KEY `FK_freeze_document_log_users` (`created_by`),
  CONSTRAINT `FK_freeze_document_log_flow_document_master` FOREIGN KEY (`document_master`) REFERENCES `flow_document_master` (`id`),
  CONSTRAINT `FK_freeze_document_log_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.lock_document_log: ~0 rows (approximately)
DELETE FROM `lock_document_log`;
/*!40000 ALTER TABLE `lock_document_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `lock_document_log` ENABLE KEYS */;

-- Dumping structure for table license_db.lookup_category
DROP TABLE IF EXISTS `lookup_category`;
CREATE TABLE IF NOT EXISTS `lookup_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp(),
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `developer_mode` varchar(1) DEFAULT NULL,
  `organization_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_lookup_category_users` (`created_by`),
  KEY `FK_lookup_category_users_2` (`last_updated_by`),
  CONSTRAINT `FK_lookup_category_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_lookup_category_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table license_db.lookup_category: ~69 rows (approximately)
DELETE FROM `lookup_category`;
/*!40000 ALTER TABLE `lookup_category` DISABLE KEYS */;
INSERT INTO `lookup_category` (`id`, `name`, `description`, `created_time`, `last_updated_time`, `created_by`, `last_updated_by`, `developer_mode`, `organization_id`) VALUES
	(1, 'testingDemo', 'Demo', '2018-08-25 17:01:48', '2018-08-25 17:01:48', 1, 1, NULL, NULL),
	(2, 'documentList', 'documentList', '2018-08-28 18:55:45', '2018-08-28 18:55:46', 1, 1, NULL, NULL),
	(3, 'roles', 'roles', '2018-08-28 18:56:15', '2018-08-28 18:56:16', 1, 1, NULL, NULL),
	(7, 'documentStatus', 'documentStatus', '2018-09-07 20:25:21', '2018-09-07 20:25:22', 1, 1, NULL, NULL),
	(9, 'URSFeilds', 'values', '2018-09-21 11:17:50', '2018-09-21 11:17:51', 1, 1, NULL, NULL),
	(10, 'TestCasesFeilds', 'values', '2018-09-21 11:18:24', '2018-09-21 05:48:55', 1, 1, NULL, NULL),
	(11, 'RiskAssessmentFeilds', 'values', '2018-09-21 06:18:23', '2018-09-21 06:22:42', 1, 1, NULL, NULL),
	(14, 'DynamicDocumentList', 'DynamicDocumentList', '2019-08-21 13:26:46', '2019-08-21 13:26:46', 1, 1, 'N', 2),
	(15, 'workFlowLevels', 'Work Flow Levels', '2019-09-04 12:39:16', '2019-09-04 12:39:16', 1, 1, 'N', 2),
	(16, 'gampCategory', 'Gamp Categrory', '2019-09-06 14:41:31', '2020-04-21 13:56:32', 1, 1, 'N', NULL),
	(18, 'Occurrences', 'Occurrences', '2019-09-25 10:36:00', '2019-09-25 10:36:00', 1, 1, 'N', 2),
	(20, 'gampCategory', 'Gamp Categrory', '2019-09-06 14:41:31', '2019-10-09 14:15:56', 1, 1, 'N', 10),
	(21, 'discrepancyForm', 'Discrepancy Form', '2019-10-10 04:52:42', '2019-10-10 04:52:42', 1, 1, NULL, NULL),
	(22, 'orgDocumentList', 'orgDocumentList', '2019-10-15 15:10:39', '2019-10-15 15:10:40', 1, 1, NULL, NULL),
	(23, 'batchCreationStatus', 'BatchCreationStatus', '2019-10-22 11:13:52', '2019-10-22 11:13:53', 1, 1, NULL, NULL),
	(24, 'EquipmentStatus', 'Equipment Status', '2019-10-15 15:10:39', '2019-10-15 15:10:40', 1, 1, NULL, NULL),
	(25, 'deviceMaster', 'deviceMaster', '2019-12-03 10:29:26', '2019-12-03 10:29:26', 1, 1, NULL, NULL),
	(30, 'UserSuggestions', 'this is for template builder', '2019-12-03 16:03:07', '2019-12-03 16:03:08', 1, 1, NULL, NULL),
	(31, 'ProjectAndDocumentSuggestions', 'this is for template builder', '2019-12-03 16:48:01', '2019-12-03 16:48:02', 1, 1, NULL, NULL),
	(33, 'frequency', 'Frequency of rule scheduling', '2019-10-22 11:13:52', '2019-10-22 11:13:53', 1, 1, NULL, NULL),
	(34, 'actionType', 'Action Type in Rule', '2019-10-22 11:13:52', '2019-10-22 11:13:53', 1, 1, NULL, NULL),
	(35, 'operatingSystem', 'operatingSystem', '2019-12-04 14:18:13', '2019-12-04 14:18:14', 1, 1, NULL, NULL),
	(36, 'DateFormats', 'Date Formats', '2019-10-15 15:10:39', '2019-10-15 15:10:40', 1, 1, NULL, NULL),
	(37, 'LocationStep', 'Location Step', '2019-12-05 12:28:56', '2019-12-05 12:28:57', 1, 1, NULL, NULL),
	(38, 'projectSettings', 'template builder settings tab', '2019-12-09 17:14:15', '2019-12-09 17:14:16', 1, 1, NULL, NULL),
	(39, 'dueDateFrequency', 'Due Date Frequency of Equipment ', '2019-12-23 14:55:04', '2020-04-21 17:59:11', 1, 1, 'N', NULL),
	(41, 'TaskPrioirty', 'Task Priority', '2019-12-09 17:14:15', '2020-01-23 10:18:19', 1, 1, NULL, NULL),
	(42, 'TaskStatus', 'Task Status', '2019-12-09 17:14:15', '2020-01-23 10:18:23', 1, 1, NULL, NULL),
	(43, 'EquipmentSuggestion', 'this is for template builder', '2020-04-07 15:03:04', '2020-04-10 07:29:25', 1, 1, NULL, NULL),
	(44, 'CCFStatus', 'CCFStatus', '2020-04-07 15:03:04', '2020-04-07 15:03:04', 1, 1, NULL, NULL),
	(45, 'CCFTypes', 'CCFtypes', '2020-04-10 09:53:12', '2020-04-10 07:29:21', 1, 1, 'Y', NULL),
	(47, 'TaskCategory', 'TaskCategory', '2020-05-29 08:03:17', '2020-05-29 08:03:17', 1, 1, NULL, NULL),
	(49, 'TaskReportStatus', 'TaskReportStatus', '2020-06-25 12:52:07', '2020-06-25 12:52:08', 1, 1, NULL, NULL),
	(50, 'mmmmoderncompany', 'Desc', '2020-06-30 08:32:43', '2020-06-30 08:32:43', 1, 1, 'N', 77),
	(51, 'APIConfigDataTypes', 'API Config DataTypes', '2020-06-25 12:52:07', '2020-06-25 12:52:08', 1, 1, NULL, NULL),
	(52, 'APIConfigFrequency', 'API Config Frequency', '2020-06-25 12:52:07', '2020-06-25 12:52:08', 1, 1, NULL, NULL),
	(53, 'Environment', 'Environment for project', '2020-07-20 10:22:33', '2020-07-20 10:22:34', 1, 1, NULL, NULL),
	(54, 'ProjectType', 'Project Type', '2020-07-20 10:22:33', '2020-07-20 10:22:34', 1, 1, NULL, NULL),
	(55, 'ProjectApplicability', 'Project Applicability', '2020-07-20 10:22:33', '2020-07-20 10:22:34', 1, 1, NULL, NULL),
	(56, 'ProjectSystem', 'Project System', '2020-07-20 10:22:33', '2020-07-20 10:22:34', 1, 1, NULL, NULL),
	(57, 'defaultPDFVariable', 'Default Pdf Variables', '2020-07-28 08:07:40', '2020-07-28 08:08:16', 1, 1, 'Y', NULL),
	(60, 'APITemparatureLabels', 'API Temparature Labels', '2020-07-28 08:07:40', '2020-08-20 19:32:06', 1, 1, '', NULL),
	(61, 'APIHumidityLabels', 'API Humidity Labels', '2020-07-28 08:07:40', '2020-08-20 19:32:06', 1, 1, '', NULL),
	(62, 'APIBeeLabels', 'API Bee Labels', '2020-07-28 08:07:40', '2020-08-20 19:32:06', 1, 1, '', NULL),
	(63, 'APIMappingFormLabels', 'API Mapping Form Labels', '2020-07-28 08:07:40', '2020-08-20 19:32:06', 1, 1, '', NULL),
	(64, 'APIMappingFormPDFHeader', 'API Mapping Form PDF Header', '2020-07-28 08:07:40', '2020-08-20 19:32:06', 1, 1, '', NULL),
	(65, 'APIMappingFormDates', 'API Mapping Form Dates', '2020-07-28 08:07:40', '2020-08-28 08:06:01', 1, 1, '', NULL),
	(66, 'SpecificationMaster', 'SpecificationMaster', '2020-08-31 11:41:35', '2020-08-31 11:41:35', 1, 1, NULL, NULL),
	(67, 'APIMappingFormTimeZone', 'API Mapping Form Time Zone', '2020-07-28 08:07:40', '2020-08-28 08:06:01', 1, 1, '', NULL),
	(68, 'APIMappingFormIntervalTime', 'API Mapping Form Interval Time', '2020-07-28 08:07:40', '2020-08-28 08:06:01', 1, 1, '', NULL),
	(69, 'WatermarkDropdown', 'Watermark Dropdown', '2020-12-01 09:17:02', '2020-12-07 07:07:51', 1, 1, 'N', NULL),
	(70, 'IssueCategory', 'Issue Category', '2021-01-12 23:55:41', '2021-01-12 23:55:41', 1, 1, 'N', NULL),
	(71, 'gampmatrixconclusion', 'GAMP Matrix Conclusion', '2021-03-03 19:23:48', '2021-03-03 19:24:25', 1, 1, 'Y', NULL),
	(72, 'projectSetupValidationStatus', 'Validation Status', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(73, 'projectSetupSystemStatus', 'System Status', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(74, 'projectSetupHostingType', 'Hosting Type', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(75, 'URSPotentialRisk', 'URS Potential Risk', '2020-10-15 21:39:45', '2021-05-06 10:38:14', 1, 1, 'Y', NULL),
	(76, 'URSImplementationMethod', 'URS Implementation Method', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(77, 'URSTestingMethod', 'URS Testing Method', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(78, 'equipmentCategory', 'Equipment Category', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(79, 'qualificationStatus', 'Qualification Status', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(80, 'gxpRelevanceStatus', 'GxP Relevance Status', '2020-10-15 21:39:45', '2021-05-06 10:38:14', 1, 1, 'Y', NULL),
	(81, 'testingType', 'Testing Type', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(82, 'ProjectSetupType', 'Project Setup Type', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(83, 'cleanroomClassification', 'Cleanroom Classification', '2020-10-15 21:39:45', '2020-10-15 21:40:32', 1, 1, 'Y', NULL),
	(84, 'complianceCategory', 'Compliance Category', '2021-11-19 09:53:46', '2021-11-19 09:53:46', 1, 1, 'Y', NULL),
	(85, 'years', 'Years', '2021-11-19 09:53:46', '2021-11-19 09:53:46', 1, 1, 'Y', NULL),
	(86, 'complianceReportResponse', 'compliance Report Response', '2021-11-19 09:53:46', '2021-11-19 09:53:46', 1, 1, 'Y', NULL),
	(87, 'SaaSInstallationPlans', 'SaaS Installation Plans', '2021-11-19 09:53:46', '2021-11-19 09:53:46', 1, 1, 'Y', NULL);
/*!40000 ALTER TABLE `lookup_category` ENABLE KEYS */;

-- Dumping structure for table license_db.lookup_item
DROP TABLE IF EXISTS `lookup_item`;
CREATE TABLE IF NOT EXISTS `lookup_item` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `key` varchar(100) NOT NULL,
  `value` varchar(200) DEFAULT NULL,
  `display_order` smallint(5) unsigned DEFAULT NULL,
  `active_flag` varchar(50) NOT NULL DEFAULT 'Y',
  `created_time` timestamp NULL DEFAULT current_timestamp(),
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_id_key` (`category_id`,`key`),
  UNIQUE KEY `UKohflicommxc15typ9wxbh4d7c` (`category_id`,`key`),
  KEY `FK_lookup_item_users` (`created_by`),
  KEY `FK_lookup_item_users_2` (`last_updated_by`),
  KEY `FK_lookup_item_organization_info` (`organization_id`),
  CONSTRAINT `FK_lookup_item_lookup_category` FOREIGN KEY (`category_id`) REFERENCES `lookup_category` (`id`),
  CONSTRAINT `FK_lookup_item_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_lookup_item_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_lookup_item_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table license_db.lookup_item: ~349 rows (approximately)
DELETE FROM `lookup_item`;
/*!40000 ALTER TABLE `lookup_item` DISABLE KEYS */;
INSERT INTO `lookup_item` (`id`, `category_id`, `key`, `value`, `display_order`, `active_flag`, `created_time`, `last_updated_time`, `created_by`, `last_updated_by`, `organization_id`) VALUES
	(1, 1, 'testing', 'test', 1, 'Y', '2018-08-25 17:02:07', '2018-09-21 19:03:41', 1, 1, NULL),
	(2, 3, '1', 'Super Admin', 1, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(3, 3, '2', 'Reviewer', 2, 'Y', '2018-08-29 11:45:36', '2018-08-29 11:45:36', 1, 1, NULL),
	(4, 3, '3', 'Approver', 3, 'Y', '2018-08-29 11:45:51', '2018-08-29 11:45:51', 1, 1, NULL),
	(5, 2, '107', 'User Requirement Specification', 1, 'Y', '2018-08-29 11:46:00', '2018-09-04 18:14:52', 1, 1, NULL),
	(6, 3, '7', 'Creator', 4, 'Y', '2018-08-29 11:46:02', '2018-09-07 14:32:51', 1, 1, NULL),
	(7, 2, '116', 'Project Plan', 3, 'N', '2018-08-29 11:46:47', '2018-09-27 12:12:02', 1, 1, NULL),
	(8, 2, '115', 'Validation Master Plan', 2, 'N', '2018-08-29 11:47:37', '2018-09-07 16:53:14', 1, 1, NULL),
	(9, 2, '117', 'Design Qualification', 4, 'N', '2018-08-29 11:49:06', '2018-09-27 12:12:06', 1, 1, NULL),
	(10, 3, '5', 'Admin', 5, 'Y', '2018-08-29 12:16:30', '2018-08-29 12:16:30', 1, 1, NULL),
	(11, 2, '108', 'IQTC', 8, 'Y', '2018-09-07 16:52:57', '2018-09-07 16:55:02', 1, 1, NULL),
	(12, 2, '109', 'PQTC', 3, 'Y', '2018-09-07 16:53:51', '2021-01-26 01:24:06', 1, 1, NULL),
	(13, 2, '110', 'OQTC', 3, 'Y', '2018-09-07 16:54:06', '2021-01-26 01:24:05', 1, 1, NULL),
	(14, 2, '126', 'Document Status', 9, 'N', '2018-09-07 20:15:50', '2018-09-27 12:12:15', 1, 1, NULL),
	(15, 7, '1', 'Review Pending', 1, 'Y', '2018-09-07 20:26:14', '2018-09-07 20:26:15', 1, 1, NULL),
	(16, 7, '2', 'Review Compeleted/Approve Pending', 2, 'Y', '2018-09-07 20:27:00', '2018-09-07 20:27:00', 1, 1, NULL),
	(17, 7, '3', 'Approved', 3, 'Y', '2018-09-07 20:27:46', '2018-09-07 20:27:47', 1, 1, NULL),
	(18, 7, '4', 'Rejected', 4, 'Y', '2018-09-07 20:28:43', '2018-09-07 20:28:44', 1, 1, NULL),
	(19, 7, '5', 'Rejected By Reviewer ', 5, 'Y', '2018-09-07 20:29:15', '2018-09-07 20:29:15', 1, 1, NULL),
	(20, 10, 'testCase-1', 'Test description', 1, 'Y', '2018-09-21 11:13:51', '2018-09-21 11:13:52', 1, 1, NULL),
	(21, 10, 'testCase-2', 'URS', 2, 'Y', '2018-09-21 11:21:41', '2018-09-21 11:21:42', 1, 1, NULL),
	(22, 10, 'testCase-3', 'Expected Result', 3, 'Y', '2018-09-21 11:21:41', '2018-09-21 05:55:34', 1, 1, NULL),
	(23, 10, 'testCase-4', 'Actual Result', 4, 'Y', '2018-09-21 11:21:41', '2018-09-21 05:55:45', 1, 1, NULL),
	(24, 10, 'testCase-5', 'Status', 5, 'Y', '2018-09-21 11:21:41', '2018-09-21 05:55:49', 1, 1, NULL),
	(25, 10, 'testCase-6', 'Upload Images', 6, 'Y', '2018-09-21 11:21:41', '2018-09-21 05:55:52', 1, 1, NULL),
	(26, 11, 'riskAssess-1', 'Risk Factor', 1, 'Y', '2018-09-21 12:14:54', '2018-09-21 12:14:55', 1, 1, NULL),
	(27, 11, 'riskAssess-2', 'Risk scenario', 2, 'Y', '2018-09-21 06:46:55', '2018-09-21 06:46:55', 1, 1, NULL),
	(28, 11, 'riskAssess-3', 'URS', 3, 'Y', '2018-09-21 06:47:14', '2018-09-21 06:47:14', 1, 1, NULL),
	(29, 11, 'riskAssess-4', 'Probable Cause Of Risk', 4, 'Y', '2018-09-21 06:47:34', '2018-09-21 06:47:34', 1, 1, NULL),
	(30, 11, 'riskAssess-5', 'Proposed Mitigation', 5, 'Y', '2018-09-21 06:47:51', '2018-09-21 06:47:51', 1, 1, NULL),
	(31, 11, 'riskAssess-6', 'Severity', 6, 'Y', '2018-09-21 06:48:12', '2018-09-21 06:48:12', 1, 1, NULL),
	(32, 11, 'riskAssess-8', 'Detectability', 8, 'Y', '2018-09-21 06:49:04', '2018-09-21 06:49:04', 1, 1, NULL),
	(33, 11, 'riskAssess-9', 'Priority', 9, 'Y', '2018-09-21 06:49:28', '2018-09-21 06:49:28', 1, 1, NULL),
	(34, 9, 'urs-1', 'User Requirement Specifications', 1, 'Y', '2018-09-21 19:51:17', '2018-09-21 19:51:18', 1, 1, NULL),
	(35, 9, 'urs-2', 'Description', 2, 'Y', '2018-09-21 19:51:59', '2018-09-21 19:52:00', 1, 1, NULL),
	(36, 9, 'urs-3', 'Category', 3, 'Y', '2018-09-21 19:52:38', '2018-09-21 19:52:39', 1, 1, NULL),
	(37, 9, 'urs-4', 'Priority', 4, 'Y', '2018-09-21 19:53:15', '2018-09-21 19:53:16', 1, 1, NULL),
	(38, 2, '113', 'Risk assessment', 11, 'Y', '2018-09-22 12:21:46', '2018-09-22 12:21:46', 1, 1, NULL),
	(39, 2, '128', 'Vendor Validation', 12, 'Y', '2018-10-03 11:59:12', '2018-10-03 12:03:53', 1, 1, NULL),
	(40, 15, '101', 'Level-1', 1, 'Y', '2019-09-04 12:42:42', '2019-09-04 12:43:43', 1, 1, NULL),
	(41, 15, '102', 'Level-2', 2, 'Y', '2019-09-04 12:43:08', '2019-09-04 12:43:37', 1, 1, NULL),
	(42, 15, '103', 'Level-3', 3, 'Y', '2019-09-04 12:44:09', '2019-09-04 12:44:09', 1, 1, NULL),
	(43, 15, '104', 'Level-4', 4, 'Y', '2019-09-04 12:44:24', '2019-09-04 12:44:24', 1, 1, NULL),
	(44, 15, '105', 'Level-5', 5, 'Y', '2019-09-04 12:44:40', '2019-09-04 12:44:40', 1, 1, NULL),
	(45, 15, 'asdsa', 'adasd', 1, 'Y', '2019-09-04 15:13:38', '2019-09-04 15:13:38', 1, 1, NULL),
	(46, 16, '1', 'Category : Operating System | Action : Record version', 1, 'Y', '2019-09-06 14:42:14', '2020-05-06 02:59:08', 1, 1, NULL),
	(48, 16, '3', 'Category : Configurable Packages | Action : Audit Supplier and Validate', 3, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(49, 16, '4', 'Category : Systems where the codes | Action : Audit Supplier and Code', 4, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(50, 16, '5', 'Category : Systems using custom or bespoke code | Action : Audit Supplier and validate all code', 5, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(51, 14, '130', 'testing', 1, 'N', '2019-09-09 11:13:31', '2019-09-26 15:37:19', 1, 1, NULL),
	(52, 14, '131', 'testing Data', 2, 'Y', '2019-09-10 15:31:45', '2019-09-10 15:52:18', 1, 1, NULL),
	(53, 14, '132', 'adsasdasdsad', 3, 'Y', '2019-09-10 15:56:31', '2019-09-10 15:56:31', 1, 1, NULL),
	(54, 14, '133', 'dsadsadsad', 4, 'Y', '2019-09-10 15:58:44', '2019-09-10 15:58:44', 1, 1, NULL),
	(55, 14, '134', 'asdsada', 5, 'Y', '2019-09-10 15:59:10', '2019-09-10 15:59:10', 1, 1, NULL),
	(56, 18, '1', 'High', 1, 'N', '2019-09-25 10:36:25', '2019-09-26 15:11:30', 1, 1, NULL),
	(57, 18, '2', 'Medium', 2, 'N', '2019-09-25 10:39:10', '2019-09-26 15:11:33', 1, 1, NULL),
	(58, 18, '3', 'Low', 3, 'N', '2019-09-25 10:39:23', '2019-09-26 15:11:35', 1, 1, NULL),
	(59, 14, 'asdsa', 'asdsa', 1, 'Y', '2019-09-26 15:11:02', '2019-09-26 15:11:02', 1, 1, NULL),
	(60, 20, '1', 'Category : Opeaing System | Action : Record version', 1, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(61, 20, '2', 'Category : Instruments and Controllers | Action : Record Configuration ', 2, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(62, 20, '3', 'Category : Configurable Packages | Action : Audit Supplier and Validate', 3, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(63, 20, '4', 'Category : Systems where the codes | Action : Audit Supplier and Code', 4, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(64, 20, '5', 'Category : Systems using custom or bespoke code | Action : Audit Supplier and validate all code', 5, 'Y', '2019-09-06 14:42:14', '2019-09-06 14:42:14', 1, 1, NULL),
	(65, 21, '1', 'Resolved', 1, 'Y', '2019-10-10 04:53:44', '2019-10-10 04:53:44', 1, 1, NULL),
	(66, 21, '2', 'Pending', 2, 'Y', '2019-10-10 04:53:44', '2019-10-10 04:53:44', 1, 1, NULL),
	(67, 21, '3', 'Hold', 3, 'Y', '2019-10-10 04:53:44', '2019-10-10 04:53:44', 1, 1, NULL),
	(68, 21, '4', 'N.A', 4, 'Y', '2019-10-10 04:53:44', '2019-10-10 04:53:44', 1, 1, NULL),
	(69, 22, '113', 'Risk assessment', 5, 'Y', '2018-09-22 12:21:46', '2019-10-15 09:42:06', 1, 1, NULL),
	(70, 22, '108', 'IQTC', 2, 'Y', '2018-09-22 12:21:46', '2019-10-15 09:41:58', 1, 1, NULL),
	(71, 22, '109', 'PQTC', 3, 'Y', '2018-09-22 12:21:46', '2019-10-15 09:42:01', 1, 1, NULL),
	(72, 22, '110', 'OQTC', 3, 'Y', '2018-09-22 12:21:46', '2021-01-26 01:24:05', 1, 1, NULL),
	(73, 22, '107', 'User Requirement Specification', 1, 'Y', '2018-09-22 12:21:46', '2019-10-15 09:41:54', 1, 1, NULL),
	(74, 22, '128', 'Vendor Documents', 6, 'Y', '2019-10-15 15:13:04', '2021-06-21 05:19:29', 1, 1, NULL),
	(75, 22, '139', 'Forms', 8, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(76, 22, '138', 'Templates', 7, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(77, 22, '140', 'Location', 8, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(78, 22, '141', 'Equipment', 9, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(79, 22, '142', 'Facility', 10, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(80, 22, '143', 'ShiftMaster', 11, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(81, 23, 'Created', 'Created', 1, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:14:45', 1, 1, NULL),
	(82, 23, 'Review', 'Review', 2, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:14:49', 1, 1, NULL),
	(83, 23, 'Approved', 'Approved', 3, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:14:53', 1, 1, NULL),
	(84, 23, 'In Progress', 'In Progress', 4, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:14:57', 1, 1, NULL),
	(85, 23, 'Completed', 'Completed', 5, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:14:59', 1, 1, NULL),
	(86, 23, 'On Hold', 'On Hold', 6, 'Y', '2019-10-22 11:16:33', '2019-10-22 08:15:02', 1, 1, NULL),
	(87, 24, 'ToBeCleaned', 'To be cleaned', 2, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:16', 1, 1, NULL),
	(88, 24, 'CleaningInProgress', 'Cleaning in Progress', 3, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:07', 1, 1, NULL),
	(89, 24, 'CleanedAndReadyForUse', 'Cleaned and ready for use', 4, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:05', 1, 1, NULL),
	(90, 24, 'InUse', 'IN USE', 1, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:01', 1, 1, NULL),
	(91, 2, '137', 'VSR', 13, 'Y', '2018-09-07 16:52:57', '2018-09-07 16:55:02', 1, 1, NULL),
	(92, 25, 'BarcodePrinter', 'BarcodePrinter', 3, 'Y', '2019-12-03 10:29:38', '2019-12-03 10:29:38', 1, 1, NULL),
	(93, 25, 'Thin Client', 'Thin Client', 1, 'Y', '2019-12-03 10:29:38', '2019-12-03 10:29:38', 1, 1, NULL),
	(94, 25, 'HHT', 'HHT', 2, 'Y', '2019-12-03 10:29:38', '2019-12-03 10:29:38', 1, 1, NULL),
	(95, 25, 'Scanner', 'Scanner', 4, 'Y', '2019-12-03 10:29:38', '2019-12-03 10:29:38', 1, 1, NULL),
	(96, 25, 'Others ', 'Others ', 5, 'Y', '2019-12-03 10:29:38', '2019-12-03 10:29:38', 1, 1, NULL),
	(97, 33, 'daily', 'Daily', 1, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(98, 33, 'weekly', 'Weekly', 2, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(99, 33, 'monthly', 'Monthly', 3, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(100, 33, 'twiceInWeek', 'Twice in a week', 4, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(101, 33, 'twiceInMonth', 'Twice in a month', 5, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(102, 34, 'created', 'On Create', 1, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(103, 34, 'updated', 'On Update', 2, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(104, 34, 'deleted', 'On Delete', 3, 'Y', '2018-08-28 23:19:41', '2018-08-29 11:45:17', 1, 1, NULL),
	(105, 34, 'approve', 'On Approve', 4, 'Y', '2018-08-28 23:19:41', '2020-04-14 07:22:52', 1, 1, NULL),
	(108, 35, 'Windows', 'Windows ', 1, 'Y', '2019-12-03 15:52:29', '2019-12-03 15:52:29', 1, 1, NULL),
	(109, 35, 'Android', 'Android', 2, 'Y', '2019-12-03 15:52:29', '2019-12-03 15:52:29', 1, 1, NULL),
	(110, 35, 'IOS', 'IOS', 3, 'Y', '2019-12-03 15:52:29', '2019-12-03 15:52:29', 1, 1, NULL),
	(111, 36, '1', 'dd-MM-yyyy hh:mm:ss z', 1, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:01', 1, 1, NULL),
	(112, 36, '2', 'dd-MM-yyyy hh:mm:ss', 1, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:01', 1, 1, NULL),
	(113, 36, '3', 'MM-dd-yyyy', 1, 'Y', '2019-10-15 15:13:04', '2019-10-30 05:44:01', 1, 1, NULL),
	(115, 37, 'Stage 1', 'Stage 1', 1, 'Y', '2019-12-05 12:32:54', '2019-12-05 12:32:56', 1, 1, NULL),
	(116, 37, 'Stage 2', 'Stage 2', 2, 'Y', '2019-12-05 12:33:52', '2019-12-05 12:33:54', 1, 1, NULL),
	(117, 37, 'Stage 3', 'Stage 3', 3, 'Y', '2019-12-05 12:36:56', '2019-12-05 12:36:57', 1, 1, NULL),
	(118, 37, 'Stage 4', 'Stage 4', 4, 'Y', '2019-12-05 12:37:57', '2019-12-05 12:37:59', 1, 1, NULL),
	(119, 37, 'Stage 5', 'Stage 5', 5, 'Y', '2019-12-05 12:38:39', '2019-12-05 12:38:44', 1, 1, NULL),
	(120, 38, 'Work Flow Mailing Template', 'Work Flow Mailing Template', 1, 'Y', '2019-12-09 17:15:44', '2019-12-24 07:35:32', 1, 1, NULL),
	(121, 30, 'first name', '@FirstName', 1, 'Y', '2019-12-03 16:08:30', '2019-12-03 16:08:31', 1, 1, NULL),
	(123, 30, 'full name', '@FullName', 3, 'Y', '2019-12-03 16:11:34', '2019-12-03 16:11:36', 1, 1, NULL),
	(124, 30, 'user name', '@UserName', 4, 'Y', '2019-12-03 16:14:18', '2019-12-03 16:14:20', 1, 1, NULL),
	(125, 30, 'role', '@Role', 5, 'Y', '2019-12-03 16:23:41', '2019-12-03 16:23:44', 1, 1, NULL),
	(126, 30, 'email', '@Email', 6, 'Y', '2019-12-03 16:36:28', '2019-12-03 16:36:29', 1, 1, NULL),
	(127, 30, 'mobile number', '@MobileNumber', 7, 'Y', '2019-12-03 16:37:34', '2019-12-03 16:37:35', 1, 1, NULL),
	(128, 30, 'department', '@Department', 8, 'Y', '2019-12-03 16:41:27', '2019-12-03 16:41:29', 1, 1, NULL),
	(129, 31, 'project name', '@ProjectName', 1, 'Y', '2019-12-03 16:49:35', '2019-12-03 16:49:36', 1, 1, NULL),
	(130, 31, 'version name', '@VersionName', 2, 'Y', '2019-12-03 16:50:26', '2019-12-03 16:50:27', 1, 1, NULL),
	(131, 31, 'project code', '@ProjectCode', 3, 'Y', '2019-12-03 16:51:39', '2019-12-03 16:51:40', 1, 1, NULL),
	(132, 31, 'document name', '@DocumentName', 4, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(133, 31, 'document code', '@DocumentCode', 5, 'Y', '2019-12-03 16:53:25', '2019-12-03 16:53:26', 1, 1, NULL),
	(134, 31, 'level name', '@LevelName', 6, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(135, 31, 'document link', '@DocumentLink', 7, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(136, 31, 'status', '@Status', 8, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(137, 31, 'date', '@Date', 9, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(138, 31, 'document count', '@DocumentCount', 10, 'Y', '2019-12-03 16:49:35', '2019-12-17 09:33:32', 1, 1, NULL),
	(142, 39, 'daily', 'Daily', 1, 'Y', '2019-12-23 14:55:26', '2019-12-24 07:33:29', 1, 1, NULL),
	(143, 39, 'weekly', 'Weekly', 2, 'Y', '2019-12-23 14:55:49', '2019-12-24 07:33:30', 1, 1, NULL),
	(144, 39, 'oneDayBefore', 'The Day Before', 3, 'Y', '2019-12-23 14:56:38', '2019-12-24 07:33:31', 1, 1, NULL),
	(145, 39, 'noreminder', 'No Reminder', 6, 'Y', '2019-12-23 14:57:14', '2020-03-19 14:33:48', 1, 1, NULL),
	(146, 39, 'oneWeekBefore', 'The Week Before', 4, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(147, 38, 'Equipment Event Template', 'Equipment Event Template', 2, 'Y', '2019-12-09 17:31:57', '2020-04-21 18:04:02', 1, 1, NULL),
	(149, 36, 'MM:DD:YY', 'MM:DD:YY', 1, 'Y', '2020-01-23 05:49:45', '2020-01-23 05:49:45', 1, 1, NULL),
	(150, 41, 'High', 'High', 1, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(151, 41, 'Medium', 'Medium', 2, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(152, 41, 'Low', 'Low', 3, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(153, 42, 'Open', 'Open', 1, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(154, 42, 'On Hold', 'On Hold', 2, 'Y', '2019-12-23 14:57:46', '2019-12-24 07:33:32', 1, 1, NULL),
	(155, 42, 'In Progress', 'In Progress', 3, 'Y', '2019-12-23 14:57:46', '2020-01-23 15:43:59', 1, 1, NULL),
	(156, 42, 'Closed', 'Closed', 4, 'Y', '2019-12-23 14:57:46', '2020-01-23 15:44:17', 1, 1, NULL),
	(157, 31, 'Task Title', '@taskTitle', 11, 'Y', '2019-12-19 11:49:45', '2020-01-28 16:06:57', 1, 1, NULL),
	(158, 31, 'Task Status', '@taskStatus', 11, 'Y', '2019-12-19 11:49:45', '2020-01-28 16:06:57', 1, 1, NULL),
	(159, 38, 'Task Reminder Template', 'Task Reminder Template', 5, 'Y', '2019-12-26 12:35:29', '2020-01-28 16:10:10', 1, 1, NULL),
	(160, 31, 'Task Priority', '@taskPriority', 11, 'Y', '2019-12-19 11:49:45', '2020-01-28 16:06:57', 1, 1, NULL),
	(161, 34, 'completed', 'Workflow Completed', 6, 'Y', '2018-08-28 23:19:41', '2020-04-14 07:24:27', 1, 1, NULL),
	(162, 34, 'pending', 'Workflow Pending', 7, 'Y', '2018-08-28 23:19:41', '2020-04-14 07:24:30', 1, 1, NULL),
	(163, 36, 'dd-MM-YYYY hh:mm:ss a', 'dd-MM-YYYY hh:mm:ss a', 1, 'Y', '2020-03-18 04:08:20', '2020-03-18 04:08:20', 1, 1, NULL),
	(164, 36, 'dd-MM-yyyy hh:mm a', 'dd-MM-yyyy hh:mm a', 1, 'Y', '2020-03-18 04:28:54', '2020-03-18 04:28:54', 1, 1, NULL),
	(165, 22, '137', 'VSR', 7, 'Y', '2020-02-27 13:03:20', '2020-02-27 13:03:22', 1, 1, NULL),
	(166, 38, 'Work Flow Summary Remainder', 'Work Flow Summary Remainder', 3, 'Y', '2018-03-25 23:19:41', '2020-03-25 12:49:14', 1, 1, NULL),
	(167, 45, 'Facility', 'Facility', 1, 'Y', '2020-04-07 15:03:30', '2020-04-10 07:25:33', 1, 1, NULL),
	(168, 45, 'Utility', 'Utility', 1, 'Y', '2020-04-07 15:03:30', '2020-04-10 07:25:37', 1, 1, NULL),
	(169, 45, 'Equipment', 'Equipment', 1, 'Y', '2020-04-07 15:03:30', '2020-04-10 07:25:39', 1, 1, NULL),
	(170, 45, 'Instrument', 'Instrument', 1, 'Y', '2020-04-07 15:03:31', '2020-04-10 07:25:41', 1, 1, NULL),
	(171, 45, 'Computerized System', 'Computerized System', 1, 'Y', '2020-04-07 15:03:31', '2020-04-10 07:25:43', 1, 1, NULL),
	(172, 45, 'Software', 'Software', 1, 'Y', '2020-04-07 15:03:31', '2020-04-10 07:25:45', 1, 1, NULL),
	(173, 45, 'Material', 'Material', 1, 'Y', '2020-04-07 15:03:31', '2020-04-10 07:25:48', 1, 1, NULL),
	(174, 44, 'Open', 'Open', 1, 'Y', '2020-04-07 15:03:31', '2020-04-07 15:03:31', 1, 1, NULL),
	(175, 44, 'Accepted', 'Accepted', 1, 'Y', '2020-04-07 15:03:32', '2020-04-07 15:03:32', 1, 1, NULL),
	(176, 44, 'Rejected', 'Rejected', 1, 'Y', '2020-04-07 15:03:32', '2020-04-07 15:03:32', 1, 1, NULL),
	(177, 44, 'In Progress', 'In Progress', 1, 'Y', '2020-04-07 15:03:32', '2020-04-07 15:03:32', 1, 1, NULL),
	(186, 43, 'Equipment Name', '@equipmentName', 1, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(187, 43, 'Equipment Status', '@equipmentStatus', 2, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(188, 43, 'Batch', '@batch', 3, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(189, 43, 'No of Days Remaining', '@noOfDaysRemaining', 4, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(190, 43, 'Equipment Hold/Compeleted By', '@equipmentHoldCompletedBy', 5, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(191, 43, 'Due Date', '@dueDate', 6, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(192, 43, 'Equipment Event Name', '@equipmentEventName', 7, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(193, 43, 'Batch Status', '@batchStatus', 7, 'Y', '2020-04-10 09:55:27', '2020-04-10 09:55:28', 1, 1, NULL),
	(194, 34, 'reject', 'On Reject', 5, 'Y', '2020-04-14 12:53:20', '2020-04-14 07:24:43', 1, 1, NULL),
	(195, 22, '100', 'Project Setup', 11, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(196, 22, '127', 'Master Control', 11, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(197, 22, '134', 'Discrepancy Form', 11, 'Y', '2019-10-15 15:13:04', '2019-10-15 15:13:06', 1, 1, NULL),
	(198, 22, '163', 'Batch creation', 3123, 'Y', '2020-05-01 09:35:04', '2020-05-01 09:35:04', 1, 1, NULL),
	(199, 22, '191', 'change control form', 12, 'Y', '2020-05-02 13:42:26', '2020-05-02 13:42:26', 1, 1, NULL),
	(200, 31, 'task assigned To', '@assignedTo', 12, 'Y', '2019-12-03 16:50:26', '2019-12-03 16:50:27', 1, 1, NULL),
	(201, 31, 'document type', '@DocumentType', 13, 'Y', '2019-12-03 16:50:26', '2019-12-03 16:50:27', 1, 1, NULL),
	(202, 31, 'task due date', '@DueDate', 14, 'Y', '2019-12-03 16:50:26', '2019-12-03 16:50:27', 1, 1, NULL),
	(205, 47, 'Task', 'Task', 1, 'Y', '2020-05-31 12:39:33', '2020-05-31 12:39:33', 1, 1, NULL),
	(206, 47, 'Bug', 'Bug', 1, 'Y', '2020-05-31 12:39:33', '2020-05-31 12:39:33', 1, 1, NULL),
	(207, 36, 'dd:MM:YYYY', 'dd:MM:YYYY', 1, 'Y', '2020-06-23 04:28:53', '2020-06-23 04:28:53', 1, 1, NULL),
	(208, 36, 'dd-MM-yyyy hh:mm', 'dd-MM-yyyy hh:mm', 1, 'Y', '2020-06-23 07:59:48', '2020-06-23 07:59:48', 1, 1, NULL),
	(211, 49, '1', 'Open', 1, 'Y', '2020-06-25 09:57:17', '2020-06-25 09:57:17', 1, 1, NULL),
	(212, 49, '2', 'On Hold', 2, 'Y', '2020-06-25 09:57:17', '2020-06-25 09:57:17', 1, 1, NULL),
	(213, 49, '3', 'In Progress', 3, 'Y', '2020-06-25 09:57:18', '2020-06-25 09:57:18', 1, 1, NULL),
	(214, 49, '4', 'Closed', 4, 'Y', '2020-06-25 09:57:18', '2020-06-25 09:57:18', 1, 1, NULL),
	(215, 50, '1', 'URS', 1, 'Y', '2020-06-30 08:33:17', '2020-06-30 08:33:17', 1, 1, NULL),
	(216, 52, 'NA', 'NA', 1, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:38', 1, 1, NULL),
	(217, 52, 'Daily', 'Daily', 2, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:40', 1, 1, NULL),
	(218, 52, 'Weekly', 'Weekly', 3, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:42', 1, 1, NULL),
	(219, 51, 'number', 'Number', 1, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:27', 1, 1, NULL),
	(220, 51, 'text', 'String', 2, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:33', 1, 1, NULL),
	(221, 51, 'date', 'Date', 3, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:34', 1, 1, NULL),
	(222, 51, 'datetime-local', 'Date Time', 4, 'Y', '2020-06-30 08:33:17', '2020-07-18 07:32:45', 1, 1, NULL),
	(223, 52, 'OnDemand', 'OnDemand', 4, 'Y', '2020-06-30 08:33:17', '2020-07-20 04:10:03', 1, 1, NULL),
	(224, 53, 'Demo', 'Demo', 1, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(225, 53, 'Training', 'Training', 2, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(226, 53, 'QA', 'QA', 3, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(227, 53, 'Production', 'Production', 4, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(228, 53, 'UAT', 'UAT', 5, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(229, 36, 'YYYY:dd:MM hh:mm:ss z', 'YYYY:dd:MM hh:mm:ss z', 1, 'Y', '2020-07-20 06:58:47', '2020-07-20 06:58:47', 1, 1, NULL),
	(230, 36, 'yyyy:dd:MM hh:mm:ss', 'yyyy:dd:MM hh:mm:ss', 1, 'Y', '2020-07-20 07:06:11', '2020-07-20 07:06:11', 1, 1, NULL),
	(231, 36, 'yyyy:mm:dd', 'yyyy:mm:dd', 1, 'Y', '2020-07-21 06:37:26', '2020-07-21 06:37:26', 1, 1, NULL),
	(232, 36, 'YYYY/MM/dd', 'YYYY/MM/dd', 1, 'Y', '2020-07-21 07:38:13', '2020-07-21 07:38:13', 1, 1, NULL),
	(233, 55, 'Applicable', 'Applicable', 1, 'Y', '2020-07-20 10:25:57', '2020-07-24 15:38:04', 1, 1, NULL),
	(234, 55, 'Not Applicable', 'Not Applicable', 1, 'Y', '2020-07-20 10:25:57', '2020-07-24 15:38:04', 1, 1, NULL),
	(235, 56, 'Open', 'Open', 1, 'Y', '2020-07-20 10:25:57', '2020-07-24 15:38:04', 1, 1, NULL),
	(236, 56, 'Closed', 'Closed', 1, 'Y', '2020-07-20 10:25:57', '2020-07-24 15:38:04', 1, 1, NULL),
	(237, 54, 'New', 'New', 1, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(238, 54, 'Existing', 'Existing', 2, 'Y', '2020-07-20 10:25:57', '2020-07-20 10:25:58', 1, 1, NULL),
	(239, 36, 'MMMM:dd:yyyy', 'MMMM:dd:yyyy', 1, 'Y', '2020-07-28 04:06:42', '2020-07-28 04:06:42', 1, 1, NULL),
	(240, 36, 'MMM-dd-yyyy', 'MMM-dd-yyyy', 1, 'Y', '2020-07-28 13:02:34', '2020-07-28 13:02:34', 1, 1, NULL),
	(241, 36, 'MMMM-dd-yy', 'MMMM-dd-yy', 1, 'Y', '2020-07-28 17:04:02', '2020-07-28 17:04:02', 1, 1, NULL),
	(242, 36, 'MM-YYYY-dd', 'MM-YYYY-dd', 1, 'Y', '2020-07-28 17:05:50', '2020-07-28 17:05:50', 1, 1, NULL),
	(243, 36, 'dd.MM.YY hh:mm', 'dd.MM.YY hh:mm', 1, 'Y', '2020-08-06 02:38:52', '2020-08-06 02:38:52', 1, 1, NULL),
	(244, 57, 'projectName', 'Project Name', 1, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(246, 57, 'projectVersion', 'Project Version', 2, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(247, 57, 'documentType', 'Document Type', 3, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(248, 57, 'documentNumber', 'Document Number', 4, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(249, 57, 'revisionNumber', 'Revision Number', 5, 'Y', '2020-07-28 08:10:16', '2020-07-28 14:52:24', 1, 1, NULL),
	(250, 57, 'projectEquipment', 'Project Equipment', 6, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(251, 57, 'projectDept', 'Project Department', 7, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(252, 57, 'projectDocDept', 'Project Document Department', 8, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(253, 57, 'defaultPdfdate', 'Date', 9, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(254, 57, 'orgName', 'Organization Name', 10, 'Y', '2020-07-28 08:10:16', '2020-07-28 08:10:17', 1, 1, NULL),
	(255, 36, 'dd-MM-YYYY', 'dd-MM-YYYY', 1, 'Y', '2020-08-21 03:37:22', '2020-08-21 03:37:22', 1, 1, NULL),
	(276, 60, 'Temperature Low Limit', 'Temperature Low Limit', 1, 'Y', '2020-07-28 08:10:16', '2020-08-27 07:33:06', 1, 1, NULL),
	(277, 60, 'Temperature High Limit', 'Temperature High Limit', 2, 'Y', '2020-07-28 08:10:16', '2020-08-27 07:33:19', 1, 1, NULL),
	(278, 61, 'Humidity Low Limit', 'Humidity Low Limit', 1, 'Y', '2020-07-28 08:10:16', '2020-08-27 07:33:33', 1, 1, NULL),
	(279, 61, 'Humidity High Limit', 'Humidity High Limit', 2, 'Y', '2020-07-28 08:10:16', '2020-08-27 07:33:36', 1, 1, NULL),
	(280, 62, 'Bee Number', 'Bee Number', 1, 'Y', '2020-07-28 08:10:16', '2020-08-20 19:36:51', 1, 1, NULL),
	(281, 62, 'Device ID No', 'Device ID No', 2, 'Y', '2020-07-28 08:10:16', '2020-09-01 12:42:28', 1, 1, NULL),
	(283, 62, 'IMEI', 'IMEI', 3, 'Y', '2020-07-28 08:10:16', '2020-08-21 09:41:16', 1, 1, NULL),
	(284, 63, 'msg.created_date', 'msg.created_date', 1, 'Y', '2020-07-28 08:10:16', '2020-08-21 09:41:16', 1, 1, NULL),
	(285, 63, 'temperature.value', 'temperature.value', 2, 'Y', '2020-07-28 08:10:16', '2020-10-14 07:50:21', 1, 1, NULL),
	(286, 63, 'humidity.value', 'humidity.value', 3, 'Y', '2020-07-28 08:10:16', '2020-10-14 07:50:47', 1, 1, NULL),
	(287, 64, 'Company Name', 'Company Name', 1, 'Y', '2020-07-28 08:10:16', '2020-08-21 09:41:16', 1, 1, NULL),
	(288, 64, 'UUQ Name', 'UUQ Name', 2, 'Y', '2020-07-28 08:10:16', '2020-08-27 16:11:50', 1, 1, NULL),
	(289, 64, 'Load', 'Load', 3, 'Y', '2020-07-28 08:10:16', '2020-08-27 16:11:52', 1, 1, NULL),
	(290, 64, 'Season', 'Season', 4, 'Y', '2020-07-28 08:10:16', '2020-08-27 16:11:53', 1, 1, NULL),
	(291, 65, 'Date Mapping Started', 'Date Mapping Started', 1, 'Y', '2020-07-28 08:10:16', '2020-08-28 08:08:56', 1, 1, NULL),
	(293, 65, 'Date Mapping Ended', 'Date Mapping Ended', 2, 'Y', '2020-07-28 08:10:16', '2020-08-28 08:08:56', 1, 1, NULL),
	(295, 66, 'FS', 'Functional Specification', 1, 'Y', '2020-08-31 11:43:06', '2020-08-31 11:43:06', 1, 1, NULL),
	(296, 66, 'DS', 'Design Specification', 2, 'Y', '2020-08-31 11:43:06', '2020-08-31 11:43:06', 1, 1, NULL),
	(297, 22, '200', 'Specification', 1, 'Y', '2020-08-31 11:43:24', '2020-08-31 11:43:24', 1, 1, NULL),
	(298, 38, 'Test Run Mailing Template', 'Test Run Mailing Template', 6, 'Y', '2019-12-09 17:15:44', '2019-12-24 07:35:32', 1, 1, NULL),
	(299, 38, 'VSR Mailing Template', 'VSR Mailing Template', 7, 'Y', '2019-12-09 17:15:44', '2019-12-24 07:35:32', 1, 1, NULL),
	(300, 36, 'd-m-yd-m-y', 'd-m-yd-m-y', 1, 'Y', '2020-11-19 09:45:41', '2020-11-19 09:45:41', 1, 1, NULL),
	(301, 36, 'd:M:yy', 'd:M:yy', 1, 'Y', '2020-11-26 10:51:55', '2020-11-26 10:51:55', 1, 1, NULL),
	(302, 67, 'Asia/Riyadh', 'Asia/Riyadh', 1, 'Y', '2020-10-09 01:29:40', '2020-11-30 10:23:40', 1, 1, NULL),
	(303, 68, '10', '10', 1, 'Y', '2020-10-09 01:29:40', '2020-12-01 13:31:07', 1, 1, NULL),
	(307, 69, 'In Detailed Status', 'In Detailed Status', 2, 'Y', '2020-12-01 09:22:44', '2020-12-01 09:22:44', 1, 1, 1),
	(308, 69, 'OverAll Status', 'OverAll Status', 1, 'Y', '2020-12-01 09:22:13', '2020-12-01 09:22:13', 1, 1, 1),
	(309, 36, 'MM:yyyy:dd hh:mm z', 'MM:yyyy:dd hh:mm z', 1, 'Y', '2020-12-29 17:21:38', '2020-12-29 17:21:38', 1, 1, NULL),
	(310, 36, 'dd/MM/yyyy', 'dd/MM/yyyy', 1, 'Y', '2020-12-30 17:04:11', '2020-12-30 17:04:11', 1, 1, NULL),
	(311, 70, 'Critical', 'Critical', 1, 'Y', '2021-01-12 23:55:42', '2021-01-14 00:21:08', 1, 1, 1),
	(312, 70, 'Major', 'Major', 2, 'Y', '2021-01-12 23:55:42', '2021-01-14 00:20:44', 1, 1, 1),
	(313, 70, 'Minor', 'Minor', 3, 'Y', '2021-01-12 23:55:43', '2021-01-14 00:20:32', 1, 1, 1),
	(314, 39, 'month', 'One Month Before', 5, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(315, 22, '207', 'IOQTC', 4, 'Y', '2020-08-31 11:43:24', '2020-08-31 11:43:24', 1, 1, NULL),
	(316, 22, '208', 'OPQTC', 4, 'Y', '2020-08-31 11:43:24', '2020-08-31 11:43:24', 1, 1, NULL),
	(317, 71, 'A-Low', 'A-Low', 1, 'Y', '2021-03-03 19:25:19', '2021-03-03 19:28:35', 1, 1, NULL),
	(318, 71, 'B-Medium', 'B-Medium', 2, 'Y', '2021-03-03 19:25:19', '2021-03-03 19:28:37', 1, 1, NULL),
	(319, 71, 'C-High', 'C-High', 2, 'Y', '2021-03-03 19:25:19', '2021-03-03 19:28:40', 1, 1, NULL),
	(323, 72, 'Initiated', 'Initiated', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, 1),
	(324, 72, 'Validation Ongoing', 'Validation Ongoing', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:56', 1, 1, 1),
	(325, 72, 'Technically Released', 'Technically Released', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:00:12', 1, 1, 1),
	(326, 72, 'Validated', 'Validated', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:00:12', 1, 1, 1),
	(327, 72, 'Not Required', 'Not Required', 6, 'Y', '2021-01-10 11:25:31', '2021-05-05 11:18:52', 1, 1, 1),
	(328, 72, 'Controlled by SOPs', 'Controlled by SOPs', 5, 'Y', '2021-01-10 11:25:31', '2021-05-05 11:18:49', 1, 1, 1),
	(329, 73, 'In development', 'In development', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(330, 73, 'Released', 'Released', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:21', 1, 1, 1),
	(331, 73, 'Periodic Review Overdue', 'Periodic Review Overdue', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(332, 73, 'In production', 'In production', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(333, 73, 'Decommission', 'Decommission', 5, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(334, 74, 'SaaS', 'SaaS', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(335, 74, 'On premises', 'On premises', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(336, 74, 'Private Cloud', 'Private Cloud', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 09:02:19', 1, 1, 1),
	(337, 75, 'High', 'High', 1, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(338, 75, 'Medium', 'Medium', 2, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(339, 75, 'Low', 'Low', 3, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(340, 75, 'None', 'None', 4, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(341, 76, 'Out of box', 'Out of box', 1, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(342, 76, 'Configured', 'Configured', 2, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(343, 76, 'Custom', 'Custom', 3, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(344, 77, 'Scripted Testing', 'Scripted Testing', 1, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(345, 77, 'Unscripted Testing', 'Unscripted Testing', 2, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(346, 39, 'quarter', 'Three Months Before', 6, 'Y', '2021-01-12 19:43:36', '2021-01-12 19:43:37', 1, 1, NULL),
	(347, 78, 'Category 1', 'Category 1', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(348, 78, 'Category 2', 'Category 2', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(349, 79, 'Not Completed', 'Not Completed', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(350, 79, 'In Process', 'In Process', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(351, 79, 'Completed', 'Completed', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(352, 79, 'Controlled by SOPs', 'Controlled by SOPs', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(353, 80, 'Yes', 'Yes', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(354, 80, 'No', 'No', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(355, 81, 'Integration Testing', 'Integration Testing', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(356, 81, 'System Testing', 'System Testing', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(357, 81, 'Unit Testing', 'Unit Testing', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(358, 81, 'Performance Testing', 'Performance Testing', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(359, 81, 'Database Testing', 'Database Testing', 5, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(360, 81, 'Load Testing', 'Load Testing', 6, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(361, 81, 'Memory Leak Testing', 'Memory Leak Testing', 7, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(362, 81, 'Others', 'Others', 8, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(363, 79, 'N/A', 'N/A', 5, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(364, 82, 'Computer System Validation', 'Computer System Validation', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(365, 82, 'Equipment validation', 'Equipment validation', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(366, 82, 'Clean room', 'Clean room', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(367, 82, 'Process validation', 'Process validation', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(368, 82, 'Computer software assurance', 'Computer software assurance', 5, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(369, 82, 'Cleaning Validation', 'Cleaning Validation', 6, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(370, 82, 'Others', 'Others', 7, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(371, 83, 'Class 1', 'Class 1', 1, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(372, 83, 'Class 2', 'Class 2', 2, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(373, 83, 'Class 3', 'Class 3', 3, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(374, 83, 'Class 4', 'Class 4', 4, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(375, 83, 'Class 5', 'Class 5', 5, 'Y', '2021-01-10 11:25:31', '2021-05-03 08:59:40', 1, 1, NULL),
	(376, 31, 'URL', '@url', 8, 'Y', '2019-12-03 16:52:37', '2019-12-03 16:52:40', 1, 1, NULL),
	(377, 84, 'ER-Closed Systems', 'ER-Closed Systems', 1, 'Y', '2021-11-19 09:55:36', '2021-11-19 09:55:36', 1, 1, NULL),
	(378, 84, 'ER-Additional Procedures and Controls for Open Systems', 'ER-Additional Procedures and Controls for Open Systems', 2, 'Y', '2021-11-19 09:55:36', '2021-11-19 09:55:36', 1, 1, NULL),
	(379, 85, '2021', '2021', 1, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:16:59', 1, 1, NULL),
	(380, 85, '2022', '2022', 2, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:00', 1, 1, NULL),
	(381, 85, '2023', '2023', 3, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:02', 1, 1, NULL),
	(382, 85, '2024', '2024', 4, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:03', 1, 1, NULL),
	(383, 85, '2025', '2025', 5, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(384, 85, '2026', '2026', 6, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(385, 85, '2027', '2027', 7, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(386, 85, '2028', '2028', 8, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(387, 85, '2029', '2029', 9, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(388, 85, '2030', '2030', 10, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(389, 86, 'Yes', 'Yes', 1, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(390, 86, 'No', 'No', 2, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(391, 86, 'N/A', 'N/A', 3, 'Y', '2021-11-19 09:55:36', '2021-11-26 12:17:05', 1, 1, NULL),
	(392, 84, 'ES-Hybrid and Electronic Signature Systems', 'ES-Hybrid and Electronic Signature Systems', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(393, 84, 'ES-Signature Manifestations', 'ES-Signature Manifestations', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(394, 84, 'ES-Signature/ Record Linking', 'ES-Signature/ Record Linking', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(395, 84, 'ES-General Requirements', 'ES-General Requirements', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(396, 84, 'ES-Electronic Signature Components and Controls – Non – Biometric Signatures', 'ES-Electronic Signature Components and Controls – Non – Biometric Signatures', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(397, 84, 'ES-Controls for Identification Codes/Passwords', 'ES-Controls for Identification Codes/Passwords', 3, 'Y', '2021-11-19 09:55:36', '2021-12-08 15:58:36', 1, 1, NULL),
	(398, 87, 'Basic', 'Basic', 1, 'Y', '2021-11-19 09:55:36', '2021-11-19 09:55:36', 1, 1, 1),
	(399, 87, 'PROFESSIONAL', 'PROFESSIONAL', 2, 'Y', '2021-11-19 09:55:36', '2021-11-19 09:55:36', 1, 1, 1),
	(400, 87, 'ENTERPRISE', 'ENTERPRISE', 3, 'Y', '2021-11-19 09:55:36', '2021-11-19 09:55:36', 1, 1, 1);
/*!40000 ALTER TABLE `lookup_item` ENABLE KEYS */;

-- Dumping structure for table license_db.mail_history
DROP TABLE IF EXISTS `mail_history`;
CREATE TABLE IF NOT EXISTS `mail_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email_log` longtext DEFAULT NULL,
  `application_name` varchar(100) DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `org_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.mail_history: ~0 rows (approximately)
DELETE FROM `mail_history`;
/*!40000 ALTER TABLE `mail_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `mail_history` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form
DROP TABLE IF EXISTS `master_dynamic_form`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_name` varchar(100) NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `form_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_structure`)),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `multiple_entry_flag` varchar(1) DEFAULT 'N',
  `permission_constant` varchar(50) NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `published_flag` varchar(1) DEFAULT NULL,
  `prefix_for_form` varchar(50) DEFAULT ' ',
  `suffix_for_form` varchar(50) DEFAULT ' ',
  `effective_date` timestamp NULL DEFAULT NULL,
  `next_review_date` timestamp NULL DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `template_owner` bigint(20) unsigned DEFAULT NULL,
  `form_type` varchar(50) NOT NULL,
  `qr_code_flag` varchar(1) DEFAULT 'N',
  `project_flag` varchar(1) DEFAULT 'N',
  `equipment_flag` varchar(1) DEFAULT 'N',
  `clean_room_flag` varchar(1) DEFAULT 'N',
  `product_or_batch_flag` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic_forms_organization_info` (`organization_id`),
  KEY `FK_master_dynamic_forms_users` (`created_by`),
  KEY `FK_master_dynamic_forms_users_2` (`updated_by`),
  KEY `FK_master_dynamic_form_users` (`template_owner`),
  CONSTRAINT `FK_master_dynamic_form_users` FOREIGN KEY (`template_owner`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_dynamic_forms_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_master_dynamic_forms_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_dynamic_forms_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form: ~0 rows (approximately)
DELETE FROM `master_dynamic_form`;
/*!40000 ALTER TABLE `master_dynamic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form_work_flow
DROP TABLE IF EXISTS `master_dynamic_form_work_flow`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form_work_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `level_compeleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic_form_work_flow_master_dynamic_form` (`master_dynamic_form_id`),
  CONSTRAINT `FK_master_dynamic_form_work_flow_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form_work_flow: ~0 rows (approximately)
DELETE FROM `master_dynamic_form_work_flow`;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form_work_flow_child
DROP TABLE IF EXISTS `master_dynamic_form_work_flow_child`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form_work_flow_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mdf_workflow_id` bigint(20) unsigned NOT NULL,
  `form_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_structure`)),
  `level_id` bigint(20) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic_form_work_` (`mdf_workflow_id`),
  KEY `FK_master_dynamic_form_work_flow_child_work_flow_levels` (`level_id`),
  KEY `FK_master_dynamic_form_work_flow_child_users` (`user_id`),
  CONSTRAINT `FK_master_dynamic_form_work_` FOREIGN KEY (`mdf_workflow_id`) REFERENCES `master_dynamic_form_work_flow` (`id`),
  CONSTRAINT `FK_master_dynamic_form_work_flow_child_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKdw01uxkkcsvcy7ljlaosqw3sf` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form_work_flow_child: ~0 rows (approximately)
DELETE FROM `master_dynamic_form_work_flow_child`;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_child` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form_work_flow_configuration
DROP TABLE IF EXISTS `master_dynamic_form_work_flow_configuration`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form_work_flow_configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_master _dynamic_form` (`master_dynamic_form_id`),
  KEY `FK_master _dynamic_form_work_flow_configuration_work_flow_levels` (`level_id`),
  KEY `FK_master _dynamic_form_work_flow_configuration_users` (`created_by`),
  KEY `FK_master _dynamic_form_work_flow_configuration_users_2` (`updated_by`),
  CONSTRAINT `FK8ynol2gsbvf53qrbxp21w9m8h` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_master _dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_master _dynamic_form_work_flow_configuration_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master _dynamic_form_work_flow_configuration_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form_work_flow_configuration: ~0 rows (approximately)
DELETE FROM `master_dynamic_form_work_flow_configuration`;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_configuration` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form_work_flow_configuration_users
DROP TABLE IF EXISTS `master_dynamic_form_work_flow_configuration_users`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form_work_flow_configuration_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mdf_wfc_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master _dynamic_form_work_flow_configuration` (`mdf_wfc_id`),
  KEY `FK_master _users_users` (`user_id`),
  CONSTRAINT `FK_master _dynamic_form_work_flow_configuration` FOREIGN KEY (`mdf_wfc_id`) REFERENCES `master_dynamic_form_work_flow_configuration` (`id`),
  CONSTRAINT `FK_master _users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form_work_flow_configuration_users: ~0 rows (approximately)
DELETE FROM `master_dynamic_form_work_flow_configuration_users`;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_configuration_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_configuration_users` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_form_work_flow_log
DROP TABLE IF EXISTS `master_dynamic_form_work_flow_log`;
CREATE TABLE IF NOT EXISTS `master_dynamic_form_work_flow_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level_id` bigint(20) NOT NULL,
  `mdf_workflow_id` bigint(20) unsigned NOT NULL,
  `form_structure` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`form_structure`)),
  `user_id` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment` text NOT NULL,
  `master_dynamic_form_id` bigint(20) unsigned NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_dynamic_work_flow_comments_log_work_flow_levels` (`level_id`),
  KEY `FK_dynamic_work_flow_comments_log_master_dynamic_form_work_flow` (`mdf_workflow_id`),
  KEY `FK_dynamic_work_flow_comments_log_users` (`user_id`),
  KEY `FK_dynamic_work_flow_comments_log_master_dynamic_form` (`master_dynamic_form_id`),
  CONSTRAINT `FK_dynamic_work_flow_comments_log_master_dynamic_form` FOREIGN KEY (`master_dynamic_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_dynamic_work_flow_comments_log_master_dynamic_form_work_flow` FOREIGN KEY (`mdf_workflow_id`) REFERENCES `master_dynamic_form_work_flow` (`id`),
  CONSTRAINT `FK_dynamic_work_flow_comments_log_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FKfs52a9y4aovm7oe1fm8d7gtsf` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_form_work_flow_log: ~0 rows (approximately)
DELETE FROM `master_dynamic_form_work_flow_log`;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_form_work_flow_log` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template
DROP TABLE IF EXISTS `master_dynamic_template`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_template_name` varchar(100) NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ftp_path` text DEFAULT NULL,
  `permission_constant` varchar(50) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `organization_id` bigint(20) unsigned NOT NULL,
  `published_flag` varchar(1) NOT NULL DEFAULT 'N',
  `prefix_for_template` varchar(50) DEFAULT ' ',
  `suffix_for_template` varchar(50) DEFAULT ' ',
  `effective_date` timestamp NULL DEFAULT NULL,
  `next_review_date` timestamp NULL DEFAULT NULL,
  `version` varchar(50) DEFAULT NULL,
  `template_owner` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic_template_users` (`created_by`),
  KEY `FK_master_dynamic_template_users_2` (`updated_by`),
  KEY `FK_master_dynamic_template_organization_info` (`organization_id`),
  KEY `FK_master_dynamic_template_users_3` (`template_owner`),
  CONSTRAINT `FK_master_dynamic_template_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_master_dynamic_template_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_dynamic_template_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_dynamic_template_users_3` FOREIGN KEY (`template_owner`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Master it can be added to multiple project';

-- Dumping data for table license_db.master_dynamic_template: ~0 rows (approximately)
DELETE FROM `master_dynamic_template`;
/*!40000 ALTER TABLE `master_dynamic_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template_work_flow
DROP TABLE IF EXISTS `master_dynamic_template_work_flow`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template_work_flow` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_template_form_id` bigint(20) unsigned NOT NULL,
  `level_compeleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_template_form` (`master_template_form_id`),
  CONSTRAINT `master_template_form_id` FOREIGN KEY (`master_template_form_id`) REFERENCES `master_dynamic_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_template_work_flow: ~0 rows (approximately)
DELETE FROM `master_dynamic_template_work_flow`;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template_work_flow_child
DROP TABLE IF EXISTS `master_dynamic_template_work_flow_child`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template_work_flow_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mdt_workflow_id` bigint(20) unsigned NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ftp_path` text DEFAULT NULL,
  `level_id` bigint(20) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic` (`mdt_workflow_id`),
  KEY `FK_master_dynamic_form_work_flow_child_work_flow_levels` (`level_id`),
  KEY `FK_master_dynamic_form_work_flow_child_users` (`user_id`),
  CONSTRAINT `FK_master_dynamic_form_work` FOREIGN KEY (`mdt_workflow_id`) REFERENCES `master_dynamic_template_work_flow` (`id`),
  CONSTRAINT `FKimm88x0l6p7onhgaqnwf21utx` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `child_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_template_work_flow_child: ~0 rows (approximately)
DELETE FROM `master_dynamic_template_work_flow_child`;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_child` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template_work_flow_configuration
DROP TABLE IF EXISTS `master_dynamic_template_work_flow_configuration`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template_work_flow_configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_dynamic_template_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_master _dynamic_temp` (`master_dynamic_template_id`),
  KEY `FK_master _dynamic_temp_work_flow_configuration_work_flow_levels` (`level_id`),
  KEY `FK_master _dynamic_temp_work_flow_configuration_users` (`created_by`),
  KEY `FK_master _dynamic_temp_work_flow_configuration_users_2` (`updated_by`),
  CONSTRAINT `FK_master _dynamic_template` FOREIGN KEY (`master_dynamic_template_id`) REFERENCES `master_dynamic_template` (`id`),
  CONSTRAINT `FK_master _dynamic_template_work_flow_configuration_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master _dynamic_template_work_flow_configuration_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FKhd9utagdoq2wl2wb019ks6ar` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_template_work_flow_configuration: ~0 rows (approximately)
DELETE FROM `master_dynamic_template_work_flow_configuration`;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_configuration` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template_work_flow_configuration_users
DROP TABLE IF EXISTS `master_dynamic_template_work_flow_configuration_users`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template_work_flow_configuration_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mdt_wfc_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master_dynamic_temp_work_flow_configuration` (`mdt_wfc_id`),
  KEY `FK_master_users` (`user_id`),
  CONSTRAINT `FK_master _dynamic_temp_work_flow_configuration` FOREIGN KEY (`mdt_wfc_id`) REFERENCES `master_dynamic_template_work_flow_configuration` (`id`),
  CONSTRAINT `FK_master_users_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_template_work_flow_configuration_users: ~0 rows (approximately)
DELETE FROM `master_dynamic_template_work_flow_configuration_users`;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_configuration_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_configuration_users` ENABLE KEYS */;

-- Dumping structure for table license_db.master_dynamic_template_work_flow_log
DROP TABLE IF EXISTS `master_dynamic_template_work_flow_log`;
CREATE TABLE IF NOT EXISTS `master_dynamic_template_work_flow_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level_id` bigint(20) NOT NULL,
  `mdt_workflow_id` bigint(20) unsigned NOT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_ftp_path` text DEFAULT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `comment` text NOT NULL,
  `master_dynamic_template_id` bigint(20) unsigned NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK_dynamic_work_flow_comments_log_work_flow_levels` (`level_id`),
  KEY `FK_dynamic_work_flow` (`mdt_workflow_id`),
  KEY `FK_users` (`user_id`),
  KEY `FK_dynamic_work_flow_` (`master_dynamic_template_id`),
  CONSTRAINT `FK27xsg7k65buj5nambacys76xk` FOREIGN KEY (`level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_dynamic` FOREIGN KEY (`mdt_workflow_id`) REFERENCES `master_dynamic_template_work_flow` (`id`),
  CONSTRAINT `FK_dynamic_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_dynamic_work_flow_comments_log` FOREIGN KEY (`master_dynamic_template_id`) REFERENCES `master_dynamic_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_dynamic_template_work_flow_log: ~0 rows (approximately)
DELETE FROM `master_dynamic_template_work_flow_log`;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_dynamic_template_work_flow_log` ENABLE KEYS */;

-- Dumping structure for table license_db.master_email_config
DROP TABLE IF EXISTS `master_email_config`;
CREATE TABLE IF NOT EXISTS `master_email_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `host` varchar(100) NOT NULL,
  `port` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` longtext NOT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `starttls_enable` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK-for-organization` (`organization_id`),
  KEY `FK-for-createdUsers` (`created_by`),
  KEY `FK-for-updatedUsers` (`updated_by`),
  CONSTRAINT `FK-for-createdUsers` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK-for-organization` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK-for-updatedUsers` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_email_config: ~0 rows (approximately)
DELETE FROM `master_email_config`;
/*!40000 ALTER TABLE `master_email_config` DISABLE KEYS */;
INSERT INTO `master_email_config` (`id`, `organization_id`, `host`, `port`, `username`, `password`, `created_by`, `created_time`, `updated_by`, `updated_time`, `starttls_enable`) VALUES
	(1, 1, 'smtp.gmail.com', 587, 'govaltesters@gmail.com', 'Z292YWxpZGF0aW9u', 1, '2021-04-27 23:02:00', 1, '2021-05-06 02:00:20', 'Y');
/*!40000 ALTER TABLE `master_email_config` ENABLE KEYS */;

-- Dumping structure for table license_db.master_form_mapping
DROP TABLE IF EXISTS `master_form_mapping`;
CREATE TABLE IF NOT EXISTS `master_form_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `master_form_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_master_form_mapping_master_dynamic_form` (`master_form_id`),
  KEY `FK_master_form_mapping_organization_info` (`organization_id`),
  KEY `FK_master_form_mapping_users` (`created_by`),
  KEY `FK_master_form_mapping_users_2` (`updated_by`),
  CONSTRAINT `FK_master_form_mapping_master_dynamic_form` FOREIGN KEY (`master_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_master_form_mapping_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_master_form_mapping_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_form_mapping_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Mapping the master form with each other';

-- Dumping data for table license_db.master_form_mapping: ~0 rows (approximately)
DELETE FROM `master_form_mapping`;
/*!40000 ALTER TABLE `master_form_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_form_mapping` ENABLE KEYS */;

-- Dumping structure for table license_db.master_form_mapping_child
DROP TABLE IF EXISTS `master_form_mapping_child`;
CREATE TABLE IF NOT EXISTS `master_form_mapping_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mfm_id` bigint(20) unsigned NOT NULL,
  `mdf_id` bigint(20) unsigned NOT NULL,
  `order` int(10) unsigned NOT NULL,
  `unique_constant` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_master_form_mapping_child_master_form_mapping` (`mfm_id`),
  KEY `FK_master_form_mapping_child_master_dynamic_form` (`mdf_id`),
  CONSTRAINT `FK_master_form_mapping_child_master_dynamic_form` FOREIGN KEY (`mdf_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_master_form_mapping_child_master_form_mapping` FOREIGN KEY (`mfm_id`) REFERENCES `master_form_mapping` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Form Mapping and order of it';

-- Dumping data for table license_db.master_form_mapping_child: ~0 rows (approximately)
DELETE FROM `master_form_mapping_child`;
/*!40000 ALTER TABLE `master_form_mapping_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_form_mapping_child` ENABLE KEYS */;

-- Dumping structure for table license_db.master_for_dynamic_form
DROP TABLE IF EXISTS `master_for_dynamic_form`;
CREATE TABLE IF NOT EXISTS `master_for_dynamic_form` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `dynamic_form_id` bigint(20) unsigned NOT NULL,
  `master_form_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__dynamic_form` (`dynamic_form_id`) USING BTREE,
  KEY `FK__dynamic_form_2` (`master_form_id`) USING BTREE,
  CONSTRAINT `FK__dynamic_form` FOREIGN KEY (`dynamic_form_id`) REFERENCES `dynamic_form` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK__dynamic_form_2` FOREIGN KEY (`master_form_id`) REFERENCES `dynamic_form` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.master_for_dynamic_form: ~0 rows (approximately)
DELETE FROM `master_for_dynamic_form`;
/*!40000 ALTER TABLE `master_for_dynamic_form` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_for_dynamic_form` ENABLE KEYS */;

-- Dumping structure for table license_db.master_for_dynamic_form_link
DROP TABLE IF EXISTS `master_for_dynamic_form_link`;
CREATE TABLE IF NOT EXISTS `master_for_dynamic_form_link` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `master_form_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_master_for_dynamic_form_link_master_dynamic_form` (`master_form_id`) USING BTREE,
  KEY `FK_master_for_dynamic_form_link_permissions` (`document_type`) USING BTREE,
  KEY `FK_master_for_dynamic_form_link_users` (`created_by`) USING BTREE,
  KEY `FK_master_for_dynamilicense_dbc_form_link_project_setup` (`project_id`) USING BTREE,
  KEY `FK_master_for_dynamic_form_link_users_2` (`updated_by`) USING BTREE,
  CONSTRAINT `FK_master_for_dynamic_form_link_master_dynamic_form` FOREIGN KEY (`master_form_id`) REFERENCES `master_dynamic_form` (`id`),
  CONSTRAINT `FK_master_for_dynamic_form_link_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_master_for_dynamic_form_link_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_master_for_dynamic_form_link_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_master_for_dynamic_form_link_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Having a master form for dynamic form data';

-- Dumping data for table license_db.master_for_dynamic_form_link: ~0 rows (approximately)
DELETE FROM `master_for_dynamic_form_link`;
/*!40000 ALTER TABLE `master_for_dynamic_form_link` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_for_dynamic_form_link` ENABLE KEYS */;

-- Dumping structure for table license_db.module_permission_for_role
DROP TABLE IF EXISTS `module_permission_for_role`;
CREATE TABLE IF NOT EXISTS `module_permission_for_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `permission_constant` varchar(50) NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_module_permission_for_role_roles` (`role_id`),
  KEY `FK_module_permission_for_role_permissions` (`permission_constant`),
  KEY `FK_module_permission_for_role_users` (`created_by`),
  CONSTRAINT `FK_module_permission_for_role_permissions` FOREIGN KEY (`permission_constant`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_module_permission_for_role_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_module_permission_for_role_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.module_permission_for_role: ~0 rows (approximately)
DELETE FROM `module_permission_for_role`;
/*!40000 ALTER TABLE `module_permission_for_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `module_permission_for_role` ENABLE KEYS */;

-- Dumping structure for table license_db.module_permission_group
DROP TABLE IF EXISTS `module_permission_group`;
CREATE TABLE IF NOT EXISTS `module_permission_group` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.module_permission_group: ~9 rows (approximately)
DELETE FROM `module_permission_group`;
/*!40000 ALTER TABLE `module_permission_group` DISABLE KEYS */;
INSERT INTO `module_permission_group` (`id`, `category`) VALUES
	(1, 'Equipment'),
	(7, 'Form'),
	(9, 'Form-Group'),
	(2, 'General'),
	(3, 'Master Data setup'),
	(4, 'Settings'),
	(8, 'Template'),
	(5, 'User Access'),
	(6, 'Validation');
/*!40000 ALTER TABLE `module_permission_group` ENABLE KEYS */;

-- Dumping structure for table license_db.notification
DROP TABLE IF EXISTS `notification`;
CREATE TABLE IF NOT EXISTS `notification` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `permission_constant` varchar(50) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `active` varchar(1) DEFAULT 'Y',
  `document_code` varchar(50) DEFAULT NULL,
  `document_id` varchar(50) DEFAULT NULL,
  `message` longtext DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL,
  `created_time` datetime NOT NULL,
  `delete_flag` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_notification_users` (`created_by`),
  KEY `FK_notification_project_setup` (`project_id`),
  KEY `FK_notification_organization_info` (`org_id`),
  KEY `FK_notification_project_version` (`version_id`),
  KEY `FK_notification_permissions` (`permission_constant`),
  CONSTRAINT `FK_notification_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_notification_permissions` FOREIGN KEY (`permission_constant`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_notification_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_notification_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_notification_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.notification: ~0 rows (approximately)
DELETE FROM `notification`;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;

-- Dumping structure for table license_db.notification_child
DROP TABLE IF EXISTS `notification_child`;
CREATE TABLE IF NOT EXISTS `notification_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` bigint(20) unsigned NOT NULL,
  `assigned_user` bigint(20) unsigned DEFAULT NULL,
  `viewed_flag` char(50) DEFAULT 'N',
  `viewed_datetime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_notification_child_notification` (`notification_id`),
  KEY `FK_notification_child_users` (`assigned_user`),
  CONSTRAINT `FK_notification_child_notification` FOREIGN KEY (`notification_id`) REFERENCES `notification` (`id`),
  CONSTRAINT `FK_notification_child_users` FOREIGN KEY (`assigned_user`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.notification_child: ~0 rows (approximately)
DELETE FROM `notification_child`;
/*!40000 ALTER TABLE `notification_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_child` ENABLE KEYS */;

-- Dumping structure for table license_db.organization_info
DROP TABLE IF EXISTS `organization_info`;
CREATE TABLE IF NOT EXISTS `organization_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_name` varchar(150) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `organization_license` char(11) DEFAULT 'Y',
  `organization_license_used` char(11) DEFAULT '0',
  `organization_license_valid_till` varchar(50) DEFAULT NULL,
  `organization_email` varchar(100) NOT NULL,
  `db_name` varchar(50) NOT NULL,
  `db_type` varchar(50) NOT NULL,
  `country` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `district` varchar(50) DEFAULT NULL,
  `street` varchar(200) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` char(1) DEFAULT 'N',
  `terms_and_conditions` varchar(200) DEFAULT NULL,
  `date_format` varchar(200) DEFAULT NULL,
  `time_zone` varchar(200) DEFAULT NULL,
  `equipment_count` varchar(50) DEFAULT '0',
  `form_count` varchar(50) DEFAULT '0',
  `projectsetup_count` varchar(50) DEFAULT '0',
  `datepicker_format` varchar(50) DEFAULT 'dd-mm-yyyy',
  `location_name` varchar(50) NOT NULL,
  `location_code` varchar(50) NOT NULL,
  `storage_space` int(11) DEFAULT 50,
  `build_status` char(1) DEFAULT 'N',
  `active_user_sessions` int(11) DEFAULT 0,
  `periodic_duration` int(11) NOT NULL DEFAULT 1,
  `installation_plan` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `organization_email` (`organization_email`),
  UNIQUE KEY `UKvqg2h94u99dih88g9pjah9q2` (`organization_email`),
  KEY `FK_organization_info_user` (`created_by`),
  KEY `FK_organization_info_user_2` (`updated_by`),
  CONSTRAINT `FK_organization_info_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_organization_info_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.organization_info: ~1 rows (approximately)
DELETE FROM `organization_info`;
/*!40000 ALTER TABLE `organization_info` DISABLE KEYS */;
INSERT INTO `organization_info` (`id`, `organization_name`, `organization_license`, `organization_license_used`, `organization_license_valid_till`, `organization_email`, `db_name`, `db_type`, `country`, `state`, `district`, `street`, `pincode`, `created_by`, `created_time`, `updated_by`, `updated_time`, `delete_flag`, `terms_and_conditions`, `date_format`, `time_zone`, `equipment_count`, `form_count`, `projectsetup_count`, `datepicker_format`, `location_name`, `location_code`, `storage_space`, `build_status`, `active_user_sessions`, `periodic_duration`, `installation_plan`) VALUES
	(1, 'Root Admin', '60', '1', '05/8/2022', 'adventsysdeveloper@gmail.com', 'license_db', 'mysql', '', '', '', '', 560001, 1, '2022-01-10 14:53:03', 1, '2022-01-10 14:53:03', 'N', 'terms', NULL, NULL, '0', '0', '0', 'dd-MM-yyyy', '', '', NULL, 'Y', 60, 1, '');
/*!40000 ALTER TABLE `organization_info` ENABLE KEYS */;

-- Dumping structure for table license_db.organization_modules
DROP TABLE IF EXISTS `organization_modules`;
CREATE TABLE IF NOT EXISTS `organization_modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_constant` bigint(20) NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `Created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_organization_modules_organization_info` (`organization_id`),
  CONSTRAINT `FK_organization_modules_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.organization_modules: ~0 rows (approximately)
DELETE FROM `organization_modules`;
/*!40000 ALTER TABLE `organization_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_modules` ENABLE KEYS */;

-- Dumping structure for table license_db.organization_week_days
DROP TABLE IF EXISTS `organization_week_days`;
CREATE TABLE IF NOT EXISTS `organization_week_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `week_day_id` bigint(20) NOT NULL,
  `select_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_organization_week_days_organization_info` (`org_id`),
  KEY `FK_organization_week_days_week_days` (`week_day_id`),
  CONSTRAINT `FK_organization_week_days_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_organization_week_days_week_days` FOREIGN KEY (`week_day_id`) REFERENCES `week_days` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.organization_week_days: ~0 rows (approximately)
DELETE FROM `organization_week_days`;
/*!40000 ALTER TABLE `organization_week_days` DISABLE KEYS */;
/*!40000 ALTER TABLE `organization_week_days` ENABLE KEYS */;

-- Dumping structure for table license_db.pdf_chapter_check_list
DROP TABLE IF EXISTS `pdf_chapter_check_list`;
CREATE TABLE IF NOT EXISTS `pdf_chapter_check_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `category` varchar(50) NOT NULL,
  `pdf_chapter_name` varchar(250) NOT NULL,
  `pdf_chapter_content` longtext NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `unique_key` varchar(50) NOT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_pdf_chapter_check_list_organization_info` (`org_id`) USING BTREE,
  KEY `FK_pdf_chapter_check_list_users` (`created_by`) USING BTREE,
  KEY `FK_pdf_chapter_check_list_users_2` (`updated_by`) USING BTREE,
  CONSTRAINT `FK_pdf_chapter_check_list_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_pdf_chapter_check_list_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_pdf_chapter_check_list_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='All ENGINE of Chapter need to add the the default PDF';

-- Dumping data for table license_db.pdf_chapter_check_list: ~28 rows (approximately)
DELETE FROM `pdf_chapter_check_list`;
/*!40000 ALTER TABLE `pdf_chapter_check_list` DISABLE KEYS */;
INSERT INTO `pdf_chapter_check_list` (`id`, `category`, `pdf_chapter_name`, `pdf_chapter_content`, `order`, `unique_key`, `project_id`, `org_id`, `active_flag`, `created_by`, `created_time`, `updated_by`, `updated_time`) VALUES
	(1, '107', 'Project', 'test', 1, '', 2, 1, 'Y', 1, '2021-09-07 16:54:41', 1, '2021-10-20 01:51:21'),
	(2, 'ALL', 'Introduction', '', 1, 'chapter1', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(3, 'ALL', 'Purpose', '', 2, 'chapter2', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-03-18 19:55:52'),
	(4, 'ALL', 'Scope', '', 3, 'chapter3', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-03-18 19:55:58'),
	(5, 'ALL', 'Reference', '', 4, 'chapter4', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(6, 'ALL', 'Responsibilities', '', 5, 'chapter5', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(7, 'ALL', 'System Description', '', 5, 'chapter6', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(8, 'ALL', 'Acceptance Criteria', '', 7, 'chapter7', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(9, 'ALL', 'Validation Strategy', '', 8, 'chapter8', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(10, 'ALL', 'Approval History', '', 9, 'chapter9', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-18 15:32:15'),
	(11, 'ALL', 'Revision History', '', 10, 'chapter10', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(12, 'ALL', 'Document Data', '', 11, 'chapter11', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-18 15:32:21'),
	(13, '108', 'Test Approach', '', 12, 'chapter12', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(14, '109', 'Test Approach', '', 12, 'chapter13', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(15, '110', 'Test Approach', '', 12, 'chapter14', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(16, '108', 'Conclusion', '', 13, 'chapter15', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(17, '109', 'Conclusion', '', 13, 'chapter16', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(18, '110', 'Conclusion', '', 13, 'chapter17', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(19, 'ALL', 'External Approval History', '', 11, 'chapter18', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-01-05 22:08:42'),
	(20, 'ALL', 'Document Specific Form Data', '', 12, 'chapter19', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-01-05 22:08:42'),
	(21, '208', 'Pre-Approval', '', 14, 'chapter20', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(22, '207', 'Pre-Approval', '', 14, 'chapter20', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(23, '110', 'Pre-Approval', '', 14, 'chapter20', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(24, '109', 'Pre-Approval', '', 14, 'chapter20', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(25, '108', 'Pre-Approval', '', 14, 'chapter20', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2020-08-05 06:25:47'),
	(26, '100', 'GxP Form', ' ', 12, 'chapter21', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-01-05 22:08:42'),
	(27, 'ALL', 'Project Setup', ' ', 12, 'project', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-01-05 22:08:42'),
	(28, 'ALL', 'Project Plan', ' ', 12, 'project_plan', NULL, NULL, 'Y', NULL, '2020-08-05 06:25:47', NULL, '2021-01-05 22:08:42');
/*!40000 ALTER TABLE `pdf_chapter_check_list` ENABLE KEYS */;

-- Dumping structure for table license_db.pdf_header_footer_configuration
DROP TABLE IF EXISTS `pdf_header_footer_configuration`;
CREATE TABLE IF NOT EXISTS `pdf_header_footer_configuration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT '0',
  `font_size` int(11) NOT NULL DEFAULT 14,
  `font_color` varchar(50) NOT NULL DEFAULT '#000000',
  `font_style` varchar(50) NOT NULL DEFAULT 'normal',
  `font_family` varchar(50) NOT NULL DEFAULT 'TIMES_ROMAN',
  `parent_id` bigint(20) unsigned NOT NULL,
  `border_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_default_pdf_header_or_footer_application_css_styles` (`parent_id`) USING BTREE,
  CONSTRAINT `FK_default_pdf_header_or_footer_application_css_styles` FOREIGN KEY (`parent_id`) REFERENCES `default_pdf` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table license_db.pdf_header_footer_configuration: ~0 rows (approximately)
DELETE FROM `pdf_header_footer_configuration`;
/*!40000 ALTER TABLE `pdf_header_footer_configuration` DISABLE KEYS */;
/*!40000 ALTER TABLE `pdf_header_footer_configuration` ENABLE KEYS */;

-- Dumping structure for table license_db.pdf_header_footer_configuration_child
DROP TABLE IF EXISTS `pdf_header_footer_configuration_child`;
CREATE TABLE IF NOT EXISTS `pdf_header_footer_configuration_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) unsigned NOT NULL,
  `position` varchar(50) NOT NULL DEFAULT 'left',
  `alignment` varchar(50) NOT NULL DEFAULT 'left',
  `type` varchar(50) NOT NULL DEFAULT 'text',
  `image` longtext DEFAULT NULL,
  `text` text NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `req_variable_ame` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_default_header_or_footer_child_default_pdf_header_or_footer` (`parent_id`) USING BTREE,
  CONSTRAINT `FK_default_header_or_footer_child_default_pdf_header_or_footer` FOREIGN KEY (`parent_id`) REFERENCES `pdf_header_footer_configuration` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table license_db.pdf_header_footer_configuration_child: ~0 rows (approximately)
DELETE FROM `pdf_header_footer_configuration_child`;
/*!40000 ALTER TABLE `pdf_header_footer_configuration_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `pdf_header_footer_configuration_child` ENABLE KEYS */;

-- Dumping structure for table license_db.periodic_review_history
DROP TABLE IF EXISTS `periodic_review_history`;
CREATE TABLE IF NOT EXISTS `periodic_review_history` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `doc_type` varchar(50) NOT NULL,
  `review_date` datetime DEFAULT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_periodic_review_project_setup` (`project_id`),
  KEY `FK_periodic_review_project_version` (`version_id`),
  KEY `FK_periodic_review_permissions` (`doc_type`),
  KEY `FK_periodic_review_users` (`updated_by`),
  CONSTRAINT `FK_periodic_review_history_permissions` FOREIGN KEY (`doc_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_periodic_review_history_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_periodic_review_history_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_periodic_review_history_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.periodic_review_history: ~0 rows (approximately)
DELETE FROM `periodic_review_history`;
/*!40000 ALTER TABLE `periodic_review_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `periodic_review_history` ENABLE KEYS */;

-- Dumping structure for table license_db.permissions
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` bigint(20) unsigned NOT NULL,
  `permission_constant_name` varchar(50) NOT NULL,
  `workflow_enable_flag` varchar(1) NOT NULL DEFAULT 'N',
  `require_project_setup` varchar(1) NOT NULL DEFAULT 'N',
  `permission_title` varchar(100) NOT NULL,
  `routing_url` varchar(200) DEFAULT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `display_order` int(11) DEFAULT NULL,
  `grouping_number` int(11) DEFAULT NULL,
  `document_code` varchar(50) DEFAULT NULL,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `permission_category_grouping` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_bk4ibdj5cbtc3qatgo25172d5` (`permission_constant_name`),
  KEY `FK_permissions_organization_info` (`org_id`),
  KEY `FK_permissions_permission_category` (`category`),
  KEY `FK_permissions_module_permission_group` (`permission_category_grouping`),
  CONSTRAINT `FK_permissions_module_permission_group` FOREIGN KEY (`permission_category_grouping`) REFERENCES `module_permission_group` (`id`),
  CONSTRAINT `FK_permissions_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_permissions_permission_category` FOREIGN KEY (`category`) REFERENCES `permission_category` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.permissions: ~102 rows (approximately)
DELETE FROM `permissions`;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` (`id`, `category`, `permission_constant_name`, `workflow_enable_flag`, `require_project_setup`, `permission_title`, `routing_url`, `delete_flag`, `display_order`, `grouping_number`, `document_code`, `org_id`, `permission_category_grouping`) VALUES
	(1, 1, '100', 'Y', 'N', 'Project SetUp', 'Project-setup/view-projectsetup', 'N', 1, 1, NULL, NULL, 6),
	(2, 1, '101', 'N', 'N', 'Dashboard', 'dashboard', 'N', 2, NULL, NULL, NULL, 2),
	(3, 1, '102', 'N', 'N', 'Audit Trail', 'auditTrail', 'N', 3, NULL, NULL, NULL, 2),
	(4, 1, '103', 'N', 'N', 'Department', 'department', 'N', 1, 6, NULL, NULL, 3),
	(5, 1, '104', 'N', 'N', 'Category', 'category', 'N', 2, 1, NULL, NULL, 3),
	(6, 1, '105', 'N', 'N', 'Priority', 'Priority', 'N', 3, 1, NULL, NULL, 3),
	(7, 1, '111', 'N', 'N', 'LookUp ', 'look-up/lookup-item', 'Y', 12, NULL, NULL, NULL, NULL),
	(8, 1, '112', 'N', 'N', 'User Management', 'userManagement/view-user', 'N', 2, 6, NULL, NULL, 5),
	(9, 1, '116', 'N', 'N', 'Project Plan', 'projectplan/add-projectplan', 'N', 3, 2, 'PP', NULL, 6),
	(10, 1, '125', 'N', 'N', 'Roles Management', 'rolesManagement', 'N', 3, 6, NULL, NULL, 5),
	(11, 1, '126', 'N', 'N', 'Document Status', 'newDocumentStatus', 'N', 27, NULL, NULL, NULL, NULL),
	(12, 1, '127', 'N', 'N', 'Master Control', 'masterControl', 'N', 4, 6, NULL, NULL, 4),
	(13, 1, '128', 'N', 'N', 'Vendor Documents', 'vendor/view-vendor', 'N', 9, 2, NULL, NULL, 6),
	(14, 4, '129', 'Y', 'Y', 'Traceability Matrix', 'traceability', 'N', 12, 2, NULL, NULL, 6),
	(15, 1, '130', 'N', 'N', 'Master Work Flow', '', 'Y', 43, NULL, NULL, NULL, NULL),
	(16, 1, '131', 'N', 'N', 'testing Data', '', 'Y', 39, NULL, NULL, NULL, NULL),
	(17, 1, '99', 'N', 'N', 'Organization', 'organization/view-organization', 'Y', 1, NULL, NULL, NULL, NULL),
	(18, 1, '133', 'N', 'N', 'Master Dynamic Template Work Flow', 'workFlowMasterDynamicForms', 'Y', 31, NULL, NULL, NULL, NULL),
	(19, 1, '153', 'N', 'N', 'PDF Settings', 'pdfPreference', 'N', 5, 6, NULL, NULL, 4),
	(20, 1, '154', 'N', 'N', 'Workflow Levels', 'workFlowLevels', 'N', 6, NULL, NULL, NULL, 3),
	(21, 1, '155', 'N', 'N', 'View Knowledge Base', 'knowledgeBase/view-knowledgeBase', 'N', 52, NULL, NULL, NULL, 2),
	(22, 1, '135', 'N', 'N', 'Bulk Upload', 'bulkUpload', 'N', 2, 2, NULL, NULL, 6),
	(23, 1, '136', 'N', 'N', 'DMS', 'dms', 'N', 18, NULL, NULL, NULL, 2),
	(24, 1, '157', 'N', 'N', 'LDAP', 'ldap/ldap-master', 'N', 8, 6, NULL, NULL, 4),
	(25, 1, '138', 'Y', 'Y', 'Templates', 'templates', 'N', 5, 1, NULL, NULL, 3),
	(26, 1, '139', 'Y', 'Y', 'Forms', 'workFlowMasterDynamicForm', 'N', 4, 1, NULL, NULL, 3),
	(27, 1, '140', 'N', 'N', 'Location', 'location', 'N', 6, 1, NULL, NULL, 3),
	(28, 1, '141', 'N', 'N', 'Equipment', 'equipment', 'N', 7, 1, NULL, NULL, 3),
	(29, 1, '142', 'N', 'N', 'Facility', 'facility', 'N', 9, 1, NULL, NULL, 3),
	(30, 1, '143', 'N', 'N', 'Shift', 'shift', 'N', 8, 1, NULL, NULL, 3),
	(31, 1, '160', 'N', 'N', 'Knoweldgebase ', 'knowledgeBase/view-knowledgeBase', 'N', 60, NULL, NULL, NULL, 4),
	(32, 1, '161', 'N', 'N', 'Knowledge Base Setup', 'knowledgeBase/add-knowledgeBase', 'N', 7, 6, NULL, NULL, 4),
	(33, 1, '162', 'N', 'N', 'Register', 'equipmentStatus', 'N', 5, 3, NULL, NULL, 1),
	(34, 1, '163', 'N', 'N', 'Batch Creation', 'batch', 'N', 1, 3, NULL, NULL, 1),
	(35, 1, '164', 'N', 'N', 'Old Equipment Dashboard ', 'equipmentDashboard', 'Y', 3, NULL, NULL, NULL, 1),
	(36, 1, '165', 'N', 'N', 'Summary', 'formReports', 'N', 4, 3, NULL, NULL, 1),
	(37, 1, '166', 'N', 'N', 'Status Update', 'equipmentStatusUpdate', 'N', 2, 3, NULL, NULL, 1),
	(38, 1, '167', 'N', 'N', 'Project Summary', 'projectSummary', 'N', 1, 2, NULL, NULL, 6),
	(39, 1, '168', 'N', 'N', 'Log Mapping', 'formEquipment', 'N', 6, 1, NULL, NULL, 1),
	(40, 1, '170', 'N', 'N', 'Info', 'equipmentDetailDashboard', 'N', 8, 3, NULL, NULL, 1),
	(41, 1, '171', 'N', 'N', 'SMTP Master Setup', 'smtpMasterSetup', 'N', 11, 6, NULL, NULL, 4),
	(42, 1, '169', 'N', 'N', 'Email Template Configuration', 'emailTemplateConfig', 'Y', 12, NULL, NULL, NULL, NULL),
	(43, 1, '173', 'N', 'N', 'Holiday Scheduler', 'calendarView', 'N', 13, 6, NULL, NULL, 4),
	(44, 1, '174', 'N', 'N', 'Email Rule', 'emailRule', 'N', 10, 6, NULL, NULL, 4),
	(45, 1, '176', 'N', 'N', 'Device Master', 'deviceMaster', 'N', 9, 6, NULL, NULL, 1),
	(46, 1, '177', 'N', 'N', 'Template Builder', 'templatebuilder', 'N', 44, 6, NULL, NULL, 4),
	(47, 1, '175', 'N', 'N', 'User Mapping', 'userMapping', 'N', 7, 3, NULL, NULL, 1),
	(48, 1, '178', 'N', 'N', 'Equipment Dashboard', 'newEquipmentDashboard/:id', 'N', 3, 3, NULL, NULL, 1),
	(49, 1, '179', 'N', 'N', 'Calendar View', 'equipmentCalendarView', 'N', 9, 3, NULL, NULL, 4),
	(50, 1, '188', 'N', 'N', 'Email Logs', 'emaillogs', 'N', 100, 4, NULL, NULL, 4),
	(51, 1, '180', 'N', 'N', 'Document Summary', 'documentsummary', 'N', 101, 5, NULL, NULL, 6),
	(52, 1, '181', 'N', 'N', 'Document Approval Status', 'documentapprovalstatus', 'N', 102, 5, NULL, NULL, 5),
	(53, 1, '150', 'N', 'N', 'Test Case Creation', 'tc-creation', 'N', 6, 2, NULL, NULL, 6),
	(54, 1, '189', 'N', 'N', 'Date Format Settings', 'dateFormatSettings', 'N', 14, 6, NULL, NULL, 4),
	(55, 1, '190', 'N', 'N', 'Tasks', 'taskCreation', 'N', 1, 2, NULL, NULL, 4),
	(56, 1, '191', 'Y', 'N', 'Change Control Form', 'ccf', 'N', 34, NULL, NULL, NULL, 3),
	(57, 1, '222', 'N', 'N', 'Workflow Setup', 'commonconfiguration', 'N', 121, 6, NULL, NULL, 4),
	(58, 1, '192', 'N', 'N', 'Periodic Review', 'periodic-review', 'Y', 10, NULL, NULL, NULL, 6),
	(59, 1, '193', 'N', 'N', 'Reports', 'documentsReport', 'N', NULL, NULL, NULL, NULL, 4),
	(60, 1, '194', 'N', 'N', 'TaskReports', 'taskReport', 'N', NULL, NULL, NULL, NULL, 4),
	(61, 1, '195', 'N', 'N', 'MyTasks', 'myTask', 'N', NULL, NULL, NULL, NULL, 4),
	(62, 1, '196', 'N', 'N', 'API Configuration', 'apiConfiguration', 'N', 200, 6, NULL, NULL, 4),
	(63, 1, '197', 'N', 'N', 'Timeline Graph', 'timeline-graph', 'N', NULL, NULL, NULL, NULL, 4),
	(64, 1, '199', 'N', 'N', 'Vendor Master', 'vendor-master', 'N', 11, 1, NULL, NULL, 3),
	(65, 1, '201', 'N', 'N', 'Unscripted Testing', 'Ad-hoc/view-Ad-hoc-testcase', 'N', 10, 2, NULL, NULL, 6),
	(66, 1, '202', 'N', 'N', 'Table of Content', 'table-of-content', 'N', 14, 2, NULL, NULL, 6),
	(67, 1, '198', 'N', 'N', 'TestCase Tracebility Matrix', 'matrix', 'Y', NULL, NULL, NULL, NULL, NULL),
	(68, 1, '203', 'N', 'N', 'Inventory Report', 'inventory-report', 'N', NULL, NULL, NULL, NULL, 4),
	(69, 1, '204', 'N', 'N', 'Draft Pdf', 'draftpdf', 'Y', 102, NULL, NULL, NULL, 6),
	(70, 1, '205', 'N', 'N', 'Requirement Summary', 'requirementSummary', 'N', 15, 2, NULL, NULL, 6),
	(71, 1, '206', 'N', 'N', 'User Acceptance', 'userAcceptance', 'N', 14, 2, 'UAT', NULL, 6),
	(72, 1, '106', 'N', 'N', 'Document Numbering', 'document-numbering', 'N', 3, 6, NULL, NULL, 5),
	(73, 1, '211', 'N', 'N', 'SFTP', 'sftp', 'N', 201, 6, NULL, NULL, 4),
	(74, 1, '114', 'N', 'N', 'GxP Assessment', 'Project-setup/view-projectsetup', 'Y', 1, 1, NULL, NULL, 6),
	(75, 1, '223', 'N', 'N', 'Change Control', 'change-control', 'N', 12, 1, NULL, NULL, 3),
	(76, 1, '224', 'N', 'N', 'ErrroLogs', 'error-logs', 'N', 12, NULL, NULL, NULL, NULL),
	(77, 1, '219', 'N', 'N', 'Cleanroom', 'Clean-room/view-cleanroom', 'N', 202, 1, NULL, NULL, 3),
	(78, 1, '225', 'N', 'N', 'Electronic Signature', 'esign/view-esign', 'N', 204, 1, NULL, NULL, 3),
	(79, 4, '107', 'Y', 'Y', 'User Requirement Specification', 'URS/view-urs', 'N', 4, 2, 'URS', NULL, 6),
	(80, 4, '108', 'Y', 'Y', 'IQTC', 'tc-execution/108', 'N', 7, 2, 'IQ', NULL, 6),
	(81, 4, '109', 'Y', 'Y', 'PQTC', 'tc-execution/109', 'N', 9, 2, 'PQ', NULL, 6),
	(82, 4, '110', 'Y', 'Y', 'OQTC', 'tc-execution/110', 'N', 8, 2, 'OQ', NULL, 6),
	(83, 4, '113', 'Y', 'Y', 'Risk Assessment', 'riskAssessment', 'N', 6, 2, 'FRA', NULL, 6),
	(84, 4, '134', 'N', 'N', 'Discrepancy Form', 'df/view-df', 'N', 11, 2, NULL, NULL, 6),
	(85, 4, '137', 'Y', 'Y', 'VSR', 'Summary-Report/create-summary-report', 'N', 16, 2, 'VSR', NULL, 6),
	(86, 4, '200', 'Y', 'Y', 'Specification', 'sp-master', 'N', 5, 2, 'FS', NULL, 6),
	(87, 4, '207', 'Y', 'Y', 'IOQTC', 'tc-execution/207', 'N', 9, 2, 'IOQ', NULL, 6),
	(88, 4, '208', 'Y', 'Y', 'OPQTC', 'tc-execution/208', 'N', 9, 2, 'OPQ', NULL, 6),
	(89, 6, '91', 'N', 'N', 'MainMenu', 'MainMenu', 'N', 33, NULL, NULL, NULL, 2),
	(90, 7, '121', 'N', 'Y', 'IQTC DF', 'IQTCDF', 'Y', NULL, 2, NULL, NULL, NULL),
	(91, 7, '122', 'N', 'Y', 'OQTC DF', 'OQTCDF', 'Y', NULL, 2, NULL, NULL, NULL),
	(92, 7, '123', 'N', 'Y', 'PQTC DF', 'PQTCDF', 'Y', NULL, 2, NULL, NULL, NULL),
	(93, 7, '209', 'N', 'Y', 'IOQTC DF', 'IOQTCDF', 'Y', NULL, 2, NULL, NULL, NULL),
	(94, 7, '210', 'N', 'Y', 'OPQTC DF', 'OPQTCDF', 'Y', NULL, 2, NULL, NULL, NULL),
	(95, 8, '216', 'N', 'Y', 'IQTC Test Run', 'tc-creation/108', 'Y', NULL, 2, NULL, NULL, NULL),
	(96, 8, '212', 'N', 'Y', 'OQTC Test Run', 'tc-creation/110', 'Y', NULL, 2, NULL, NULL, NULL),
	(97, 8, '213', 'N', 'Y', 'PQTC Test Run', 'tc-creation/109', 'Y', NULL, 2, NULL, NULL, NULL),
	(98, 8, '214', 'N', 'Y', 'IOQTC Test Run', 'tc-creation/207', 'Y', NULL, 2, NULL, NULL, NULL),
	(99, 8, '215', 'N', 'Y', 'OPQTC Test Run', 'tc-creation/208', 'Y', NULL, 2, NULL, NULL, NULL),
	(100, 1, '226', 'N', 'N', 'Organization Profile', 'user/org-profile', 'N', NULL, NULL, NULL, NULL, 2),
	(101, 1, '220', 'N', 'N', 'Statistical Process Control', 'statistical-process-control', 'N', 203, 1, NULL, NULL, 3),
	(102, 1, '230', 'N', 'N', 'Template Library', 'templatelibrary/view-library', 'N', 205, 6, NULL, NULL, 4);
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;

-- Dumping structure for table license_db.permission_category
DROP TABLE IF EXISTS `permission_category`;
CREATE TABLE IF NOT EXISTS `permission_category` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.permission_category: ~8 rows (approximately)
DELETE FROM `permission_category`;
/*!40000 ALTER TABLE `permission_category` DISABLE KEYS */;
INSERT INTO `permission_category` (`id`, `category`) VALUES
	(7, 'Discrepancy_Form'),
	(4, 'Document'),
	(2, 'Form'),
	(5, 'Form_Group'),
	(1, 'Link'),
	(6, 'Static_Documents'),
	(3, 'Template'),
	(8, 'Test_Run');
/*!40000 ALTER TABLE `permission_category` ENABLE KEYS */;

-- Dumping structure for table license_db.priority
DROP TABLE IF EXISTS `priority`;
CREATE TABLE IF NOT EXISTS `priority` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `priority_code` varchar(50) DEFAULT NULL,
  `priority_name` varchar(50) DEFAULT NULL,
  `priority_color` varchar(50) DEFAULT NULL,
  `deleted_flag` char(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `lasted_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` datetime NOT NULL,
  `organization_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_priority_users` (`created_by`),
  KEY `FK_priority_users_2` (`last_updated_by`),
  CONSTRAINT `FK_priority_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_priority_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.priority: ~0 rows (approximately)
DELETE FROM `priority`;
/*!40000 ALTER TABLE `priority` DISABLE KEYS */;
/*!40000 ALTER TABLE `priority` ENABLE KEYS */;

-- Dumping structure for table license_db.priority_default_values
DROP TABLE IF EXISTS `priority_default_values`;
CREATE TABLE IF NOT EXISTS `priority_default_values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `priority_code` varchar(50) DEFAULT NULL,
  `priority_name` varchar(50) DEFAULT NULL,
  `priority_color` varchar(50) DEFAULT NULL,
  `deleted_flag` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.priority_default_values: ~7 rows (approximately)
DELETE FROM `priority_default_values`;
/*!40000 ALTER TABLE `priority_default_values` DISABLE KEYS */;
INSERT INTO `priority_default_values` (`id`, `priority_code`, `priority_name`, `priority_color`, `deleted_flag`) VALUES
	(1, 'L', 'Low', '#0de51b', 'N'),
	(2, 'M', 'Medium', '#eeff01 ', 'N'),
	(3, 'H', 'High', '#f00202', 'N'),
	(4, 'minor', 'Minor', '#42cddb', 'N'),
	(5, 'moderate', 'Moderate', '#de93eb', 'N'),
	(6, 'major', 'Major', '#f79d12', 'N'),
	(7, 'critical', 'Critical', '#e70c0c', 'N');
/*!40000 ALTER TABLE `priority_default_values` ENABLE KEYS */;

-- Dumping structure for table license_db.process_validation
DROP TABLE IF EXISTS `process_validation`;
CREATE TABLE IF NOT EXISTS `process_validation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `shift_id` bigint(20) unsigned NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  `product` varchar(50) NOT NULL,
  `batch` varchar(50) NOT NULL,
  `weight_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`weight_json`)),
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__shift_master` (`shift_id`) USING BTREE,
  KEY `FK__equipment` (`equipment_id`) USING BTREE,
  KEY `FK_process_validation_users` (`created_by`) USING BTREE,
  KEY `FK_process_validation_organization_info` (`org_id`) USING BTREE,
  CONSTRAINT `FK__equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK__shift_master` FOREIGN KEY (`shift_id`) REFERENCES `shift_master` (`id`),
  CONSTRAINT `FK_process_validation_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_process_validation_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.process_validation: ~0 rows (approximately)
DELETE FROM `process_validation`;
/*!40000 ALTER TABLE `process_validation` DISABLE KEYS */;
/*!40000 ALTER TABLE `process_validation` ENABLE KEYS */;

-- Dumping structure for table license_db.project_clone_documents
DROP TABLE IF EXISTS `project_clone_documents`;
CREATE TABLE IF NOT EXISTS `project_clone_documents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_clone_documents_project_setup` (`project_id`),
  CONSTRAINT `FK_project_clone_documents_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_clone_documents: ~0 rows (approximately)
DELETE FROM `project_clone_documents`;
/*!40000 ALTER TABLE `project_clone_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_clone_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.project_document_custom_pdf
DROP TABLE IF EXISTS `project_document_custom_pdf`;
CREATE TABLE IF NOT EXISTS `project_document_custom_pdf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `file_name` varchar(100) NOT NULL,
  `file_path` varchar(250) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_project_document_custom_pdf_project_version` (`version_id`) USING BTREE,
  KEY `FK_project_document_custom_pdf_users` (`created_by`),
  CONSTRAINT `FK_project_document_custom_pdf_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_project_document_custom_pdf_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT=' ';

-- Dumping data for table license_db.project_document_custom_pdf: ~0 rows (approximately)
DELETE FROM `project_document_custom_pdf`;
/*!40000 ALTER TABLE `project_document_custom_pdf` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_document_custom_pdf` ENABLE KEYS */;

-- Dumping structure for table license_db.project_document_forms
DROP TABLE IF EXISTS `project_document_forms`;
CREATE TABLE IF NOT EXISTS `project_document_forms` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) NOT NULL,
  `master_form_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_document_forms: ~0 rows (approximately)
DELETE FROM `project_document_forms`;
/*!40000 ALTER TABLE `project_document_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_document_forms` ENABLE KEYS */;

-- Dumping structure for table license_db.project_document_pdf
DROP TABLE IF EXISTS `project_document_pdf`;
CREATE TABLE IF NOT EXISTS `project_document_pdf` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_file_path` varchar(200) NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL DEFAULT 262,
  `updated_time` datetime NOT NULL,
  `updated_by` bigint(20) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_project_document_pdf_project_setup` (`project_id`),
  KEY `FK_project_document_pdf_permissions` (`document_type`),
  KEY `FK_project_document_pdf_project_version` (`version_id`),
  CONSTRAINT `FK_project_document_pdf_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_project_document_pdf_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_project_document_pdf_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_document_pdf: ~0 rows (approximately)
DELETE FROM `project_document_pdf`;
/*!40000 ALTER TABLE `project_document_pdf` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_document_pdf` ENABLE KEYS */;

-- Dumping structure for table license_db.project_plan
DROP TABLE IF EXISTS `project_plan`;
CREATE TABLE IF NOT EXISTS `project_plan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `start_date` datetime DEFAULT current_timestamp(),
  `end_date` datetime DEFAULT current_timestamp(),
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `actual_start_date` datetime DEFAULT current_timestamp(),
  `actual_end_date` datetime DEFAULT current_timestamp(),
  `descripition` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_plan_organization_info` (`organization_id`),
  KEY `FK_project_plan_permissions` (`document_type`),
  KEY `FK_project_plan_project_setup` (`project_id`),
  KEY `FK_project_plan_users` (`created_by`),
  KEY `FK_project_plan_users_2` (`updated_by`),
  CONSTRAINT `FK_project_plan_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_project_plan_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_project_plan_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_project_plan_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_project_plan_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_plan: ~0 rows (approximately)
DELETE FROM `project_plan`;
/*!40000 ALTER TABLE `project_plan` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_plan` ENABLE KEYS */;

-- Dumping structure for table license_db.project_setup
DROP TABLE IF EXISTS `project_setup`;
CREATE TABLE IF NOT EXISTS `project_setup` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `project_code` varchar(50) NOT NULL,
  `introduction` longtext DEFAULT NULL,
  `purpose_and_scope` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `create_project_wizard_id` bigint(20) DEFAULT NULL,
  `default_flag` varchar(1) NOT NULL DEFAULT 'N',
  `freeze_flag` varchar(1) DEFAULT 'N' COMMENT 'validation summary report',
  `parent_project` bigint(20) DEFAULT NULL COMMENT 'project parent id',
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `start_date` varchar(50) DEFAULT '{"year":2020,"month":7,"day":1}',
  `end_date` varchar(50) DEFAULT '{"year":2020,"month":07,"day":29}',
  `system_owner_id` bigint(20) DEFAULT NULL,
  `custom_ccf_value` varchar(50) DEFAULT NULL,
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `published_time` timestamp NULL DEFAULT NULL,
  `validation_status` varchar(50) DEFAULT NULL,
  `system_status` varchar(50) DEFAULT NULL,
  `release_date` varchar(50) DEFAULT NULL,
  `project_type` varchar(50) NOT NULL DEFAULT 'Computer System Validation',
  PRIMARY KEY (`id`),
  KEY `FK_project_setup_users_2` (`created_by`),
  KEY `FK_project_setup_users` (`last_updated_by`),
  KEY `FK_project_setup_organization_info` (`organization_id`),
  CONSTRAINT `FK_project_setup_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_project_setup_users_09` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_project_setup_users_20` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_setup: ~0 rows (approximately)
DELETE FROM `project_setup`;
/*!40000 ALTER TABLE `project_setup` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_setup` ENABLE KEYS */;

-- Dumping structure for table license_db.project_setup_location
DROP TABLE IF EXISTS `project_setup_location`;
CREATE TABLE IF NOT EXISTS `project_setup_location` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_project_setup_location_project_setup` (`project_id`) USING BTREE,
  KEY `FK_project_setup_location_location` (`location_id`) USING BTREE,
  CONSTRAINT `FK_project_setup_location_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_project_setup_location_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_setup_location: ~0 rows (approximately)
DELETE FROM `project_setup_location`;
/*!40000 ALTER TABLE `project_setup_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_setup_location` ENABLE KEYS */;

-- Dumping structure for table license_db.project_setup_system_description
DROP TABLE IF EXISTS `project_setup_system_description`;
CREATE TABLE IF NOT EXISTS `project_setup_system_description` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `equipment` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `gxp_form_flag` varchar(1) NOT NULL DEFAULT 'N',
  `software_name` varchar(50) DEFAULT NULL,
  `software_version` varchar(50) DEFAULT NULL,
  `gxp_criticality` varchar(50) DEFAULT NULL,
  `system_use` varchar(50) DEFAULT NULL,
  `er_applicability` varchar(50) DEFAULT NULL,
  `es_applicability` varchar(50) DEFAULT NULL,
  `type_of_system` varchar(50) DEFAULT NULL,
  `validation_strategy` longtext DEFAULT NULL,
  `acceptance_criteria` longtext DEFAULT NULL,
  `gamp_id` bigint(20) unsigned DEFAULT NULL,
  `vendor_master_id` bigint(20) unsigned DEFAULT NULL,
  `hosting_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_setup_system_description_project_setup` (`project_id`),
  KEY `FK_project_setup_system_description_equipment` (`equipment`),
  KEY `FK_project_setup_system_description_vendor_master` (`vendor_master_id`),
  CONSTRAINT `FK_project_setup_system_description_equipment` FOREIGN KEY (`equipment`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_project_setup_system_description_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_project_setup_system_description_vendor_master` FOREIGN KEY (`vendor_master_id`) REFERENCES `vendor_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_setup_system_description: ~0 rows (approximately)
DELETE FROM `project_setup_system_description`;
/*!40000 ALTER TABLE `project_setup_system_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_setup_system_description` ENABLE KEYS */;

-- Dumping structure for table license_db.project_tasks
DROP TABLE IF EXISTS `project_tasks`;
CREATE TABLE IF NOT EXISTS `project_tasks` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `organization_id` bigint(20) unsigned NOT NULL DEFAULT 2,
  `task_code` varchar(50) DEFAULT NULL,
  `task_category` varchar(50) DEFAULT NULL,
  `completed_flag` varchar(1) NOT NULL,
  `delete_flag` varchar(1) NOT NULL,
  `description` longtext DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `start_timer_flag` varchar(1) DEFAULT 'Y',
  `end_timer_flag` varchar(1) DEFAULT 'N',
  `frequency` varchar(255) DEFAULT NULL,
  `priority` varchar(50) NOT NULL,
  `remainder_flag` varchar(1) NOT NULL,
  `status` varchar(50) NOT NULL,
  `task_title` varchar(300) NOT NULL,
  `updated_time` datetime NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) NOT NULL,
  `is_manual_entry` varchar(1) DEFAULT 'Y',
  `draft_level_id` bigint(20) DEFAULT NULL,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9bb3rlxodh3yyrx8rfq354q93` (`project_id`),
  KEY `FK6rfhpysnxbknjldw7s1lql0we` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_tasks: ~0 rows (approximately)
DELETE FROM `project_tasks`;
/*!40000 ALTER TABLE `project_tasks` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tasks` ENABLE KEYS */;

-- Dumping structure for table license_db.project_tasks_equipments
DROP TABLE IF EXISTS `project_tasks_equipments`;
CREATE TABLE IF NOT EXISTS `project_tasks_equipments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_tasks_id` bigint(20) NOT NULL,
  `equipment_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_tasks_equipments_equipment` (`equipment_id`),
  KEY `FK_project_tasks_equipments_project_tasks` (`project_tasks_id`),
  CONSTRAINT `FK_project_tasks_equipments_equipment` FOREIGN KEY (`equipment_id`) REFERENCES `equipment` (`id`),
  CONSTRAINT `FK_project_tasks_equipments_project_tasks` FOREIGN KEY (`project_tasks_id`) REFERENCES `project_tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_tasks_equipments: ~0 rows (approximately)
DELETE FROM `project_tasks_equipments`;
/*!40000 ALTER TABLE `project_tasks_equipments` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_tasks_equipments` ENABLE KEYS */;

-- Dumping structure for table license_db.project_task_documents
DROP TABLE IF EXISTS `project_task_documents`;
CREATE TABLE IF NOT EXISTS `project_task_documents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_type` varchar(50) NOT NULL,
  `project_task_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKdiefn9hgx94lqn6rws4w0wyld` (`document_type`),
  KEY `FK6jlruyiyhw7064sue5dbyp71q` (`project_task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_task_documents: ~0 rows (approximately)
DELETE FROM `project_task_documents`;
/*!40000 ALTER TABLE `project_task_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.project_task_document_ids
DROP TABLE IF EXISTS `project_task_document_ids`;
CREATE TABLE IF NOT EXISTS `project_task_document_ids` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `document_code` varchar(50) NOT NULL,
  `document_id` varchar(50) NOT NULL,
  `project_task_document_id` bigint(20) NOT NULL,
  `doc_id` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `version_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK310s0mrbk17u7t1tks890013w` (`project_task_document_id`),
  CONSTRAINT `FK_project_task_document_ids_project_task_documents` FOREIGN KEY (`project_task_document_id`) REFERENCES `project_task_documents` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_task_document_ids: ~0 rows (approximately)
DELETE FROM `project_task_document_ids`;
/*!40000 ALTER TABLE `project_task_document_ids` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_document_ids` ENABLE KEYS */;

-- Dumping structure for table license_db.project_task_files
DROP TABLE IF EXISTS `project_task_files`;
CREATE TABLE IF NOT EXISTS `project_task_files` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `file_path` varchar(200) NOT NULL,
  `project_task_id` bigint(20) NOT NULL,
  `upload_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FKbk7omu8yacdt60ydsmcpqkbym` (`project_task_id`),
  CONSTRAINT `FK_project_task_files_project_tasks` FOREIGN KEY (`project_task_id`) REFERENCES `project_tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_task_files: ~0 rows (approximately)
DELETE FROM `project_task_files`;
/*!40000 ALTER TABLE `project_task_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_files` ENABLE KEYS */;

-- Dumping structure for table license_db.project_task_time_tracking
DROP TABLE IF EXISTS `project_task_time_tracking`;
CREATE TABLE IF NOT EXISTS `project_task_time_tracking` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_task_id` bigint(20) DEFAULT NULL,
  `start_date_time` timestamp NULL DEFAULT NULL,
  `end_date_time` timestamp NULL DEFAULT NULL,
  `active_flag` varchar(1) DEFAULT 'Y',
  `created_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `comments` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_project_task_time_tracking_users` (`created_by`),
  KEY `FK_project_task_time_tracking_project_tasks` (`project_task_id`),
  CONSTRAINT `FK_project_task_time_tracking_project_tasks` FOREIGN KEY (`project_task_id`) REFERENCES `project_tasks` (`id`),
  CONSTRAINT `FK_project_task_time_tracking_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_task_time_tracking: ~0 rows (approximately)
DELETE FROM `project_task_time_tracking`;
/*!40000 ALTER TABLE `project_task_time_tracking` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_time_tracking` ENABLE KEYS */;

-- Dumping structure for table license_db.project_task_users
DROP TABLE IF EXISTS `project_task_users`;
CREATE TABLE IF NOT EXISTS `project_task_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKpyb9x52rqiu61xkfpjo7mpy9p` (`project_task_id`),
  KEY `FKlhmy9e91h5enflbqg275ter78` (`user_id`),
  CONSTRAINT `FK_project_task_users_project_tasks` FOREIGN KEY (`project_task_id`) REFERENCES `project_tasks` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_task_users: ~0 rows (approximately)
DELETE FROM `project_task_users`;
/*!40000 ALTER TABLE `project_task_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_task_users` ENABLE KEYS */;

-- Dumping structure for table license_db.project_template_settings
DROP TABLE IF EXISTS `project_template_settings`;
CREATE TABLE IF NOT EXISTS `project_template_settings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_time` datetime DEFAULT NULL,
  `template_for` varchar(50) NOT NULL,
  `updated_time` datetime DEFAULT NULL,
  `updated_by` bigint(20) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `template_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK750bp6ya4u9meeot0j7juo5f0` (`updated_by`),
  KEY `FK62tcf5njvei9r1kbaglodl0rj` (`created_by`),
  KEY `FKrrhp7af96fiq0fgibgsah7a2l` (`template_id`),
  KEY `FK383nxvaeyxs734u8q38xhuxhb` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_template_settings: 0 rows
DELETE FROM `project_template_settings`;
/*!40000 ALTER TABLE `project_template_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_template_settings` ENABLE KEYS */;

-- Dumping structure for table license_db.project_url_checklist
DROP TABLE IF EXISTS `project_url_checklist`;
CREATE TABLE IF NOT EXISTS `project_url_checklist` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `title` varchar(200) DEFAULT NULL,
  `url` varchar(200) DEFAULT NULL,
  `document_type` varchar(50) DEFAULT NULL,
  `form_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_project_url_checklist_project_setup` (`project_id`) USING BTREE,
  KEY `FK_project_url_checklist_permissions` (`document_type`) USING BTREE,
  KEY `FK_project_url_checklist_dynamic_form` (`form_id`) USING BTREE,
  KEY `FK_project_url_checklist_users` (`created_by`) USING BTREE,
  CONSTRAINT `FK_project_url_checklist_dynamic_form` FOREIGN KEY (`form_id`) REFERENCES `dynamic_form` (`id`),
  CONSTRAINT `FK_project_url_checklist_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_project_url_checklist_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_project_url_checklist_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_url_checklist: ~0 rows (approximately)
DELETE FROM `project_url_checklist`;
/*!40000 ALTER TABLE `project_url_checklist` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_url_checklist` ENABLE KEYS */;

-- Dumping structure for table license_db.project_version
DROP TABLE IF EXISTS `project_version`;
CREATE TABLE IF NOT EXISTS `project_version` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `version_name` varchar(50) NOT NULL DEFAULT '0',
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  PRIMARY KEY (`id`),
  KEY `FK__project_setup` (`project_id`),
  CONSTRAINT `FK__project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_version: ~0 rows (approximately)
DELETE FROM `project_version`;
/*!40000 ALTER TABLE `project_version` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_version` ENABLE KEYS */;

-- Dumping structure for table license_db.project_version_and_document_version_mapping
DROP TABLE IF EXISTS `project_version_and_document_version_mapping`;
CREATE TABLE IF NOT EXISTS `project_version_and_document_version_mapping` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `document_version_id` bigint(20) unsigned NOT NULL,
  `project_version_id` bigint(20) unsigned NOT NULL,
  `active_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `review_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__project_version` (`project_version_id`),
  KEY `FK__document_version` (`document_version_id`),
  CONSTRAINT `FK__document_version` FOREIGN KEY (`document_version_id`) REFERENCES `document_version` (`id`),
  CONSTRAINT `FK__project_version` FOREIGN KEY (`project_version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.project_version_and_document_version_mapping: ~0 rows (approximately)
DELETE FROM `project_version_and_document_version_mapping`;
/*!40000 ALTER TABLE `project_version_and_document_version_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `project_version_and_document_version_mapping` ENABLE KEYS */;

-- Dumping structure for table license_db.responsibility
DROP TABLE IF EXISTS `responsibility`;
CREATE TABLE IF NOT EXISTS `responsibility` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `flow_level_child_id` varchar(50) DEFAULT NULL,
  `userid` bigint(20) unsigned NOT NULL,
  `projectid` bigint(20) unsigned NOT NULL,
  `doctype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.responsibility: ~0 rows (approximately)
DELETE FROM `responsibility`;
/*!40000 ALTER TABLE `responsibility` DISABLE KEYS */;
/*!40000 ALTER TABLE `responsibility` ENABLE KEYS */;

-- Dumping structure for table license_db.revision_for_documents
DROP TABLE IF EXISTS `revision_for_documents`;
CREATE TABLE IF NOT EXISTS `revision_for_documents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `changes` varchar(255) DEFAULT NULL,
  `created_time` datetime NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `version_name` varchar(50) NOT NULL,
  `orgnization_id` bigint(20) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8go0r3fpx15db8vmf1s31a2v7` (`orgnization_id`),
  KEY `FK1l6lkd2c480rhxphfhdw89ve3` (`document_type`),
  KEY `FKh76p2wq5a3m5heh2t9euitqoh` (`created_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.revision_for_documents: 0 rows
DELETE FROM `revision_for_documents`;
/*!40000 ALTER TABLE `revision_for_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `revision_for_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_assessment
DROP TABLE IF EXISTS `risk_assessment`;
CREATE TABLE IF NOT EXISTS `risk_assessment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `risk_factor` longtext DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `risk_scenario` longtext NOT NULL,
  `proposed_mitigation` longtext DEFAULT NULL,
  `probable_cause_of_risk` longtext DEFAULT NULL,
  `assement_code` varchar(50) NOT NULL,
  `probability_of_occurance` bigint(20) unsigned NOT NULL,
  `serverity` bigint(20) unsigned NOT NULL,
  `detetablity` bigint(20) unsigned NOT NULL,
  `risk_class` int(11) DEFAULT NULL,
  `priority` bigint(20) unsigned NOT NULL,
  `delete_flag` char(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `document_status` int(11) DEFAULT NULL,
  `revision_number` bigint(20) DEFAULT NULL,
  `published` varchar(1) DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `rpn` int(11) DEFAULT NULL,
  `critical` int(11) DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `reviewed_by` bigint(20) DEFAULT NULL,
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `version_id` bigint(20) unsigned NOT NULL,
  `residual_flag` varchar(1) NOT NULL DEFAULT 'N',
  `residual_probability` bigint(20) DEFAULT NULL,
  `residual_serverity` bigint(20) DEFAULT NULL,
  `residual_detetablity` bigint(20) DEFAULT NULL,
  `residual_priority` bigint(20) DEFAULT NULL,
  `residual_rpn` int(11) DEFAULT NULL,
  `residual_critical` int(11) DEFAULT NULL,
  `residual_conclusion` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_risk_assessment_project_setup` (`project_id`),
  KEY `FK_risk_assessment_users` (`created_by`),
  KEY `FK_risk_assessment_users_2` (`last_updated_by`),
  KEY `FK_risk_assessment_risk_priority_master` (`probability_of_occurance`),
  KEY `FK_risk_assessment_risk_priority_master_2` (`serverity`),
  KEY `FK_risk_assessment_risk_priority_master_3` (`detetablity`),
  KEY `FK_risk_assessment_risk_priority_master_4` (`priority`),
  KEY `FK_risk_assessment_project_version` (`version_id`),
  CONSTRAINT `FK_risk_assessment_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_risk_assessment_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_risk_assessment_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_risk_assessment_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_assessment: ~0 rows (approximately)
DELETE FROM `risk_assessment`;
/*!40000 ALTER TABLE `risk_assessment` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_assessment` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_assessment_template
DROP TABLE IF EXISTS `risk_assessment_template`;
CREATE TABLE IF NOT EXISTS `risk_assessment_template` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tittle` varchar(50) DEFAULT NULL,
  `body` longtext DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_flag` char(1) NOT NULL DEFAULT 'N',
  `project_id` bigint(20) NOT NULL,
  `template_code` varchar(50) DEFAULT NULL,
  `document_status` int(11) DEFAULT NULL,
  `published` varchar(1) DEFAULT 'N',
  `approved_time` datetime NOT NULL,
  `approver_comment` varchar(255) DEFAULT NULL,
  `reviewed_time` datetime NOT NULL,
  `reviewer_comment` varchar(255) DEFAULT NULL,
  `approved_by` bigint(20) DEFAULT NULL,
  `reviewed_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_risk_assessment_template_users` (`created_by`),
  KEY `FK_risk_assessment_template_users_2` (`last_updated_by`),
  CONSTRAINT `FK_risk_assessment_template_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_risk_assessment_template_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_assessment_template: ~0 rows (approximately)
DELETE FROM `risk_assessment_template`;
/*!40000 ALTER TABLE `risk_assessment_template` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_assessment_template` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_lookup_value
DROP TABLE IF EXISTS `risk_lookup_value`;
CREATE TABLE IF NOT EXISTS `risk_lookup_value` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `key` varchar(50) NOT NULL,
  `value` varchar(200) NOT NULL,
  `description` longtext DEFAULT NULL,
  `active_flag` varchar(1) NOT NULL,
  `display_order` int(11) NOT NULL DEFAULT 0,
  `created_time` timestamp NULL DEFAULT current_timestamp(),
  `last_updated_time` timestamp NULL DEFAULT current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `default_matrix_size` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK1_created` (`created_by`),
  KEY `FK2_updated` (`last_updated_by`),
  CONSTRAINT `FK1_created` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK2_updated` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_lookup_value: ~64 rows (approximately)
DELETE FROM `risk_lookup_value`;
/*!40000 ALTER TABLE `risk_lookup_value` DISABLE KEYS */;
INSERT INTO `risk_lookup_value` (`id`, `name`, `key`, `value`, `description`, `active_flag`, `display_order`, `created_time`, `last_updated_time`, `created_by`, `last_updated_by`, `default_matrix_size`) VALUES
	(1, 'RPNProbability', '10', 'Very high', 'Failure is almost inevitable ( 1 per day or > 3 in 10 Units)', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(2, 'RPNProbability', '9', 'Very high', 'Failure is almost inevitable ( 1 per 3 to 4 days or =3 in 10 Units)', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(3, 'RPNProbability', '8', 'High', 'Repeated failures ( 1 per week or =5 in 100 Units)', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(4, 'RPNProbability', '7', 'High', 'Repeated failures ( 1 per months or =1 in 100 Units)', 'Y', 4, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(5, 'RPNProbability', '6', 'Moderate', 'Occasional Failures ( 1 per 3 months or =3 in 1000 Units)', 'Y', 5, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(6, 'RPNProbability', '5', 'Moderate', 'Occasional Failures ( 1 per 6 months to 1 Year or =1 in 10,000 Units)', 'Y', 6, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(7, 'RPNProbability', '4', 'Moderate', 'Occasional Failures ( 1 per Year or =6 in 100,000 Units)', 'Y', 7, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(8, 'RPNProbability', '3', 'Low', 'Relatively few Failures ( 1 per 1 to 3 Years or =6 in 10,000,000 Units)', 'Y', 8, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(9, 'RPNProbability', '2', 'Low', 'Relatively few Failures ( 1 per 3 to 5 Years or =2 in 1,000,000,000 Units)', 'Y', 9, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(10, 'RPNProbability', '1', 'No Effect', 'Failure is unlikely ( 1 per >5 Years or <2 in 1,000,000,000 Units)', 'Y', 10, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(11, 'RPNSeverity', '10', 'Dangerously high', 'Failure could lead to death or permanent injury to the customer.', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(12, 'RPNSeverity', '9', 'Extremely high', 'Failure could lead to injury to the customer. Failure could create non-compliance with registered specifications. Failure likely to lead to recall.', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(13, 'RPNSeverity', '8', 'Very high', 'Failure could lead to adverse reaction to customer. Failure would create noncompliance with GMP regulations or product registrations. Failure possible to lead to recall.', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(14, 'RPNSeverity', '7', 'High', 'Failure leads to customer perception of safety issue. Failure renders individual unit(s) unusable. Failure causes a high degree of customer dissatisfaction. Recall for business reasons possible but authority required recall unlikely.', 'Y', 4, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(15, 'RPNSeverity', '6', 'Moderate', 'Failure causes a high degree of customer dissatisfaction and numerous compliants. Failure unlikely to lead to recall.', 'Y', 5, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(16, 'RPNSeverity', '5', 'Low', 'Failure likely to cause isolated customer complaints.', 'Y', 6, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(17, 'RPNSeverity', '4', 'Very Low', 'Failure relates to non-dosage form issues(like minor packaging problems) and can be easily overcome by the customer.', 'Y', 7, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(18, 'RPNSeverity', '3', 'Minor', 'Failure could be noticed by the customer but is unlikely to be perceived as significant enough to warrant a complaint.', 'Y', 8, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(19, 'RPNSeverity', '2', 'Very Minor', 'Failure not readily apparent to the customer.', 'Y', 9, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(20, 'RPNSeverity', '1', 'None', 'Failure would not be noticeable to the customer.', 'Y', 10, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(21, 'RPNDetectability', '10', 'Impossible', 'The product is not inspected or the defect caused by the failure is not detectable.', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(22, 'RPNDetectability', '9', 'Very Remote', 'Product is sampled, inspected, and released based on Acceptable Quality Level (AQL) sampling plans.', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(23, 'RPNDetectability', '8', 'Remote', 'Product is accepted based on no defects in a sample.', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(24, 'RPNDetectability', '7', 'Very Low', 'Product is accepted based on double inspecting and  no defects in a sample.', 'Y', 4, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(25, 'RPNDetectability', '6', 'Low', 'Product is 100% manually inspected in the process.', 'Y', 5, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(26, 'RPNDetectability', '5', 'Moderate', 'Product is 100% manually inspected using go/no-go or other mistake-proofing guages.', 'Y', 6, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(27, 'RPNDetectability', '4', 'Moderately high', 'Some Statistical Process Control (SPC) is used in the process and product is final inspected off-line.', 'Y', 7, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(28, 'RPNDetectability', '3', 'High', 'SPC is used and there is immediate reaction to out-of-control conditions.', 'Y', 8, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(29, 'RPNDetectability', '2', 'Very high', 'All product is 100% automatically inspected.', 'Y', 9, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(30, 'RPNDetectability', '1', 'Almost Certain', 'The defect is obvious and there is 100% automatic inspection with regular calibration and preventive maintenance of the inspection equipment.', 'Y', 10, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(31, 'RPNPriority', '3', 'High', NULL, 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(32, 'RPNPriority', '2', 'Medium', NULL, 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(33, 'RPNPriority', '1', 'Low', NULL, 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 10),
	(52, 'RPNProbability', '3', 'High', 'Repeated failures ( 1 per week or =5 in 100 Units)', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(53, 'RPNProbability', '2', 'Moderate', 'Occasional Failures ( 1 per 3 months or =3 in 1000 Units)', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(54, 'RPNProbability', '1', 'Low', 'Relatively few Failures ( 1 per 1 to 3 Years or =6 in 10,000,000 Units)', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(55, 'RPNSeverity', '3', 'High', 'Failure leads to customer perception of safety issue. Failure renders individual unit(s) unusable. Failure causes a high degree of customer dissatisfaction. Recall for business reasons possible but authority required recall unlikely.', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(56, 'RPNSeverity', '2', 'Moderate', 'Failure causes a high degree of customer dissatisfaction and numerous compliants. Failure unlikely to lead to recall.', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(57, 'RPNSeverity', '1', 'Low', 'Failure likely to cause isolated customer complaints.', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(58, 'RPNDetectability', '3', 'Low', 'Product is 100% manually inspected in the process.', 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(59, 'RPNDetectability', '2', 'Moderate', 'Product is 100% manually inspected using go/no-go or other mistake-proofing guages.', 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(60, 'RPNDetectability', '1', 'High', 'SPC is used and there is immediate reaction to out-of-control conditions.', 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(61, 'RPNPriority', '3', 'High', NULL, 'Y', 1, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(62, 'RPNPriority', '2', 'Medium', NULL, 'Y', 2, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(63, 'RPNPriority', '1', 'Low', NULL, 'Y', 3, '2020-11-18 17:10:18', '2020-11-18 17:10:18', 1, 1, 3),
	(64, 'RPNProbability', '5', 'Frequent', 'Daily/Weekly occrance', 'Y', 1, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(65, 'RPNProbability', '4', 'Probable', 'Happens once per month', 'Y', 2, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(66, 'RPNProbability', '3', 'Occasional', 'Happens once per quarter', 'Y', 3, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(67, 'RPNProbability', '2', 'Remote', 'Happens once per year', 'Y', 4, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(68, 'RPNProbability', '1', 'Improbable', 'Less than once per year', 'Y', 5, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(69, 'RPNSeverity', '5', 'Hazardous', 'Intolerable risk', 'Y', 1, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(70, 'RPNSeverity', '4', 'Serious', 'undesirable risk tolearble only.If reduction is impractical or technology doesnt exist.', 'Y', 2, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(71, 'RPNSeverity', '3', 'Moderate', 'Tolerable risk if the cost is too great for the improvement gained', 'Y', 3, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(72, 'RPNSeverity', '2', 'Minor', 'Tolerable risk', 'Y', 4, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(73, 'RPNSeverity', '1', 'No Effect', 'Negligible risk', 'Y', 5, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(74, 'RPNDetectability', '5', 'lack of detection', 'Very poor detection in place (lack of detection)', 'Y', 1, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(75, 'RPNDetectability', '4', 'Almost certain', 'Detection are deemed insufficient to stop a hazard from being reported(Almost certain)', 'Y', 2, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(76, 'RPNDetectability', '3', 'Might detect', 'Detection are in place but are deemed insufficient from some scenarious(Might detect)', 'Y', 3, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(77, 'RPNDetectability', '2', 'Will detect', 'At least one detection is in place for all known scenarious and detection are deemed sufficient to stop a hazard from being reported(Will detect)', 'Y', 4, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(78, 'RPNDetectability', '1', 'Always detected', 'Detection is deemed sufficient to stop all known hazards fro occurring (always detected)', 'Y', 5, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(79, 'RPNPriority', '4', 'Critical', NULL, 'Y', 1, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(80, 'RPNPriority', '3', 'Major', NULL, 'Y', 2, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(81, 'RPNPriority', '2', 'Moderate', NULL, 'Y', 3, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5),
	(82, 'RPNPriority', '1', 'Minor', NULL, 'Y', 4, '2021-01-13 18:47:43', '2021-01-13 18:47:43', 1, 1, 5);
/*!40000 ALTER TABLE `risk_lookup_value` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_priority_master
DROP TABLE IF EXISTS `risk_priority_master`;
CREATE TABLE IF NOT EXISTS `risk_priority_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_priority_master: ~3 rows (approximately)
DELETE FROM `risk_priority_master`;
/*!40000 ALTER TABLE `risk_priority_master` DISABLE KEYS */;
INSERT INTO `risk_priority_master` (`id`, `name`) VALUES
	(1, 'High'),
	(2, 'Medium'),
	(3, 'Low');
/*!40000 ALTER TABLE `risk_priority_master` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_spec_items
DROP TABLE IF EXISTS `risk_spec_items`;
CREATE TABLE IF NOT EXISTS `risk_spec_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `risk_id` bigint(20) unsigned NOT NULL,
  `spec_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__risk_assessment` (`risk_id`),
  KEY `FK_risk_spec_items_specification_master` (`spec_id`),
  CONSTRAINT `FK__risk_assessment` FOREIGN KEY (`risk_id`) REFERENCES `risk_assessment` (`id`),
  CONSTRAINT `FK_risk_spec_items_specification_master` FOREIGN KEY (`spec_id`) REFERENCES `specification_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_spec_items: ~0 rows (approximately)
DELETE FROM `risk_spec_items`;
/*!40000 ALTER TABLE `risk_spec_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_spec_items` ENABLE KEYS */;

-- Dumping structure for table license_db.risk_urs
DROP TABLE IF EXISTS `risk_urs`;
CREATE TABLE IF NOT EXISTS `risk_urs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `risk_id` bigint(20) unsigned NOT NULL,
  `urs_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_risk_urs_risk_assessment` (`risk_id`),
  KEY `FK_risk_urs_urs` (`urs_id`),
  CONSTRAINT `FK_risk_urs_risk_assessment` FOREIGN KEY (`risk_id`) REFERENCES `risk_assessment` (`id`),
  CONSTRAINT `FK_risk_urs_urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.risk_urs: ~0 rows (approximately)
DELETE FROM `risk_urs`;
/*!40000 ALTER TABLE `risk_urs` DISABLE KEYS */;
/*!40000 ALTER TABLE `risk_urs` ENABLE KEYS */;

-- Dumping structure for table license_db.roles
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `is_admin` varchar(1) NOT NULL DEFAULT 'N',
  `active_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `1` (`created_by`),
  KEY `FK_roles_users` (`updated_by`),
  KEY `FK_roles_organization_info` (`organization_id`),
  CONSTRAINT `1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_roles_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_roles_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.roles: ~0 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `created_by`, `organization_id`, `created_time`, `updated_by`, `updated_time`, `is_admin`, `active_flag`) VALUES
	(1, 'Application Admin', 1, NULL, '2021-03-12 11:29:56', 1, '2021-03-12 11:29:56', 'N', 'Y');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table license_db.role_permissions
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `permission_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  `organization_id` bigint(20) unsigned NOT NULL,
  `create_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `update_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `view_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `export_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `import_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `work_flow_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `review_button_flag` varchar(1) DEFAULT NULL,
  `created_by` bigint(20) NOT NULL,
  `last_updated_by` bigint(20) NOT NULL,
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  `last_updated_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FKcowp0c26jhofa4uw8pngnyghs` (`organization_id`),
  KEY `FKegdk29eiy7mdtefy5c7eirr6e` (`permission_id`),
  KEY `FKn5fotdgk8d1xvo8nav9uv3muc` (`role_id`),
  KEY `FK85wlhl8dq1ktvxxnyyf6b4v91` (`created_by`),
  KEY `FKn6xmcrc4d0jw8rxlba7tpxxqg` (`last_updated_by`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.role_permissions: 0 rows
DELETE FROM `role_permissions`;
/*!40000 ALTER TABLE `role_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `role_permissions` ENABLE KEYS */;

-- Dumping structure for table license_db.selected_custom_variables
DROP TABLE IF EXISTS `selected_custom_variables`;
CREATE TABLE IF NOT EXISTS `selected_custom_variables` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `custom_settings_id` bigint(20) unsigned NOT NULL,
  `variable_type` varchar(50) NOT NULL DEFAULT '',
  `variable_name` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `FK1_foe_selected_settings` (`custom_settings_id`),
  CONSTRAINT `FK1_foe_selected_settings` FOREIGN KEY (`custom_settings_id`) REFERENCES `custom_pdf_settings` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.selected_custom_variables: ~0 rows (approximately)
DELETE FROM `selected_custom_variables`;
/*!40000 ALTER TABLE `selected_custom_variables` DISABLE KEYS */;
/*!40000 ALTER TABLE `selected_custom_variables` ENABLE KEYS */;

-- Dumping structure for table license_db.selected_tescase_urs_items
DROP TABLE IF EXISTS `selected_tescase_urs_items`;
CREATE TABLE IF NOT EXISTS `selected_tescase_urs_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_id` bigint(20) unsigned NOT NULL,
  `urs_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_selected_tescase_urs_items_iq_test_cases` (`test_case_id`) USING BTREE,
  KEY `FK_selected_tescase_urs_items_urs` (`urs_id`) USING BTREE,
  CONSTRAINT `FK_selected_tescase_urs_items_iq_test_cases` FOREIGN KEY (`test_case_id`) REFERENCES `iq_test_cases` (`id`),
  CONSTRAINT `FK_selected_tescase_urs_items_urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.selected_tescase_urs_items: ~0 rows (approximately)
DELETE FROM `selected_tescase_urs_items`;
/*!40000 ALTER TABLE `selected_tescase_urs_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `selected_tescase_urs_items` ENABLE KEYS */;

-- Dumping structure for table license_db.sequence_number
DROP TABLE IF EXISTS `sequence_number`;
CREATE TABLE IF NOT EXISTS `sequence_number` (
  `type` varchar(50) NOT NULL,
  `value` varchar(50) NOT NULL,
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sequence_number_un` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.sequence_number: ~4 rows (approximately)
DELETE FROM `sequence_number`;
/*!40000 ALTER TABLE `sequence_number` DISABLE KEYS */;
INSERT INTO `sequence_number` (`type`, `value`, `id`) VALUES
	('dynamicFormConstant', '2756', 1),
	('displayOrderForPermission', '1117', 3),
	('dynamicFormCode', '3662', 4),
	('dynamicTemplateCode', '1', 5);
/*!40000 ALTER TABLE `sequence_number` ENABLE KEYS */;

-- Dumping structure for table license_db.shift_master
DROP TABLE IF EXISTS `shift_master`;
CREATE TABLE IF NOT EXISTS `shift_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `start_time` varchar(50) NOT NULL,
  `end_time` varchar(50) NOT NULL,
  `active` varchar(1) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_shift_master_users` (`updated_by`),
  KEY `FK_shift_master_organization_info` (`org_id`),
  CONSTRAINT `FK_shift_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_shift_master_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.shift_master: ~0 rows (approximately)
DELETE FROM `shift_master`;
/*!40000 ALTER TABLE `shift_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `shift_master` ENABLE KEYS */;

-- Dumping structure for table license_db.specification_master
DROP TABLE IF EXISTS `specification_master`;
CREATE TABLE IF NOT EXISTS `specification_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sp_code` varchar(50) NOT NULL,
  `type_value` varchar(50) NOT NULL,
  `type_key` varchar(50) NOT NULL,
  `description` mediumtext NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `published` varchar(1) DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `version_id` bigint(20) unsigned NOT NULL,
  `revision_number` bigint(20) DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `FK_specification_master_users` (`updated_by`),
  KEY `FK_specification_master_project_version` (`version_id`),
  KEY `FK_specification_master_users_2` (`created_by`),
  CONSTRAINT `FK_specification_master_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_specification_master_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_specification_master_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.specification_master: ~0 rows (approximately)
DELETE FROM `specification_master`;
/*!40000 ALTER TABLE `specification_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `specification_master` ENABLE KEYS */;

-- Dumping structure for table license_db.specification_master_urs
DROP TABLE IF EXISTS `specification_master_urs`;
CREATE TABLE IF NOT EXISTS `specification_master_urs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `specification_master_id` bigint(20) unsigned NOT NULL,
  `urs_id` bigint(20) unsigned NOT NULL,
  `user_acceptance` varchar(50) DEFAULT '',
  `remarks` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__specification_master` (`specification_master_id`),
  KEY `FK_specification_master_urs_urs` (`urs_id`),
  CONSTRAINT `FK__specification_master` FOREIGN KEY (`specification_master_id`) REFERENCES `specification_master` (`id`),
  CONSTRAINT `FK_specification_master_urs_urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.specification_master_urs: ~0 rows (approximately)
DELETE FROM `specification_master_urs`;
/*!40000 ALTER TABLE `specification_master_urs` DISABLE KEYS */;
/*!40000 ALTER TABLE `specification_master_urs` ENABLE KEYS */;

-- Dumping structure for table license_db.spring_session
DROP TABLE IF EXISTS `spring_session`;
CREATE TABLE IF NOT EXISTS `spring_session` (
  `PRIMARY_ID` char(36) NOT NULL,
  `SESSION_ID` char(36) NOT NULL,
  `CREATION_TIME` bigint(20) NOT NULL,
  `LAST_ACCESS_TIME` bigint(20) NOT NULL,
  `MAX_INACTIVE_INTERVAL` int(11) NOT NULL,
  `EXPIRY_TIME` bigint(20) NOT NULL,
  `PRINCIPAL_NAME` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`PRIMARY_ID`),
  UNIQUE KEY `SPRING_SESSION_IX1` (`SESSION_ID`),
  UNIQUE KEY `UK5w2quj3jv3tc8op1cgd4n502v` (`SESSION_ID`),
  KEY `SPRING_SESSION_IX2` (`EXPIRY_TIME`),
  KEY `SPRING_SESSION_IX3` (`PRINCIPAL_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SPRING_SESSION';

-- Dumping data for table license_db.spring_session: ~0 rows (approximately)
DELETE FROM `spring_session`;
/*!40000 ALTER TABLE `spring_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session` ENABLE KEYS */;

-- Dumping structure for table license_db.spring_session_attributes
DROP TABLE IF EXISTS `spring_session_attributes`;
CREATE TABLE IF NOT EXISTS `spring_session_attributes` (
  `SESSION_PRIMARY_ID` char(36) NOT NULL,
  `ATTRIBUTE_NAME` varchar(200) NOT NULL,
  `ATTRIBUTE_BYTES` blob NOT NULL,
  PRIMARY KEY (`SESSION_PRIMARY_ID`,`ATTRIBUTE_NAME`),
  CONSTRAINT `FK_SPRING_SESSION_ATTRIBUTES_SPRING_SESSION` FOREIGN KEY (`SESSION_PRIMARY_ID`) REFERENCES `spring_session` (`PRIMARY_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='SPRING_SESSION_ATTRIBUTES';

-- Dumping data for table license_db.spring_session_attributes: ~0 rows (approximately)
DELETE FROM `spring_session_attributes`;
/*!40000 ALTER TABLE `spring_session_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `spring_session_attributes` ENABLE KEYS */;

-- Dumping structure for table license_db.support
DROP TABLE IF EXISTS `support`;
CREATE TABLE IF NOT EXISTS `support` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `icon` longtext DEFAULT NULL,
  `title` longtext DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `url` longtext DEFAULT NULL,
  `download_name` varchar(50) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.support: ~0 rows (approximately)
DELETE FROM `support`;
/*!40000 ALTER TABLE `support` DISABLE KEYS */;
/*!40000 ALTER TABLE `support` ENABLE KEYS */;

-- Dumping structure for table license_db.task_mail_details
DROP TABLE IF EXISTS `task_mail_details`;
CREATE TABLE IF NOT EXISTS `task_mail_details` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `reference_id` varchar(50) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `location_id` bigint(20) NOT NULL,
  `document_id` bigint(20) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.task_mail_details: ~0 rows (approximately)
DELETE FROM `task_mail_details`;
/*!40000 ALTER TABLE `task_mail_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `task_mail_details` ENABLE KEYS */;

-- Dumping structure for table license_db.template_library_details
DROP TABLE IF EXISTS `template_library_details`;
CREATE TABLE IF NOT EXISTS `template_library_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_name` varchar(50) NOT NULL,
  `project_type` varchar(50) NOT NULL DEFAULT 'Computer System Validation',
  `equipment` varchar(50) DEFAULT NULL,
  `software` varchar(50) DEFAULT NULL,
  `banner_name` varchar(50) DEFAULT NULL,
  `banner_image` longtext DEFAULT NULL,
  `created_name` varchar(50) DEFAULT NULL,
  `is_active` varchar(1) NOT NULL DEFAULT 'Y',
  `attachment_file_name` varchar(50) NOT NULL,
  `attachment_file_path` varchar(100) NOT NULL,
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_tepmlate_library_details_user` (`created_by`),
  KEY `FK_tepmlate_library_details_user_1` (`last_updated_by`),
  CONSTRAINT `FK_tepmlate_library_details_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_tepmlate_library_details_user_1` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.template_library_details: ~0 rows (approximately)
DELETE FROM `template_library_details`;
/*!40000 ALTER TABLE `template_library_details` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_library_details` ENABLE KEYS */;

-- Dumping structure for table license_db.template_library_org_info
DROP TABLE IF EXISTS `template_library_org_info`;
CREATE TABLE IF NOT EXISTS `template_library_org_info` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `template_library_id` bigint(20) unsigned NOT NULL,
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_TL_org_info_template_library_id` (`template_library_id`),
  KEY `FK_TL_org_info_org_id` (`org_id`),
  CONSTRAINT `FK_TL_org_info_org_id` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_TL_org_info_template_library_id ` FOREIGN KEY (`template_library_id`) REFERENCES `template_library_details` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.template_library_org_info: ~0 rows (approximately)
DELETE FROM `template_library_org_info`;
/*!40000 ALTER TABLE `template_library_org_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `template_library_org_info` ENABLE KEYS */;

-- Dumping structure for table license_db.testcase_discrepancy_log
DROP TABLE IF EXISTS `testcase_discrepancy_log`;
CREATE TABLE IF NOT EXISTS `testcase_discrepancy_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_id` bigint(20) unsigned NOT NULL,
  `df_id` bigint(20) unsigned NOT NULL,
  `risk_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_testcase_discrepancy_log_iq_test_cases` (`test_case_id`),
  KEY `FK_testcase_discrepancy_log_discrepancy_form` (`df_id`),
  CONSTRAINT `FK_testcase_discrepancy_log_discrepancy_form` FOREIGN KEY (`df_id`) REFERENCES `discrepancy_form` (`id`),
  CONSTRAINT `FK_testcase_discrepancy_log_iq_test_cases` FOREIGN KEY (`test_case_id`) REFERENCES `iq_test_cases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.testcase_discrepancy_log: ~0 rows (approximately)
DELETE FROM `testcase_discrepancy_log`;
/*!40000 ALTER TABLE `testcase_discrepancy_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `testcase_discrepancy_log` ENABLE KEYS */;

-- Dumping structure for table license_db.test_case_checklist_images
DROP TABLE IF EXISTS `test_case_checklist_images`;
CREATE TABLE IF NOT EXISTS `test_case_checklist_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_checklist_id` bigint(20) unsigned NOT NULL,
  `image_file` longtext NOT NULL,
  `file_name` longtext NOT NULL,
  `display_order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_test_case_checklist_images_checklist_for_test_cases` (`test_case_checklist_id`),
  CONSTRAINT `FK_test_case_checklist_images_checklist_for_test_cases` FOREIGN KEY (`test_case_checklist_id`) REFERENCES `checklist_for_test_cases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.test_case_checklist_images: ~0 rows (approximately)
DELETE FROM `test_case_checklist_images`;
/*!40000 ALTER TABLE `test_case_checklist_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_case_checklist_images` ENABLE KEYS */;

-- Dumping structure for table license_db.test_case_summary
DROP TABLE IF EXISTS `test_case_summary`;
CREATE TABLE IF NOT EXISTS `test_case_summary` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version_id` bigint(20) unsigned NOT NULL,
  `doc_type` varchar(50) NOT NULL,
  `test_approach` text DEFAULT NULL,
  `conclusion` text DEFAULT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_test_case_summary_project_version` (`version_id`),
  KEY `FK_test_case_summary_users` (`updated_by`),
  CONSTRAINT `FK_test_case_summary_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_test_case_summary_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.test_case_summary: ~0 rows (approximately)
DELETE FROM `test_case_summary`;
/*!40000 ALTER TABLE `test_case_summary` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_case_summary` ENABLE KEYS */;

-- Dumping structure for table license_db.test_case_types
DROP TABLE IF EXISTS `test_case_types`;
CREATE TABLE IF NOT EXISTS `test_case_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_type` varchar(50) NOT NULL,
  `deleted_flag` char(50) NOT NULL DEFAULT 'N',
  `permission` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_test_case_types_permissions` (`permission`),
  CONSTRAINT `FK_test_case_types_permissions` FOREIGN KEY (`permission`) REFERENCES `permissions` (`permission_constant_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.test_case_types: ~5 rows (approximately)
DELETE FROM `test_case_types`;
/*!40000 ALTER TABLE `test_case_types` DISABLE KEYS */;
INSERT INTO `test_case_types` (`id`, `test_case_type`, `deleted_flag`, `permission`) VALUES
	(1, 'IQTC', 'N', '108'),
	(2, 'OQTC', 'N', '110'),
	(3, 'PQTC', 'N', '109'),
	(4, 'IOQTC', 'N', '207'),
	(5, 'OPQTC', 'N', '208');
/*!40000 ALTER TABLE `test_case_types` ENABLE KEYS */;

-- Dumping structure for table license_db.test_run
DROP TABLE IF EXISTS `test_run`;
CREATE TABLE IF NOT EXISTS `test_run` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version_id` bigint(20) unsigned NOT NULL,
  `name` varchar(248) NOT NULL,
  `test_case_type` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `target_date` varchar(50) NOT NULL DEFAULT '',
  `active_flag` varchar(1) NOT NULL DEFAULT '',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `task_id` bigint(20) DEFAULT NULL,
  `document_sequence` varchar(1) NOT NULL DEFAULT '',
  `pre_approval_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `workflow_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_test_run_permissions` (`test_case_type`) USING BTREE,
  KEY `FK_test_run_users` (`created_by`) USING BTREE,
  KEY `FK_test_run_users_2` (`updated_by`) USING BTREE,
  KEY `FK_test_run_project_version` (`version_id`) USING BTREE,
  KEY `FK_test_run_project_tasks` (`task_id`),
  CONSTRAINT `FK_test_run_permissions` FOREIGN KEY (`test_case_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_test_run_project_tasks` FOREIGN KEY (`task_id`) REFERENCES `project_tasks` (`id`),
  CONSTRAINT `FK_test_run_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_test_run_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_test_run_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='instance of test case like folder of test case';

-- Dumping data for table license_db.test_run: ~0 rows (approximately)
DELETE FROM `test_run`;
/*!40000 ALTER TABLE `test_run` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_run` ENABLE KEYS */;

-- Dumping structure for table license_db.test_run_active_of_user
DROP TABLE IF EXISTS `test_run_active_of_user`;
CREATE TABLE IF NOT EXISTS `test_run_active_of_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_type` varchar(50) NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `test_run_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  KEY `F__project_version` (`version_id`) USING BTREE,
  KEY `F__test_run` (`test_run_id`) USING BTREE,
  KEY `F__users` (`user_id`) USING BTREE,
  KEY `F__permissions` (`test_case_type`) USING BTREE,
  CONSTRAINT `F__permissions` FOREIGN KEY (`test_case_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `F__project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `F__test_run` FOREIGN KEY (`test_run_id`) REFERENCES `test_run` (`id`),
  CONSTRAINT `F__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.test_run_active_of_user: ~0 rows (approximately)
DELETE FROM `test_run_active_of_user`;
/*!40000 ALTER TABLE `test_run_active_of_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_run_active_of_user` ENABLE KEYS */;

-- Dumping structure for table license_db.test_run_users
DROP TABLE IF EXISTS `test_run_users`;
CREATE TABLE IF NOT EXISTS `test_run_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_run_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK__test_run` (`test_run_id`) USING BTREE,
  KEY `FK__user` (`user_id`) USING BTREE,
  CONSTRAINT `FK__test_run` FOREIGN KEY (`test_run_id`) REFERENCES `test_run` (`id`),
  CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Assigned to the test run instance';

-- Dumping data for table license_db.test_run_users: ~0 rows (approximately)
DELETE FROM `test_run_users`;
/*!40000 ALTER TABLE `test_run_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `test_run_users` ENABLE KEYS */;

-- Dumping structure for table license_db.unscripted_risk_items
DROP TABLE IF EXISTS `unscripted_risk_items`;
CREATE TABLE IF NOT EXISTS `unscripted_risk_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unscripted_id` bigint(20) unsigned NOT NULL,
  `risk_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__unscripted_test_case` (`unscripted_id`),
  KEY `FK_unscripted_risk_items_risk_assessment` (`risk_id`),
  CONSTRAINT `FK__unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`),
  CONSTRAINT `FK_unscripted_risk_items_risk_assessment` FOREIGN KEY (`risk_id`) REFERENCES `risk_assessment` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.unscripted_risk_items: ~0 rows (approximately)
DELETE FROM `unscripted_risk_items`;
/*!40000 ALTER TABLE `unscripted_risk_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `unscripted_risk_items` ENABLE KEYS */;

-- Dumping structure for table license_db.unscripted_spec_items
DROP TABLE IF EXISTS `unscripted_spec_items`;
CREATE TABLE IF NOT EXISTS `unscripted_spec_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `unscripted_id` bigint(20) unsigned NOT NULL,
  `spec_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_unscripted_spec_items_unscripted_test_case` (`unscripted_id`) USING BTREE,
  KEY `FK_unscripted_spec_items_specification_master` (`spec_id`) USING BTREE,
  CONSTRAINT `FK_unscripted_spec_items_specification_master` FOREIGN KEY (`spec_id`) REFERENCES `specification_master` (`id`),
  CONSTRAINT `FK_unscripted_spec_items_unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.unscripted_spec_items: ~0 rows (approximately)
DELETE FROM `unscripted_spec_items`;
/*!40000 ALTER TABLE `unscripted_spec_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `unscripted_spec_items` ENABLE KEYS */;

-- Dumping structure for table license_db.unscripted_test_case
DROP TABLE IF EXISTS `unscripted_test_case`;
CREATE TABLE IF NOT EXISTS `unscripted_test_case` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_case_code` varchar(50) DEFAULT NULL,
  `test_business_impact` longtext DEFAULT NULL,
  `test_description` longtext DEFAULT NULL,
  `testing_ype` varchar(50) DEFAULT NULL,
  `environment` varchar(50) DEFAULT NULL,
  `test_result` longtext DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `published_flag` varchar(1) DEFAULT 'N',
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `revision_number` bigint(20) DEFAULT 1,
  `delete_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_unscripted_test_case_project_version` (`version_id`),
  KEY `FK_unscripted_test_case_users` (`created_by`),
  KEY `FK_unscripted_test_case_users_2` (`last_updated_by`),
  CONSTRAINT `FK_unscripted_test_case_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_unscripted_test_case_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_unscripted_test_case_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.unscripted_test_case: ~0 rows (approximately)
DELETE FROM `unscripted_test_case`;
/*!40000 ALTER TABLE `unscripted_test_case` DISABLE KEYS */;
/*!40000 ALTER TABLE `unscripted_test_case` ENABLE KEYS */;

-- Dumping structure for table license_db.unscripted_urs_items
DROP TABLE IF EXISTS `unscripted_urs_items`;
CREATE TABLE IF NOT EXISTS `unscripted_urs_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `urs_id` bigint(20) unsigned NOT NULL,
  `unscripted_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_unscripted_urs_items_urs` (`urs_id`),
  KEY `FK_unscripted_urs_items_unscripted_test_case` (`unscripted_id`),
  CONSTRAINT `FK_unscripted_urs_items_unscripted_test_case` FOREIGN KEY (`unscripted_id`) REFERENCES `unscripted_test_case` (`id`),
  CONSTRAINT `FK_unscripted_urs_items_urs` FOREIGN KEY (`urs_id`) REFERENCES `urs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.unscripted_urs_items: ~0 rows (approximately)
DELETE FROM `unscripted_urs_items`;
/*!40000 ALTER TABLE `unscripted_urs_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `unscripted_urs_items` ENABLE KEYS */;

-- Dumping structure for table license_db.url_checklist_for_document
DROP TABLE IF EXISTS `url_checklist_for_document`;
CREATE TABLE IF NOT EXISTS `url_checklist_for_document` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` bigint(20) unsigned NOT NULL,
  `document_id` bigint(20) NOT NULL DEFAULT 0,
  `title` longtext NOT NULL,
  `url` longtext DEFAULT NULL,
  `deleteflag` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_url_checklist_for_document_permissions` (`document_type`),
  CONSTRAINT `FK_url_checklist_for_document_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.url_checklist_for_document: ~0 rows (approximately)
DELETE FROM `url_checklist_for_document`;
/*!40000 ALTER TABLE `url_checklist_for_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `url_checklist_for_document` ENABLE KEYS */;

-- Dumping structure for table license_db.urs
DROP TABLE IF EXISTS `urs`;
CREATE TABLE IF NOT EXISTS `urs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `urs_name` longtext NOT NULL,
  `urs_code` varchar(50) NOT NULL,
  `description` longtext DEFAULT NULL,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `category` bigint(20) unsigned NOT NULL,
  `priority` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `delete_flag` varchar(1) NOT NULL,
  `published` varchar(1) DEFAULT 'N',
  `approved_time` datetime DEFAULT NULL,
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `version_id` bigint(20) unsigned NOT NULL,
  `revision_number` bigint(20) DEFAULT 1,
  `user_acceptance` varchar(50) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `testing_required` varchar(1) DEFAULT 'N',
  `potential_risk` varchar(50) DEFAULT NULL,
  `implementation_method` varchar(50) DEFAULT NULL,
  `testing_method` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_urs_users` (`created_by`),
  KEY `FK_urs_users_2` (`last_updated_by`),
  KEY `FK_urs_project_setup` (`project_id`),
  KEY `FK_urs_category` (`category`),
  KEY `FK_urs_priority` (`priority`),
  KEY `FK_urs_project_version` (`version_id`),
  CONSTRAINT `FK_urs_category` FOREIGN KEY (`category`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_urs_priority` FOREIGN KEY (`priority`) REFERENCES `priority` (`id`),
  CONSTRAINT `FK_urs_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_urs_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_urs_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_urs_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.urs: ~0 rows (approximately)
DELETE FROM `urs`;
/*!40000 ALTER TABLE `urs` DISABLE KEYS */;
/*!40000 ALTER TABLE `urs` ENABLE KEYS */;

-- Dumping structure for table license_db.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(40) NOT NULL,
  `first_name` varchar(40) NOT NULL,
  `last_name` varchar(40) NOT NULL,
  `designation` varchar(100) DEFAULT NULL,
  `email` varchar(40) NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `phone_no` bigint(20) DEFAULT NULL,
  `organization_id` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) DEFAULT NULL,
  `updated_by` bigint(20) DEFAULT NULL,
  `delete_flag` varchar(1) DEFAULT 'N',
  `is_admin` varchar(1) DEFAULT 'N',
  `is_new_user` varchar(1) DEFAULT 'N',
  `location_id` bigint(20) unsigned DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `active` varchar(1) DEFAULT 'Y',
  `login_type` varchar(50) NOT NULL DEFAULT 'Application user',
  `disable_model` varchar(1) DEFAULT 'N',
  `manager` bigint(20) DEFAULT NULL,
  `hod_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `FK_users_department` (`department_id`),
  KEY `FK_users_organization_info` (`organization_id`),
  KEY `FK_users_location` (`location_id`),
  CONSTRAINT `FK_users_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `FK_users_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id`),
  CONSTRAINT `FK_users_organization_info` FOREIGN KEY (`organization_id`) REFERENCES `organization_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.users: ~1 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `first_name`, `last_name`, `designation`, `email`, `name`, `password`, `phone_no`, `organization_id`, `created_time`, `updated_time`, `created_by`, `updated_by`, `delete_flag`, `is_admin`, `is_new_user`, `location_id`, `department_id`, `active`, `login_type`, `disable_model`, `manager`, `hod_flag`) VALUES
	(1, 'rootAdmin', 'Goval', 'Admin', NULL, 'adventsysdeveloper@gmail.com', 'Goval Admin', '$2a$10$eGED1CF79yNEeZfHNGK57eAnCOgmtgf7MFgYnFQ0lTXpgtIJ/g78a', NULL, 1, '2021-10-19 20:01:17', '2021-10-19 20:01:17', 1, 1, 'N', 'A', 'N', NULL, NULL, 'Y', 'Application user', 'N', NULL, 'N');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table license_db.users_department_for_project
DROP TABLE IF EXISTS `users_department_for_project`;
CREATE TABLE IF NOT EXISTS `users_department_for_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_users_for_project_project_setup` (`project_id`),
  KEY `FK_users_for_project_department` (`department_id`),
  KEY `FK_users_for_project_user` (`created_by`),
  CONSTRAINT `FK_users_for_project_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `FK_users_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_users_for_project_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.users_department_for_project: ~0 rows (approximately)
DELETE FROM `users_department_for_project`;
/*!40000 ALTER TABLE `users_department_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_department_for_project` ENABLE KEYS */;

-- Dumping structure for table license_db.user_active_session
DROP TABLE IF EXISTS `user_active_session`;
CREATE TABLE IF NOT EXISTS `user_active_session` (
  `id` bigint(20) NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `browser` varchar(100) NOT NULL DEFAULT '',
  `logged_in_ip` varchar(50) NOT NULL DEFAULT '',
  `token` varchar(200) NOT NULL DEFAULT '',
  `logged_in_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `expire_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__users_id` (`user_id`),
  CONSTRAINT `FK__users_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_active_session: ~0 rows (approximately)
DELETE FROM `user_active_session`;
/*!40000 ALTER TABLE `user_active_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_active_session` ENABLE KEYS */;

-- Dumping structure for table license_db.user_esign
DROP TABLE IF EXISTS `user_esign`;
CREATE TABLE IF NOT EXISTS `user_esign` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `sign_image` longtext NOT NULL,
  `esign_flag` varchar(1) NOT NULL DEFAULT 'Y',
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_esign_users` (`user_id`),
  CONSTRAINT `FK_user_esign_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_esign: ~0 rows (approximately)
DELETE FROM `user_esign`;
/*!40000 ALTER TABLE `user_esign` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_esign` ENABLE KEYS */;

-- Dumping structure for table license_db.user_e_signature
DROP TABLE IF EXISTS `user_e_signature`;
CREATE TABLE IF NOT EXISTS `user_e_signature` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `e_signature_details_id` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) NOT NULL,
  `signature` longtext DEFAULT NULL,
  `user_sign` varchar(100) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_e_signature_details_id` (`e_signature_details_id`),
  KEY `FK_user_e_signature_user` (`created_by`),
  CONSTRAINT `FK_e_signature_details_id` FOREIGN KEY (`e_signature_details_id`) REFERENCES `e_signature_documents` (`id`),
  CONSTRAINT `FK_user_e_signature_user` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_e_signature: ~0 rows (approximately)
DELETE FROM `user_e_signature`;
/*!40000 ALTER TABLE `user_e_signature` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_e_signature` ENABLE KEYS */;

-- Dumping structure for table license_db.user_login_attempts
DROP TABLE IF EXISTS `user_login_attempts`;
CREATE TABLE IF NOT EXISTS `user_login_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `count` int(11) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_login_attempts: ~0 rows (approximately)
DELETE FROM `user_login_attempts`;
/*!40000 ALTER TABLE `user_login_attempts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_login_attempts` ENABLE KEYS */;

-- Dumping structure for table license_db.user_organizations
DROP TABLE IF EXISTS `user_organizations`;
CREATE TABLE IF NOT EXISTS `user_organizations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `org_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_organizations_users` (`user_id`),
  KEY `FK_user_organizations_organization_info` (`org_id`),
  CONSTRAINT `FK_user_organizations_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_user_organizations_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_organizations: ~1 rows (approximately)
DELETE FROM `user_organizations`;
/*!40000 ALTER TABLE `user_organizations` DISABLE KEYS */;
INSERT INTO `user_organizations` (`id`, `user_id`, `org_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `user_organizations` ENABLE KEYS */;

-- Dumping structure for table license_db.user_permissions
DROP TABLE IF EXISTS `user_permissions`;
CREATE TABLE IF NOT EXISTS `user_permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `permission_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `create_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `update_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `view_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `export_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `import_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `work_flow_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_button_flag` varchar(1) NOT NULL DEFAULT 'N',
  `review_button_flag` varchar(1) DEFAULT NULL,
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `created_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_updated_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_permissions_permissions` (`permission_id`),
  KEY `FK_user_permissions_users` (`user_id`),
  KEY `FK_user_permissions_users_2` (`created_by`),
  KEY `FK_user_permissions_users_3` (`last_updated_by`),
  KEY `FK_user_permissions_project_setup` (`project_id`),
  CONSTRAINT `FK_user_permissions_permissions` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  CONSTRAINT `FK_user_permissions_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_user_permissions_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_user_permissions_users_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_user_permissions_users_3` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_permissions: ~0 rows (approximately)
DELETE FROM `user_permissions`;
/*!40000 ALTER TABLE `user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_permissions` ENABLE KEYS */;

-- Dumping structure for table license_db.user_preferences
DROP TABLE IF EXISTS `user_preferences`;
CREATE TABLE IF NOT EXISTS `user_preferences` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `module_type` varchar(50) NOT NULL,
  `shortcut_name` varchar(200) NOT NULL,
  `json_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_data`)),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_preferences: ~4 rows (approximately)
DELETE FROM `user_preferences`;
/*!40000 ALTER TABLE `user_preferences` DISABLE KEYS */;
INSERT INTO `user_preferences` (`id`, `user_id`, `module_type`, `shortcut_name`, `json_data`) VALUES
	(1, 1, '128', 'draft', NULL),
	(2, 1, '230', 'draft', NULL),
	(3, 1, '91', 'masterData', NULL),
	(4, 1, '225', 'summary', NULL);
/*!40000 ALTER TABLE `user_preferences` ENABLE KEYS */;

-- Dumping structure for table license_db.user_roles
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_roles_users` (`user_id`),
  KEY `FK_user_roles_roles` (`role_id`),
  CONSTRAINT `FK_user_roles_roles` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  CONSTRAINT `FK_user_roles_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_roles: ~0 rows (approximately)
DELETE FROM `user_roles`;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;

-- Dumping structure for table license_db.user_shortcuts
DROP TABLE IF EXISTS `user_shortcuts`;
CREATE TABLE IF NOT EXISTS `user_shortcuts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `user_documents` varchar(1) NOT NULL DEFAULT 'N',
  `user_approval_count` varchar(1) NOT NULL DEFAULT 'N',
  `tasks` varchar(1) NOT NULL DEFAULT 'N',
  `equipments` varchar(1) NOT NULL DEFAULT 'N',
  `test_cases` varchar(1) NOT NULL DEFAULT 'N',
  `allTask` varchar(1) NOT NULL DEFAULT 'N',
  `summary` varchar(1) NOT NULL DEFAULT 'N',
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_shortcuts_users` (`user_id`),
  CONSTRAINT `FK_user_shortcuts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_shortcuts: ~0 rows (approximately)
DELETE FROM `user_shortcuts`;
/*!40000 ALTER TABLE `user_shortcuts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_shortcuts` ENABLE KEYS */;

-- Dumping structure for table license_db.user_shortcut_modules
DROP TABLE IF EXISTS `user_shortcut_modules`;
CREATE TABLE IF NOT EXISTS `user_shortcut_modules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_shortcuts_id` bigint(20) unsigned NOT NULL,
  `module` varchar(50) NOT NULL,
  `mapping_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_user_shortcut_modules_user_shortcuts` (`user_shortcuts_id`),
  KEY `FK_user_shortcut_modules_permissions` (`module`),
  CONSTRAINT `FK_user_shortcut_modules_permissions` FOREIGN KEY (`module`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_user_shortcut_modules_user_shortcuts` FOREIGN KEY (`user_shortcuts_id`) REFERENCES `user_shortcuts` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.user_shortcut_modules: ~0 rows (approximately)
DELETE FROM `user_shortcut_modules`;
/*!40000 ALTER TABLE `user_shortcut_modules` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_shortcut_modules` ENABLE KEYS */;

-- Dumping structure for table license_db.validation_summary_report
DROP TABLE IF EXISTS `validation_summary_report`;
CREATE TABLE IF NOT EXISTS `validation_summary_report` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_ID` bigint(20) unsigned DEFAULT 0,
  `version_id` bigint(20) unsigned NOT NULL,
  `objective` longtext NOT NULL,
  `scope` longtext DEFAULT NULL,
  `validation_summary` longtext DEFAULT NULL,
  `validation_deliverables` longtext DEFAULT NULL,
  `risk_assessment` longtext DEFAULT NULL,
  `summary_of_deviations` longtext DEFAULT NULL,
  `observation_recommendation` longtext DEFAULT NULL,
  `user_acceptance` longtext DEFAULT NULL,
  `validation_exp_date` varchar(300) DEFAULT NULL,
  `freeze_flag` varchar(1) NOT NULL DEFAULT 'N',
  `publish_flag` varchar(1) NOT NULL DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `clone_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  `workflow_completion_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned DEFAULT 0,
  `last_updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `task_id` bigint(20) DEFAULT NULL,
  `periodic_review_flag` varchar(1) NOT NULL DEFAULT 'N',
  `new_version_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `Fk_relation_with_iqtc` (`project_ID`),
  KEY `FK_validation_summary_report_project_version` (`version_id`),
  KEY `FK_validation_summary_report_users` (`created_by`),
  KEY `FK_validation_summary_report_users_2` (`last_updated_by`),
  KEY `FK_validation_summary_report_project_tasks` (`task_id`),
  CONSTRAINT `FK_validation_summary_report_project_tasks` FOREIGN KEY (`task_id`) REFERENCES `project_tasks` (`id`),
  CONSTRAINT `FK_validation_summary_report_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_validation_summary_report_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_validation_summary_report_users_2` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `Fk_relation_with_iqtc` FOREIGN KEY (`project_ID`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.validation_summary_report: ~0 rows (approximately)
DELETE FROM `validation_summary_report`;
/*!40000 ALTER TABLE `validation_summary_report` DISABLE KEYS */;
/*!40000 ALTER TABLE `validation_summary_report` ENABLE KEYS */;

-- Dumping structure for table license_db.validation_summary_report_child
DROP TABLE IF EXISTS `validation_summary_report_child`;
CREATE TABLE IF NOT EXISTS `validation_summary_report_child` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `vsr_parent_id` bigint(20) unsigned NOT NULL,
  `permission_constant_name` varchar(50) NOT NULL DEFAULT '0',
  `clone_completed_flag` varchar(1) NOT NULL DEFAULT 'N',
  `for_freeze_validation` varchar(1) NOT NULL DEFAULT 'N',
  `Freeze_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_validation_summary_report_child_validation_summary_report` (`vsr_parent_id`),
  KEY `FK_validation_summary_report_child_permissions` (`permission_constant_name`),
  CONSTRAINT `FK_validation_summary_report_child_permissions` FOREIGN KEY (`permission_constant_name`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_validation_summary_report_child_validation_summary_report` FOREIGN KEY (`vsr_parent_id`) REFERENCES `validation_summary_report` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.validation_summary_report_child: ~0 rows (approximately)
DELETE FROM `validation_summary_report_child`;
/*!40000 ALTER TABLE `validation_summary_report_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `validation_summary_report_child` ENABLE KEYS */;

-- Dumping structure for table license_db.valid_s_r_c_com
DROP TABLE IF EXISTS `valid_s_r_c_com`;
CREATE TABLE IF NOT EXISTS `valid_s_r_c_com` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `comments` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_valid_s_r_c_com_validation_summary_report_child` (`parent_id`),
  CONSTRAINT `FK_valid_s_r_c_com_validation_summary_report_child` FOREIGN KEY (`parent_id`) REFERENCES `validation_summary_report_child` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.valid_s_r_c_com: ~0 rows (approximately)
DELETE FROM `valid_s_r_c_com`;
/*!40000 ALTER TABLE `valid_s_r_c_com` DISABLE KEYS */;
/*!40000 ALTER TABLE `valid_s_r_c_com` ENABLE KEYS */;

-- Dumping structure for table license_db.vendor_documents
DROP TABLE IF EXISTS `vendor_documents`;
CREATE TABLE IF NOT EXISTS `vendor_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version_id` bigint(20) unsigned NOT NULL,
  `vendor_code` varchar(50) NOT NULL,
  `document_name` varchar(50) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `revision_number` bigint(20) DEFAULT NULL,
  `published` varchar(1) DEFAULT NULL,
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_vendor_documents_users` (`created_by`),
  KEY `FK_vendor_documents_users_4` (`last_updated_by`),
  KEY `FK_vendor_documents_project_version` (`version_id`),
  CONSTRAINT `FK_vendor_documents_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_vendor_documents_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_vendor_documents_users_4` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.vendor_documents: ~0 rows (approximately)
DELETE FROM `vendor_documents`;
/*!40000 ALTER TABLE `vendor_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.vendor_master
DROP TABLE IF EXISTS `vendor_master`;
CREATE TABLE IF NOT EXISTS `vendor_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `website` varchar(50) DEFAULT NULL,
  `phone_number` varchar(50) DEFAULT NULL,
  `active_flag` varchar(1) DEFAULT 'Y',
  `deleted_flag` varchar(1) NOT NULL DEFAULT 'N',
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_vendor_master_users` (`created_by`),
  KEY `FK_vendor_master_users_2` (`updated_by`),
  KEY `FK_vendor_master_organization_info` (`org_id`),
  CONSTRAINT `FK_vendor_master_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_vendor_master_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_vendor_master_users_2` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.vendor_master: ~0 rows (approximately)
DELETE FROM `vendor_master`;
/*!40000 ALTER TABLE `vendor_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_master` ENABLE KEYS */;

-- Dumping structure for table license_db.vendor_master_project
DROP TABLE IF EXISTS `vendor_master_project`;
CREATE TABLE IF NOT EXISTS `vendor_master_project` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_master_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__vendor_master` (`vendor_master_id`),
  KEY `FK_vendor_master_project_project_setup` (`project_id`),
  CONSTRAINT `FK__vendor_master` FOREIGN KEY (`vendor_master_id`) REFERENCES `vendor_master` (`id`),
  CONSTRAINT `FK_vendor_master_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.vendor_master_project: ~0 rows (approximately)
DELETE FROM `vendor_master_project`;
/*!40000 ALTER TABLE `vendor_master_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_master_project` ENABLE KEYS */;

-- Dumping structure for table license_db.vendor_validation
DROP TABLE IF EXISTS `vendor_validation`;
CREATE TABLE IF NOT EXISTS `vendor_validation` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `vendor_code` varchar(50) NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `revision_number` bigint(20) DEFAULT NULL,
  `document_status` int(11) DEFAULT 1,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `delete_flag` varchar(1) NOT NULL DEFAULT 'N',
  `document_name` varchar(50) NOT NULL,
  `json_extra_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`json_extra_data`)),
  `version_id` bigint(20) unsigned NOT NULL,
  `last_updated_by` bigint(20) unsigned NOT NULL,
  `last_updated_time` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `uploaded_file` varchar(200) DEFAULT NULL,
  `published` varchar(1) DEFAULT NULL,
  `workflow_completion_flag` varchar(1) DEFAULT 'N',
  PRIMARY KEY (`id`),
  KEY `FK_vendor_validation_users` (`created_by`),
  KEY `FK_vendor_validation_project_setup` (`project_id`),
  KEY `FK_vendor_validation_users_4` (`last_updated_by`),
  KEY `FK_vendor_validation_project_version` (`version_id`),
  CONSTRAINT `FK_vendor_validation_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_vendor_validation_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_vendor_validation_users` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_vendor_validation_users_4` FOREIGN KEY (`last_updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.vendor_validation: ~0 rows (approximately)
DELETE FROM `vendor_validation`;
/*!40000 ALTER TABLE `vendor_validation` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_validation` ENABLE KEYS */;

-- Dumping structure for table license_db.vendor_validation_log
DROP TABLE IF EXISTS `vendor_validation_log`;
CREATE TABLE IF NOT EXISTS `vendor_validation_log` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_validation_id` bigint(20) unsigned NOT NULL,
  `file_name` varchar(200) NOT NULL,
  `file_path` varchar(200) NOT NULL,
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_vendor_validation_log_vendor_validation` (`vendor_validation_id`),
  KEY `FK_vendor_validation_log_users` (`updated_by`),
  CONSTRAINT `FK_vendor_validation_log_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_vendor_validation_log_vendor_validation` FOREIGN KEY (`vendor_validation_id`) REFERENCES `vendor_validation` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.vendor_validation_log: ~0 rows (approximately)
DELETE FROM `vendor_validation_log`;
/*!40000 ALTER TABLE `vendor_validation_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `vendor_validation_log` ENABLE KEYS */;

-- Dumping structure for table license_db.verify_document
DROP TABLE IF EXISTS `verify_document`;
CREATE TABLE IF NOT EXISTS `verify_document` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_id` bigint(20) unsigned DEFAULT NULL,
  `comments` longtext NOT NULL,
  `signature` longtext DEFAULT NULL,
  `signed_by` bigint(20) unsigned NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp(),
  `org_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `year` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_verify_document_project_version` (`version_id`),
  KEY `FK_verify_document_users` (`signed_by`),
  CONSTRAINT `FK_verify_document_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_verify_document_users` FOREIGN KEY (`signed_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.verify_document: ~0 rows (approximately)
DELETE FROM `verify_document`;
/*!40000 ALTER TABLE `verify_document` DISABLE KEYS */;
/*!40000 ALTER TABLE `verify_document` ENABLE KEYS */;

-- Dumping structure for table license_db.week_days
DROP TABLE IF EXISTS `week_days`;
CREATE TABLE IF NOT EXISTS `week_days` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `week_day` varchar(50) NOT NULL,
  `week_day_code` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.week_days: ~7 rows (approximately)
DELETE FROM `week_days`;
/*!40000 ALTER TABLE `week_days` DISABLE KEYS */;
INSERT INTO `week_days` (`id`, `week_day`, `week_day_code`) VALUES
	(1, 'Monday', 1),
	(2, 'Tuesday', 2),
	(3, 'Wednesday', 3),
	(4, 'Thursday', 4),
	(5, 'Friday', 5),
	(6, 'Saturday', 6),
	(7, 'Sunday', 0);
/*!40000 ALTER TABLE `week_days` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_comments
DROP TABLE IF EXISTS `workflow_comments`;
CREATE TABLE IF NOT EXISTS `workflow_comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `comments` varchar(255) NOT NULL,
  `created_time` datetime NOT NULL,
  `document_id` bigint(20) NOT NULL,
  `document_status` int(11) NOT NULL,
  `created_by` bigint(20) NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK9x5y7mmfdnkmqv9af9we3k9fb` (`created_by`),
  KEY `FKoi6tm7vg3ikvbvlu0ann4g6hp` (`document_type`),
  KEY `FKgj6d8u8l4ko6bpsbu9565g6v3` (`project_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_comments: 0 rows
DELETE FROM `workflow_comments`;
/*!40000 ALTER TABLE `workflow_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_comments` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_documents_child
DROP TABLE IF EXISTS `workflow_documents_child`;
CREATE TABLE IF NOT EXISTS `workflow_documents_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `workflow_document_parent_id` bigint(20) unsigned NOT NULL,
  `workflow_level_id` bigint(20) NOT NULL,
  `created_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `approved_by` bigint(20) unsigned NOT NULL,
  `comments` varchar(500) DEFAULT NULL,
  `current_session` bigint(20) DEFAULT NULL,
  `statusflag` varchar(1) DEFAULT 'Y',
  `flow_data_id` bigint(20) NOT NULL,
  `flow_type` bigint(20) NOT NULL,
  `action_by` bigint(20) NOT NULL,
  `flow_data_parent_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_document_child_workflow_for_documents` (`workflow_document_parent_id`),
  KEY `FK_workflow_document_child_work_flow_levels` (`workflow_level_id`),
  KEY `FK_workflow_document_child_users` (`approved_by`),
  CONSTRAINT `FK47xvr9yio45oofssobguns87k` FOREIGN KEY (`workflow_level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_workflow_document_child_users` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_workflow_document_child_work_flow_levels` FOREIGN KEY (`workflow_level_id`) REFERENCES `work_flow_levels` (`id`),
  CONSTRAINT `FK_workflow_document_child_workflow_for_documents` FOREIGN KEY (`workflow_document_parent_id`) REFERENCES `workflow_documents_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_documents_child: ~0 rows (approximately)
DELETE FROM `workflow_documents_child`;
/*!40000 ALTER TABLE `workflow_documents_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_documents_child` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_documents_master
DROP TABLE IF EXISTS `workflow_documents_master`;
CREATE TABLE IF NOT EXISTS `workflow_documents_master` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `document_type` varchar(50) NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `current_session` bigint(20) NOT NULL DEFAULT 0,
  `document_id` bigint(20) NOT NULL,
  `currentlevel` varchar(50) NOT NULL,
  `workflow_completed_Flag` varchar(1) DEFAULT 'N',
  `dynamic_code` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_documents_master_project_setup` (`project_id`),
  KEY `FK_workflow_documents_master_permissions` (`document_type`),
  KEY `FK_workflow_documents_master_project_version` (`version_id`),
  CONSTRAINT `FK_workflow_documents_master_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_workflow_documents_master_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_workflow_documents_master_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_documents_master: ~0 rows (approximately)
DELETE FROM `workflow_documents_master`;
/*!40000 ALTER TABLE `workflow_documents_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_documents_master` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_esign_batch
DROP TABLE IF EXISTS `workflow_esign_batch`;
CREATE TABLE IF NOT EXISTS `workflow_esign_batch` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `esign_master_id` bigint(20) NOT NULL,
  `workflow_master_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__workflow_esign_master` (`esign_master_id`),
  KEY `FK_workflow_esign_batch_workflow_documents_master` (`workflow_master_id`),
  KEY `FK_workflow_esign_batch_project_setup` (`project_id`),
  KEY `FK_workflow_esign_batch_project_version` (`version_id`),
  CONSTRAINT `FK__workflow_esign_master` FOREIGN KEY (`esign_master_id`) REFERENCES `workflow_esign_master` (`id`),
  CONSTRAINT `FK_workflow_esign_batch_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_workflow_esign_batch_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_workflow_esign_batch_workflow_documents_master` FOREIGN KEY (`workflow_master_id`) REFERENCES `workflow_documents_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_esign_batch: ~0 rows (approximately)
DELETE FROM `workflow_esign_batch`;
/*!40000 ALTER TABLE `workflow_esign_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_esign_batch` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_esign_child
DROP TABLE IF EXISTS `workflow_esign_child`;
CREATE TABLE IF NOT EXISTS `workflow_esign_child` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `workflow_master_id` bigint(20) NOT NULL,
  `user` bigint(20) unsigned NOT NULL,
  `levelid` bigint(20) NOT NULL,
  `createdtime` timestamp NOT NULL DEFAULT current_timestamp(),
  `comments` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_esign_data_users` (`user`),
  KEY `FK_workflow_esign_data_work_flow_levels` (`levelid`),
  KEY `FK_workflow_esign_child_workflow_esign_master` (`workflow_master_id`),
  CONSTRAINT `FK_workflow_esign_child_workflow_esign_master` FOREIGN KEY (`workflow_master_id`) REFERENCES `workflow_esign_master` (`id`),
  CONSTRAINT `FK_workflow_esign_data_users` FOREIGN KEY (`user`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_workflow_esign_data_work_flow_levels` FOREIGN KEY (`levelid`) REFERENCES `work_flow_levels` (`id`),
  CONSTRAINT `FKfuvdixh1iqmsf7ltdh8wj6gys` FOREIGN KEY (`levelid`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_esign_child: ~0 rows (approximately)
DELETE FROM `workflow_esign_child`;
/*!40000 ALTER TABLE `workflow_esign_child` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_esign_child` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_esign_master
DROP TABLE IF EXISTS `workflow_esign_master`;
CREATE TABLE IF NOT EXISTS `workflow_esign_master` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned DEFAULT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `current_level` bigint(20) NOT NULL,
  `createdTime` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `esign_completion_flag` varchar(1) DEFAULT 'N',
  `file_path` varchar(500) DEFAULT NULL,
  `session` bigint(20) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_esign_master_permissions` (`document_type`),
  KEY `FK_workflow_esign_master_work_flow_levels` (`current_level`),
  KEY `FK_workflow_esign_master_priority` (`project_id`),
  KEY `FK_workflow_esign_master_project_version` (`version_id`),
  CONSTRAINT `FK_workflow_esign_master_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_workflow_esign_master_priority` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_workflow_esign_master_project_version` FOREIGN KEY (`version_id`) REFERENCES `project_version` (`id`),
  CONSTRAINT `FK_workflow_esign_master_work_flow_levels` FOREIGN KEY (`current_level`) REFERENCES `work_flow_levels` (`id`),
  CONSTRAINT `FKo99rsif636irx0ydd7vmafnr8` FOREIGN KEY (`current_level`) REFERENCES `flow_level_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_esign_master: ~0 rows (approximately)
DELETE FROM `workflow_esign_master`;
/*!40000 ALTER TABLE `workflow_esign_master` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_esign_master` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_for_documents
DROP TABLE IF EXISTS `workflow_for_documents`;
CREATE TABLE IF NOT EXISTS `workflow_for_documents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `project_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `document_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_for_documents_organization_info` (`org_id`),
  KEY `FK_workflow_for_documents_project_setup` (`project_id`),
  KEY `FK_workflow_for_documents_permissions` (`document_type`),
  CONSTRAINT `FK_workflow_for_documents_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_workflow_for_documents_permissions` FOREIGN KEY (`document_type`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_workflow_for_documents_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_for_documents: ~0 rows (approximately)
DELETE FROM `workflow_for_documents`;
/*!40000 ALTER TABLE `workflow_for_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_for_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_job_status
DROP TABLE IF EXISTS `workflow_job_status`;
CREATE TABLE IF NOT EXISTS `workflow_job_status` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `org_id` bigint(20) unsigned NOT NULL,
  `version_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `document_type` varchar(50) NOT NULL,
  `status` varchar(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_job_status: ~0 rows (approximately)
DELETE FROM `workflow_job_status`;
/*!40000 ALTER TABLE `workflow_job_status` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_job_status` ENABLE KEYS */;

-- Dumping structure for table license_db.workflow_levels_for_documents
DROP TABLE IF EXISTS `workflow_levels_for_documents`;
CREATE TABLE IF NOT EXISTS `workflow_levels_for_documents` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_setup_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `document_id` varchar(50) NOT NULL DEFAULT '0',
  `workflow_level_id` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `FK_workflow_levels_for_documents_project_setup` (`project_setup_id`),
  KEY `FK_workflow_levels_for_documents_work_flow_levels` (`workflow_level_id`),
  KEY `FK_workflow_levels_for_documents_permissions` (`document_id`),
  CONSTRAINT `FK2mcpusiohai8y3qved9ee9nsp` FOREIGN KEY (`workflow_level_id`) REFERENCES `flow_level_master` (`id`),
  CONSTRAINT `FK_workflow_levels_for_documents_permissions` FOREIGN KEY (`document_id`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_workflow_levels_for_documents_project_setup` FOREIGN KEY (`project_setup_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_workflow_levels_for_documents_work_flow_levels` FOREIGN KEY (`workflow_level_id`) REFERENCES `work_flow_levels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.workflow_levels_for_documents: ~0 rows (approximately)
DELETE FROM `workflow_levels_for_documents`;
/*!40000 ALTER TABLE `workflow_levels_for_documents` DISABLE KEYS */;
/*!40000 ALTER TABLE `workflow_levels_for_documents` ENABLE KEYS */;

-- Dumping structure for table license_db.work_flow_levels
DROP TABLE IF EXISTS `work_flow_levels`;
CREATE TABLE IF NOT EXISTS `work_flow_levels` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `work_flow_level_name` varchar(200) DEFAULT NULL,
  `active_flag` char(1) DEFAULT 'N',
  `updated_by` bigint(20) unsigned NOT NULL,
  `updated_time` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `org_id` bigint(20) unsigned DEFAULT NULL,
  `display_order` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_work_flow_levels_users` (`updated_by`),
  KEY `FK_work_flow_levels_organization_info` (`org_id`),
  CONSTRAINT `FK_work_flow_levels_organization_info` FOREIGN KEY (`org_id`) REFERENCES `organization_info` (`id`),
  CONSTRAINT `FK_work_flow_levels_users` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.work_flow_levels: ~0 rows (approximately)
DELETE FROM `work_flow_levels`;
/*!40000 ALTER TABLE `work_flow_levels` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_flow_levels` ENABLE KEYS */;

-- Dumping structure for table license_db.work_flow_users_for_project
DROP TABLE IF EXISTS `work_flow_users_for_project`;
CREATE TABLE IF NOT EXISTS `work_flow_users_for_project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `project_id` bigint(20) unsigned NOT NULL,
  `level_id` bigint(20) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `document_list` varchar(50) NOT NULL,
  `active_flag` varchar(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_work_flow_users_for_project_project_setup` (`project_id`),
  KEY `FK_work_flow_users_for_project_work_flow_levels` (`level_id`),
  KEY `FK_work_flow_users_for_project_users` (`user_id`),
  KEY `FK_work_flow_users_for_project_permissions` (`document_list`),
  CONSTRAINT `FK_work_flow_users_for_project_permissions` FOREIGN KEY (`document_list`) REFERENCES `permissions` (`permission_constant_name`),
  CONSTRAINT `FK_work_flow_users_for_project_project_setup` FOREIGN KEY (`project_id`) REFERENCES `project_setup` (`id`),
  CONSTRAINT `FK_work_flow_users_for_project_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `FK_work_flow_users_for_project_work_flow_levels` FOREIGN KEY (`level_id`) REFERENCES `work_flow_levels` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table license_db.work_flow_users_for_project: ~0 rows (approximately)
DELETE FROM `work_flow_users_for_project`;
/*!40000 ALTER TABLE `work_flow_users_for_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `work_flow_users_for_project` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
