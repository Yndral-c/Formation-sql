# TP 10 Location de ski

## Partie 1 - Créer la Base de données  
  


```sql
drop database if exists location_ski;
create database location_ski;
use location_ski;

create table clients(
noCli int not null,
nom varchar(30) not null,
prenom varchar(30),
adresse varchar(120),
cpo varchar(5) not null, 
ville varchar(80) not null,
constraint pk_clients primary key(noCli)
)engine=InnoDB;

create table fiches(
noFic int not null,
noCli int not null,
dateCrea date not null, 
datePaiement date,
etat enum('SO', 'EC', 'RE') not null,
constraint pk_fiches primary key (noFIC)) engine=InnoDB;

create table lignesFic(
noLig int not null,
noFic int not null,
refart char(8) not null,
depart date not null,
retour date,
constraint pk_ligneFic primary key(noLig, noFic))engine=InnoDB;

create table articles(
refart char(8) not null,
designation varchar(80) not null,
codeGam char(5),
codeCate char(5),
constraint pk_articles primary key(refart))engine=InnoDB;

create table categories(
codeCate char(5) not null,
libelle varchar(30) not null,
constraint pk_categories primary key(codeCate))engine=InnoDB;

create table gammes(
codeGam char(5) not null,
libelle varchar(45) not null,
constraint pk_gammes primary key(codeGam))engine=InnoDB;

create table grilleTarifs(
codeGam char(5) not null,
codeCate char(5) not null, 
codeTarif char(5),
constraint pk_grilleTarifs primary key(codeGam, codeCate))engine=InnoDB;

create table tarifs(
codeTarif char(5) not null,
libelle char(30) not null,
prixjour decimal(5,0) not null,
constraint pk_tarifs primary key(codeTarif))engine=InnoDB;

alter table fiches add constraint fk_fiches foreign key (noCli) references clients(noCli);
alter table lignesFic add constraint fk_lignesFic foreign key (noFic) references fiches(noFic);
alter table lignesFic add constraint fk_lignesFic2 foreign key (refart) references articles(refart);
alter table articles  add constraint fk_articles foreign key (codeGam) references gammes(codeGam);
alter table articles add constraint fk_articles2 foreign key (codeCate) references categories(codeCate);
alter table grilleTarifs add constraint fk_grilleTarifs foreign key(codeGam) references gammes(codeGam);
alter table grilleTarifs add constraint fk_grilleTarifs2 foreign key (codeCate) references categories(codeCate);
alter table grilleTarifs add constraint kf_grilleTarifs3 foreign key (codeTarif) references tarifs(codeTarif);
```


## Partie 2

:one:  Liste des clients (toutes les informations) dont le nom commence par un <code>D</code> 
|noCli|nom|prenom|adresse|cpo|ville|
|---|---|---|---|---|---|
|3|Dupond|Camille|Rue Crébillon|44000|Nantes|
|4|Desmoulin|Daniel|Rue descendante|21000|Dijon|
|9|Dupond|Jean|Rue des mimosas|75018 |Paris| 
  
```sql
use location_ski;

select * from clients
where nom like 'D%';
```

:two: Nom et prénom de tous les clients
|prenom|nom|
|---|---|
|Albert|Anatole|
|Bernard|Barnab|
|Dupond|Camille|
|Desmoulin|Daniel|
|Ferdinand|François|
|Albert|Anatole|
|Dupond|Jean|
|Boutaud|Sabine|  

```sql
use location_ski;

select nom, prenom from clients;
```

:three:  Liste des fiches (n°, état) pour les clients (nom, prénom) qui habitent en Loire Atlantique (44) 
|noFic|etat|nom|prenom|
|---|---|---|---|
|1004|EC|Ferdinand|François|
|1005|EC|Dupond|Camille|  

```sql
use location_ski;

select fiches.noFic, fiches.etat, clients.nom, clients.prenom from fiches
inner join clients on fiches.noCli = clients.noCli
where clients.cpo like '44%';
```

:four: Détail de la fiche n°1002
|noFic|nom|prenom|refart|designation|depart|retour|prixJour|montant|
|---|---|---|---|---|---|---|---|---|
|1002|Desmoulin|Daniel|A03|Salomon 24X+Z12|2024-11-18|2024-11-22|10|50|
|1002|Desmoulin|Daniel|A04|Salomon 24X+Z12|2024-11-19|2024-11-24|10|60|
|1002|Desmoulin|Daniel|S03|Décathlon Apparition|2024-11-23|NULL|10|90|  

```sql
use location_ski;

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
```

:five: Prix journalier moyen de location par gamme
|Gamme|tarif journalier moyen|
|---|---|
|Entrée de gamme|10.833333|
|Haut de gamme|27.500000|
|Moyenne gamme|15.833333|
|Matériel Professionnel|80.000000|  

```sql
use location_ski;

select gammes.libelle, avg(tarifs.prixjour) as 'tarif journalier moyen' 
from gammes
inner join grilleTarifs on gammes.codeGam = grilleTarifs.codeGam
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
group by gammes.libelle;
```

