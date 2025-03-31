drop database crm;
CREATE DATABASE crm;
USE crm;

CREATE TABLE IF NOT EXISTS `client` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `nom` varchar(255)
);

CREATE TABLE IF NOT EXISTS `facture` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `prix` integer,
  `facture_emise` date,
  `paiement` date,
  `devis_id` varchar(255)
);

CREATE TABLE IF NOT EXISTS `devis` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `info` varchar(255),
  `version` int NOT NULL,
  `montant_total` int,
  `projet_id` int
);

CREATE TABLE IF NOT EXISTS `projet` (
  `id` integer PRIMARY KEY AUTO_INCREMENT,
  `intitule` varchar(255),
  `client_id` integer
);

ALTER TABLE `projet` ADD FOREIGN KEY (`client_id`) REFERENCES `client` (`id`);

ALTER TABLE `devis` ADD FOREIGN KEY (`projet_id`) REFERENCES `projet` (`id`);

ALTER TABLE `facture` ADD FOREIGN KEY (`devis_id`) REFERENCES `devis` (`id`);