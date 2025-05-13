-- créer un index sur une colonne
create index idx_nom_client on Clients(nom);

-- index btree -> pour les recherches exactes et les plages de valeurs
create idx_btree_prix on Factures(prix);

-- index Hash -> pour les recherches exactes
create idx_hash_email on Clients using hash (email);

-- index Bitmap -> pour les colonnes avec un nombre limité de valeurs distinctes
create idx_bitmap_sexe on Clients using bitmap (sexe);

--index fulltext -> pour les recherches textuelles
create idx_description on Produits (description);

-- index composite -> pour les recherches sur plusieurs colonnes
create index idx_clients_nom_prenom on Clients(nom, prenom);

-- optimiser des requêtes 
-- selectionner les bonnes colonnes qui seront les plus souvent utilisées pour mettre 
-- les index au bon endroit