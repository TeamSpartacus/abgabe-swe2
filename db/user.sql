CREATE TABLE IF NOT EXISTS `user` (
    `uuid` int(11) NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `display_name` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `secondname` VARCHAR(255) NOT NULL,
    `occupation` VARCHAR(255) NOT NULL,
    `permissions` TINYINT UNSIGNED DEFAULT NULL,
    `passwordhash` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`uuid`)
) /* ENGINE=InnoDB */ DEFAULT CHARSET=utf8mb4;

INSERT INTO `user` (`email`,`display_name`,`name`,`secondname`,`occupation`,`permissions`,`passwordhash`) VALUES
('admin@admin.admin','Admin','admin','admin','administrator',3,'8ccb096c6ce717e6db5ec5c9b4d22c27c3b5a140d37299a200f0312d9fc37601'); --Passwort Klar H6v:3,h30AD