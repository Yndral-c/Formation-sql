# TP 11 - Location de ski Saison 2

:one: Liste des clients (nom, prénom, adresse, code postal, ville) ayant au moins une fiche de location en cours.

```sql
USE location_ski;

select nom, prenom, adresse, cpo, ville from clients
join fiches on clients.noCli = fiches.noCli
where fiches.etat like 'EC'
```

:two: Détail de la fiche de location de M. Dupond Jean de Paris (avec la désignation des articles loués, la date de départ et de retour).

```sql
USE location_ski;

select nom, prenom, ville, articles.designation, lignesFic.depart, lignesFic.retour
from clients
join fiches on clients.noCli = fiches.noCli
join lignesFic on fiches.noFic = lignesFic.noFic
join articles on lignesFic.refart = articles.refart
where nom like 'Dupond' and prenom like 'Jean' and ville like 'Paris'
```

:three: Liste de tous les articles (référence, désignation et libellé de la catégorie) dont le libellé de la catégorie contient ski.

```sql
USE location_ski;

select articles.refart, articles.designation, categories.libelle from articles
join categories on articles.codeCate = categories.codeCate
where categories.libelle like '%ski%'
```

:four: Calcul du montant de chaque fiche soldée et du montant total des fiches.

```sql

```