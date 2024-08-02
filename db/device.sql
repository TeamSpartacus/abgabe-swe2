CREATE TABLE IF NOT EXISTS `device` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `longname` varchar(255) NOT NULL,
  `shortname` varchar(255) NOT NULL,
  `task` text NOT NULL,
  `modelnumber` varchar(255) NOT NULL,
  `registernumber` varchar(255) NOT NULL,
  `manufacturer` varchar(255) NOT NULL,
  `lastmaintenance` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `user` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  /* General Device Informations */
  `deviceStatus` int(11) NOT NULL DEFAULT 0,
  `registerDateStart` timestamp,
  `registerDateEnd` timestamp,
  PRIMARY KEY (`uid`)
) /* ENGINE=InnoDB */ DEFAULT CHARSET=utf8mb4;