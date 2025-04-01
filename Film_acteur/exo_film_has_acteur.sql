use prime_vdo;


select acteur.prenom, acteur.nom, count(film.id) from film join film_has_acteur on film.id = film_has_acteur.film_id
join acteur on film_has_acteur.acteur_id = acteur.id
group by acteur.prenom;

insert into film(id, nom)
values (3, 'TITANIC');
insert into film_has_acteur(film_id, acteur_id)
values (3, 2);

select film.nom, acteur.prenom, acteur.nom from film
join film_has_acteur on film.id = film_has_acteur.film_id
join acteur on film_has_acteur.acteur_id = acteur.id;

insert into acteur(prenom, nom)
values ('Tom', 'CRUISE');

select acteur.prenom, acteur.nom, count(film.id) as 'nb_film' from acteur
left join film_has_acteur on acteur.id = film_has_acteur.acteur_id
left join film on film.id = film_has_acteur.film_id
group by acteur.nom;

select acteur.prenom, acteur.nom, count(film.id)
from acteur 
inner join film_has_acteur on acteur.id = film_has_acteur.acteur_id
inner join film on film.id=film_has_acteur.film_id
group by acteur.nom having count(film.id) > 0;

-- combien d'acteur en moyenne jouent dans un film
SELECT AVG(nb_acteurs) AS moyenne_acteurs_par_film
FROM (
    SELECT film_id, COUNT(acteur_id) AS nb_acteurs
    FROM film_has_acteur
    GROUP BY film_id
) AS acteurs_par_film;
