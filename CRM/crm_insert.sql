-- Sélection de la base de données
USE crm;
TRUNCATE TABLE client;
TRUNCATE TABLE projet;
TRUNCATE TABLE devis;
TRUNCATE TABLE facture;

-- Insertion des Factures
INSERT INTO facture (prix, facture_emise, paiement, devis_id) VALUES
(1500, '2023-09-01', '2023-10-01', 1),  -- FA001
(1500, '2023-09-20', NULL, 2),           -- FA002
(5000, '2024-02-01', NULL, 3),           -- FA003
(3000, '2024-03-01', '2024-04-03', 4),   -- FA004
(5000, '2023-03-01', NULL, 5),           -- FA005
(2000, '2023-03-01', NULL, 6);           -- FA006
-- Insertion des Devis
INSERT INTO devis (info, version, montant_total, projet_id) VALUES
('DEV2100A', 1, 3000, 1), 
('DEV2100B', 2, 5000, 1), 
('DEV2100C', 1, 5000, 2), 
('DEV2100D', 1, 3000, 3), 
('DEV2100E', 1, 5000, 4), 
('DEV2100F', 1, 2000, 5), 
('DEV2100G', 1, 1000, 6);

-- Insertion des Projets
INSERT INTO projet (intitule, client_id) VALUES
('Creation de site internet', 1),
('Logiciel CRM', 2),
('Logiciel de devis', 3),
('Site internet ecommerce', 4),
('logiciel ERP', 2),
('logiciel Gestion de Stock', 5);

-- Insertion des Clients
INSERT INTO client (nom) VALUES
('Mairie de Rennes'),
('Neo Soft'),
('Sopra'),
('Accenture'),
('Amazon');