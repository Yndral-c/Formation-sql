use revision_gestion_commande;

-- analyse des ventes

-- A. Calacul du CA
select sum(total) as chiffre_affaire
from commandes;

-- B. Ventes par mois
select sum(total) as chiffre_affaire, year(Date_commande) as annee, month(Date_commande) as mois from commandes
group by year(Date_commande), month(Date_commande);

-- C. top 5 des clients ayant dépensé le plus
select cl.nom, sum(co.total) as montant_total
from clients cl 
join commandes co on cl.client_id = co.commande_id
group by cl.client_id
limit 5;
-- changer le format d'une date
select date_format(date_commande, '%d-%m-%Y') from commandes;

-- D. Total des ventes par categorie de produit
select p.categorie, sum(lc.quantite)  as total_ventes
from produits p
join ligne_commandes lc on lc.produit_id = p.produit_id
join commandes co on lc.commande_id = co.commande_id
group by p.categorie
order by total_ventes desc;

-- E. prévision des ventes saisonnières (total des ventes par trimestre)
select year(co.date_commande ) as annee, quarter(co.date_commande) as trimestre, sum(co.total) as total_ventes FROM
commandes co 
group by annee, trimestre
order by annee;

-- 2. liste des produits
-- A. Le produit le plus vendu
select p.nom_produit, sum(lc.quantite) as quantite from produits p
join ligne_commandes lc on p.produit_id = lc.produit_id
group by p.nom_produit
order by quantite desc
limit 1;

-- B. produit le plus rentable
select nom_produit, sum((prix_vente - prix_achat)*100 / prix_vente) as rent
from produits
group by nom_produit
order by rent desc
limit 1;

-- C. produit en déclin
select nom_produit, sum(lc.quantite * lc.prix_unitaire) as prix_total
from produits p
join ligne_commandes lc on p.produit_id = lc.produit_id
join commandes co on lc.commande_id = co.commande_id
where co.date_commande >= DATE_SUB("2023-05-20", INTERVAL 3 MONTH)
group by nom_produit
order by prix_total asc
limit 3;

-- EXOS PM
-- 1. Quels sont les produits dont le stock à moins de 10 articles ?
select *
from produits
where stock < 10;

-- 2. Total des ventes (argent) par  client
select nom, sum(co.total) as total_ventes
from clients cl
join commandes co on cl.client_id = co.client_id
group by cl.client_id
order by total_ventes desc

-- 3. Classement des 10 jours où le CA a été le plus élevé
select DATE_FORMAT(date_commande, '%d-%m-%Y') as date, sum(total) as total_ventes
from commandes
group by date_commande
order by total_ventes desc
limit 10;

-- 4. Comment savoir quel client n'a jamais commandé ?
select * from clients cl
left join commandes co on cl.client_id = co.client_id
where co.client_id is null;

-- 5. Stocekr les détails d'une commande dans une vue (commande_id, date_commande, nom client, nom produit, montant)
create or replace view v_details_commande AS
select co.commande_id, date_commande, cl.nom, p.nom_produit, total
from commandes co
join clients cl on co.client_id = cl.client_id
join ligne_commandes lc on co.commande_id = lc.commande_id
join produits p on lc.produit_id = p.produit_id
where co.commande_id = 42;

-- 6. Quelles sont les commandes qui ont plus de 3 lignes ?
select cl.nom, co.commande_id, count(lc.produit_id) as nombre_lignes
from clients cl
join commandes co on cl.client_id = co.client_id
join ligne_commandes lc on co.commande_id = lc.commande_id
group by co.commande_id
having count(lc.produit_id) > 3;

-- 7. Le nombre moyen de lignes de commandes par commande
select avg(nb_articles) as moyenne_lignes
from (
    select count(*) nb_articles
    from ligne_commandes lc
    group by lc.commande_id
) as moyenne_par_commande;

-- 8. Quel est le montant le plus élevé pour une commande ?
select cl.nom, co.total
from clients cl
join commandes co on cl.client_id = co.client_id
group by cl.client_id
order by co.total desc
limit 1;

-- 9. Lister par client leur dernière commande
