drop database if exists revision_gestion_commande;
create DATABASE revision_gestion_commande;
use revision_gestion_commande;

CREATE TABLE clients (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50),
    email VARCHAR(100),
    telephone VARCHAR(20),
    adresse VARCHAR(100),
    date_naissance DATE
);

