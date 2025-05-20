CREATE TABLE produits (
    produit_id INT PRIMARY KEY AUTO_INCREMENT,
    nom_produit VARCHAR(100),
    categorie VARCHAR(50),
    prix_achat DECIMAL(10, 2),
    prix_vente DECIMAL(10, 2),
    stock INT
);
