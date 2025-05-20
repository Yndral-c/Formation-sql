use revision_gestion_commande;
CREATE TABLE commandes (
    commande_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date_commande DATE,
    total DECIMAL(10, 2),
    statut VARCHAR(50)
);
