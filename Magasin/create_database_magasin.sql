drop database if exists magasin;
create database magasin CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

use magasin;

create table clients(
	id_clients INT NOT NULL primary key auto_increment,
    nom VARCHAR(50) not null,
    prenom varchar(50) not null,
    ville varchar(150) not null,
    code_postal varchar(20) not null,
    pays varchar (150) not null,
    email varchar(255) not null,
    telephone varchar(10))ENGINE=InnoDB;

create index idx_nom_clients on clients(nom);

create table produits(
	id_produits int not null primary key auto_increment,
    nom_produits varchar(50) not null,
    prix decimal(10, 2) not null,
    stock int not null,
    description_produits text)engine=InnoDB;

create table commandes(
	id_commandes int not null primary key auto_increment,
    id_client int not null,
    date_commande datetime default current_timestamp,
	foreign key (id_client) references clients(id_clients))engine=innodb;

create table detail_commande(
	id_detail INT PRIMARY KEY AUTO_INCREMENT,
    id_commande INT NOT NULL,
    id_produit INT NOT NULL,
    quantite INT NOT NULL,
    prix_unitaire DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commandes),
    foreign key (id_produit) references produits(id_produits))engine=innodb

select * from clients;