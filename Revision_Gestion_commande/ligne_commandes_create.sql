CREATE TABLE ligne_commandes (
    ligne_commande_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT,
    produit_id INT,
    quantite INT,
    prix_unitaire DECIMAL(10, 2)
);
