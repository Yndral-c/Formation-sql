-- Insertion des données pour la table Clients
USE Gestion_Commandes; 
INSERT INTO Clients (Nom, Email, Téléphone) VALUES
    ('Alice Martin', 'alice.martin@example.com', '0612345678'),
    ('Bob Durand', 'bob.durand@example.com', '0623456789'),
    ('Caroline Dupont', 'caroline.dupont@example.com', '0634567890'),
    ('David Lefevre', 'david.lefevre@example.com', '0645678901'),
    ('Emma Laurent', 'emma.laurent@example.com', '0656789012');

-- Insertion des données pour la table Commandes
INSERT INTO Commandes (Date, Montant_Total, Client_ID) VALUES
    ('2025-05-01', 1300.00, 1),
    ('2025-05-02', 300.00, 2),
    ('2025-05-03', 1500.00, 3),
    ('2025-05-04', 500.00, 4),
    ('2025-05-05', 800.00, 5);

-- Insertion des données pour la table Lignes_Commande
INSERT INTO Lignes_Commande (Commande_ID, Produit_ID, Quantité, Prix_Unitaire) VALUES
    (1, 1, 1, 1200.00),
    (1, 2, 5, 20.00),
    (2, 3, 2, 50.00),
    (2, 4, 1, 200.00),
    (3, 1, 1, 1200.00),
    (3, 5, 2, 80.00),
    (4, 6, 1, 150.00),
    (4, 7, 1, 300.00),
    (5, 8, 1, 100.00),
    (5, 9, 2, 60.00),
    (5, 10, 3, 90.00);

-- Insertion des données pour la table Produits
INSERT INTO Produits (Nom, Prix) VALUES
    ('Ordinateur Portable', 1200.00),
    ('Souris', 20.00),
    ('Clavier', 50.00),
    ('Écran', 200.00),
    ('Casque', 80.00),
    ('Imprimante', 150.00),
    ('Tablette', 300.00),
    ('Disque Dur Externe', 100.00),
    ('Webcam', 60.00),
    ('Routeur Wi-Fi', 90.00);

