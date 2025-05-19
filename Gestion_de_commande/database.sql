-- Création de la base de données 

CREATE DATABASE Gestion_Commandes; 

USE Gestion_Commandes; 

-- Création de la table Clients 

CREATE TABLE Clients ( 
    Client_ID INT AUTO_INCREMENT PRIMARY KEY, 

    Nom VARCHAR(50) NOT NULL, 

    Email VARCHAR(100) NOT NULL UNIQUE, 

    Téléphone VARCHAR(15) 

); 

-- Création de la table Produits 

CREATE TABLE Produits ( 

    Produit_ID INT AUTO_INCREMENT PRIMARY KEY, 

    Nom VARCHAR(100) NOT NULL, 

    Prix DECIMAL(10, 2) NOT NULL 

); 


-- Création de la table Commandes 

CREATE TABLE Commandes ( 

    Commande_ID INT AUTO_INCREMENT PRIMARY KEY, 

    Date DATE NOT NULL, 

    Montant_Total DECIMAL(15, 2) NOT NULL, 

    Client_ID INT, 

    FOREIGN KEY (Client_ID) REFERENCES Clients(Client_ID) 

); 

-- Création de la table Lignes_Commande 

CREATE TABLE Lignes_Commande ( 

    Ligne_ID INT AUTO_INCREMENT PRIMARY KEY, 

    Commande_ID INT, 

    Produit_ID INT, 

    Quantité INT NOT NULL, 

    Prix_Unitaire DECIMAL(10, 2) NOT NULL, 

    FOREIGN KEY (Commande_ID) REFERENCES Commandes(Commande_ID), 

    FOREIGN KEY (Produit_ID) REFERENCES Produits(Produit_ID) 

 