-- Insertion des données pour la table Clients
C 
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
-- nombre de commandes dans la base de données
SELECT COUNT(*) AS Nombre_Commandes FROM Commandes;

-- nom des clients
select nom from clients;

-- produit qu'Alice à acheté
select produits.nom from produits
inner join lignes_commande on lignes_commande.produit_id = produits.produit_id
inner join commandes on lignes_commande.commande_id = commandes.commande_id
inner join clients on commandes.client_id = clients.client_id
where clients.nom = 'Alice Martin';

-- total des ventes par produit
select p.nom as nom_produit, sum(lc.quantité * lc.prix_unitaire) from produits p
join lignes_commande lc on p.produit_id = lc.produit_id
group by nom_produit;

-- montant total des commandes par client
select cl.`Client_ID`, cl.nom as nom_client, sum(c.`Montant_Total`) as montant_total 
from clients cl
join commandes c on cl.client_id = c.client_id
GROUP BY nom_client;

-- créer une vue pour le total des ventes par produit
-- on créer une vue pour faire un dash board par exemple, exposer les données 
CREATE OR REPLACE VIEW v_total_ventes_produits as 
select p.produit_id, p.nom as nom_produit, sum(lc.quantité * lc.prix_unitaire) from produits p
join lignes_commande lc on p.produit_id = lc.produit_id
group by p.produit_id;

-- vue classement des clients selon le total de leurs commandes
create or replace view v_classement_clients_total_commandes as 
select cl.client_id, cl.nom as nom_client, sum(c.montant_total) as montant_total, 
case 
    when `Montant_Total` > 200 then "Très bon client"
    when `Montant_Total` > 100 then "Bon client"
    else "Client" 
end as statut_client

from clients cl
join commandes c on cl.client_id = c.`Client_ID`
group by cl.client_id
order by montant_total desc;

-- requête analyse mensuelle des ventes
create or replace view v_ventes_mensuelles as
select year(commandes.date) as annee, month(commandes.date) as mois, sum(montant_total) as montant_total
from commandes
group by year(Date), month(Date)
order by annee, mois;

-- vue mensuelle des ventes
create or replace view v_mensuelles_ventes as 
select year(date) as annee, month(date) as mois, sum(montant_total) as total_ventes
from commandes
group by year(date), month(date)
order by annee, mois
