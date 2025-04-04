use location_ski;
-- Liste des clients (toutes les informations) dont le nom commence par un D
select * from clients
where nom like 'D%';

-- Nom et prénom de tous les clients
select nom, prenom from clients;

-- Liste des fiches (n°, état) pour les clients (nom, prénom) qui habitent en Loire Atlantique (44)
select fiches.noFic, fiches.etat, clients.nom, clients.prenom from fiches
inner join clients on fiches.noCli = clients.noCli
where clients.cpo like '44%';

-- Détail de la fiche n°1002
select fiches.noFic, clients.nom, clients.prenom, articles.refart, articles.designation, 
lignesFic.depart, lignesFic.retour, tarifs.prixjour, (datediff(if(lignesFic.retour is null, now(), lignesFic.retour), lignesFic.depart)+1) * tarifs.prixjour as 'montant' from fiches
inner join clients on fiches.noCli = clients.noCli
inner join lignesFic on fiches.noFic = lignesFic.noFic
inner join articles on 	lignesFic.refart = articles.refart
inner join categories on articles.codeCate = categories.codeCate
inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
where fiches.noFic = 1002
group by articles.refart;

-- Prix journalier moyen de location par gamme
select gammes.libelle, avg(tarifs.prixjour) as 'tarif journalier moyen' from gammes
inner join grilleTarifs on gammes.codeGam = grilleTarifs.codeGam
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
group by gammes.libelle;

-- Détail de la fiche n°1002 avec le total
USE location_ski;
SELECT  f.noFic, nom, prenom, 
	a.refart, designation, depart, retour, prixJour,
(DATEDIFF(IFNULL(retour, NOW()+1),depart)+1)*prixJour as Montant, Total
FROM 
	fiches f
	JOIN clients c USING (noCli)
	JOIN lignesfic l ON f.noFic = l.noFic
	JOIN articles a ON l.refart=a.refart
	JOIN grilletarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
	JOIN tarifs t ON g.codeTarif = t.codeTarif
    JOIN (
		SELECT  l.noFic,
		SUM( (DATEDIFF(IFNULL(retour, NOW()+1),depart)+1)*prixJour) as total
        FROM 
			lignesfic l
			JOIN articles a ON l.refart=a.refart
			JOIN grilletarifs g ON (a.codeGam=g.codeGam AND a.codeCate=g.codeCate)
			JOIN tarifs t ON g.codeTarif = t.codeTarif
            WHERE l.noFic=1002
            GROUP BY l.noFic ) info ON info.noFic = f.noFic;

-- 	Grille des tarifs
select categories.libelle, gammes.libelle, tarifs.libelle, tarifs.prixjour 
from categories inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join gammes on grilleTarifs.codeGam = gammes.codeGam
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
order by gammes.codeGam;

-- Liste des locations de la catégorie SURF
select articles.refart, articles.designation, count(articles.refart) as 'nbLocation' from articles
where articles.refart like 'S%'
group by articles.refart;

-- Calcul du nombre moyen d’articles loués par fiche de location

use location_ski;

select avg(nb_lignes_moyen_par_fiche )
from (
select count(noLig) as nb_lignes_moyen_par_fiche 
from lignesFic
group by noFic) as subquery

-- Calcul du nombre de fiches de location établies pour les catégories de location Ski alpin, Surf et Patinette
use location_ski;

select categories.libelle, count(lignesFic.noFic)
from categories
join articles on categories.codeCate = articles.codeCate
join lignesFic on articles.refart = lignesFic.refart
where categories.codeCate in ('SURF', 'PA', 'SA')
group by categories.libelle

-- Calcul du montant moyen des fiches de location
use location_ski;

select avg((datediff(if(lignesFic.retour is null, now(), lignesFic.retour), lignesFic.depart)+1) * tarifs.prixjour) as 'montant'
from fiches
inner join clients on fiches.noCli = clients.noCli
inner join lignesFic on fiches.noFic = lignesFic.noFic
inner join articles on 	lignesFic.refart = articles.refart
inner join categories on articles.codeCate = categories.codeCate
inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif