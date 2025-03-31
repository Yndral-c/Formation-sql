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