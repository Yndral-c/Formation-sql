use magasin;
insert into clients (nom, prenom, ville, code_postal, pays, email, telephone) values
('Dupont', 'Jean', 'Paris', '75001', 'France', 'dupont.jean@gmail.com', '0123456789'),
('Martin', 'Sophie', 'Lyon', '69001', 'France', 'martin.sophie@gmail.com', '0987654321'),
('Durand', 'Pierre', 'Marseille', '13001', 'France', 'durand.pierre@gmail.com', '0147852369');

insert into produits (nom_produits, prix, stock, description_produits) values
('Ski Alpin', 299.99, 10, 'Ski alpin de haute qualité pour les amateurs de sensations fortes.'),
('Snowboard', 399.99, 5, 'Snowboard pour les passionnés de glisse sur neige.'),
('Luge', 49.99, 20, 'Luge en plastique pour les enfants et les adultes.');

insert into commandes (id_client, date_commande) values
(1, '2023-10-01 10:00:00'),
(2, '2023-10-02 11:30:00'),
(3, '2023-10-03 14:45:00');

insert into detail_commande (id_commande, id_produit, quantite, prix_unitaire) values
(1, 1, 2, 299.99),
(1, 2, 1, 399.99),
(2, 3, 5, 49.99),
(3, 1, 1, 299.99),
(3, 3, 2, 49.99);