:six: Détail de la fiche n°1002 avec le **total**
|noFic|nom|prenom|refart|designation|depart|retour|prixJour|Montant|Total|
|---|---|---|---|---|---|---|---|---|---|
|1002|Desmoulin|Daniel|A03|"Salomon 24X+Z12"|2024-11-18|2024-11-22|10|50|200|
|1002|Desmoulin|Daniel|A04|"Salomon 24X+Z12"|2024-11-19|2024-11-24|10|60|200|
|1002|Desmoulin|Daniel|S03|"Décathlon Apparition"|2024-11-23|NULL|10|90|200|  

```sql
use location_ski;

select fiches.noFic, clients.nom, clients.prenom, articles.refart, articles.designation, 
lignesFic.depart, lignesFic.retour, tarifs.prixjour, 
(datediff(if(lignesFic.retour is null, now(), lignesFic.retour), lignesFic.depart)+1) * tarifs.prixjour as 'montant',
sum('montant') as 'Total' from fiches -- total pas trouvé
inner join clients on fiches.noCli = clients.noCli
inner join lignesFic on fiches.noFic = lignesFic.noFic
inner join articles on 	lignesFic.refart = articles.refart
inner join categories on articles.codeCate = categories.codeCate
inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
where fiches.noFic = 1002
group by articles.refart;
```

:seven:  Grille des tarifs
|libelle|libelle|libelle|prixJour|  
|---|---|---|---|
|Ski de fond alternatif|Entrée de gamme|Base|10|
|Ski de fond patineur|Entrée de gamme|Chocolat|15|
|Monoski|Entrée de gamme|Base|10|
|Patinette|Entrée de gamme|Base|10|
|Ski alpin|Entrée de gamme|Base|10|
|Surf|Entrée de gamme|Base|10|
|Ski de fond alternatif|Haut de gamme|Argent|30|
|Ski de fond patineur|Haut de gamme|Argent|30|
|Ski alpin|Haut de gamme|Argent|30|
|Surf|Haut de gamme|Bronze|20|
|Ski de fond alternatif|Moyenne gamme|Chocolat|15|
|Ski de fond patineur|Moyenne gamme|Bronze|20|
|Monoski|Moyenne gamme|Chocolat|15|
|Patinette|Moyenne gamme|Chocolat|15|
|Ski alpin|Moyenne gamme|Chocolat|15|
|Surf|Moyenne gamme|Chocolat|15|
|Ski de fond alternatif|Matériel Professionnel|Platine|90|
|Ski de fond patineur|Matériel Professionnel|Platine|90|
|Ski alpin|Matériel Professionnel|Platine|90|
|Surf|Matériel Professionnel|Or|50|  

```sql
use location_ski;

select categories.libelle, gammes.libelle, tarifs.libelle, tarifs.prixjour 
from categories inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join gammes on grilleTarifs.codeGam = gammes.codeGam
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
order by gammes.codeGam;
```

:eight:  Liste des locations de la catégorie SURF
|refart|designation|nbLocation|
|---|---|---|
|S01|"Décathlon Apparition"|2|
|S02|"Décathlon Apparition"|2|
|S03|"Décathlon Apparition"|2|  

```sql
use location_ski;

select articles.refart, articles.designation, count(articles.refart) as 'nbLocation' 
from articles
where articles.refart like 'S%'
group by articles.refart;
```
:nine: Calcul du nombre moyen d’articles loués par fiche de location
```sql
use location_ski;

select avg(nb_lignes_moyen_par_fiche )
from (
select count(noLig) as nb_lignes_moyen_par_fiche 
from lignesFic
group by noFic) as subquery
```

**10** - Calcul du nombre de fiches de location établies pour les catégories de location Ski alpin, Surf et Patinette
|catégorie|nombre de location|
|---|---|
|Ski alpin|2|
|Patinette|1|
|Surf|6|

```sql
use location_ski;

select categories.libelle, count(lignesFic.noFic)
from categories
join articles on categories.codeCate = articles.codeCate
join lignesFic on articles.refart = lignesFic.refart
where categories.codeCate in ('SURF', 'PA', 'SA')
group by categories.libelle
```

**11** Calcul du montant moyen des fiches de location
|montant moyen d'une fiche de location|
|---|
|131.8750|

```sql
use location_ski;

select avg((datediff(if(lignesFic.retour is null, now(), lignesFic.retour), lignesFic.depart)+1) * tarifs.prixjour) as 'montant'
from fiches
inner join clients on fiches.noCli = clients.noCli
inner join lignesFic on fiches.noFic = lignesFic.noFic
inner join articles on 	lignesFic.refart = articles.refart
inner join categories on articles.codeCate = categories.codeCate
inner join grilleTarifs on categories.codeCate = grilleTarifs.codeCate
inner join tarifs on grilleTarifs.codeTarif = tarifs.codeTarif
```