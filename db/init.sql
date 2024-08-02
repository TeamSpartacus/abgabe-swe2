CREATE DATABASE IF NOT EXISTS awi_device_management_system;

USE awi_device_management_system;

CREATE USER IF NOT EXISTS 'awi-device-management-system'@'localhost' IDENTIFIED BY 'G?DS)DS)Fgu?SD)/VgDS)?/gSDU))SD/ZTGSDUHG)SD/g';

GRANT ALL PRIVILEGES ON awi_device_management_system.* TO 'awi-device-management-system'@'localhost' WITH GRANT OPTION;
