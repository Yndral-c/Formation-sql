# TP 08 - Film avec acteurs

:one: Afficher tous les films de Brad PITT 

| film | acteur_prenom | acteur_nom |
|--- |--- |--- |
|ONce UpON the time |  Brad | PITT |
|Fight Club |  Brad | PITT |

```sql
USE prime_vdo;

SELECT 
film.nom AS film,
acteur.prenom,
acteur.nom
FROM film
INNER JOIN film_has_acteur  ON film.id = film_has_acteur.film_id
INNER JOIN acteur ON acteur.id = film_has_acteur.acteur_id
WHERE acteur_id=1
```

:two: Afficher le nombre de films par acteur
| acteur_prenom | acteur_nom |  nb_films | 
|--- |--- |--- |
|  Leonardo | DICAPRIO | 1|
| Brad | PITT | 2 |

```sql
USE prime_vdo;

SELECT 
film.nom, acteur.prenom, acteur.nom 
FROM film
JOIN film_has_acteur ON film.id = film_has_acteur.film_id
JOIN acteur ON film_has_acteur.acteur_id = acteur.id;
```

:three: Ajouter un film TITANIC
```sql
USE prime_vdo;

INSERT INTO film(nom)
VALUES ('TITANIC');
```
  

:four: Trouver le film qui n'a pas d'acteur
| film | 
|--- |
|  TITANIC |

```sql
USE prime_vdo;

SELECT 
film.nom, 
acteur_id
FROM film
LEFT JOIN film_has_acteur ON film.id=film_has_acteur.film_id
WHERE acteur_id IS NULL
```  
:five: Associer LeONardo DICAPRIO dans le film TITANIC  

```sql
USE prime_vdo;

INSERT INTO film_has_acteur(film_id, acteur_id)
VALUES (3, 2);
```

:six: Afficher tous les film avec acteurs 
 | film | acteur_prenom | acteur_nom |
|--- |--- |--- |
|Once Upon the time |  Leonardo | DICAPRIO |
|Once Upon the time |  Brad | PITT |
|Fight Club |  Brad | PITT |
|TITANIC |  Leonardo | DICAPRIO |

```sql
USE prime_vdo;

SELECT 
film.nom, acteur.prenom, acteur.nom 
FROM film
JOIN film_has_acteur ON film.id = film_has_acteur.film_id
JOIN acteur ON film_has_acteur.acteur_id = acteur.id;
```  

:seven: Ajouter un acteur TOM CRUISE  
```sql
USE prime_vdo;
INSERT INTO acteur (prenom,nom) 
VALUES ('TOM','CRUISE');
```

:eight: Afficher le nombre de films par acteur en incluant TOM CRUISE
| acteur_prenom | acteur_nom |  nb_films | 
|--- |--- |--- |
| Brad | PITT | 2 |
|  Leonardo | DICAPRIO | 1|
| TOM | CRUISE | 0 |

```sql
USE prime_vdo;

SELECT acteur.prenom, acteur.nom, count(film.id) as 'nb_film' FROM acteur
LEFT JOIN film_has_acteur ON acteur.id = film_has_acteur.acteur_id
LEFT JOIN film ON film.id = film_has_acteur.film_id
GROUP BY acteur.nom;
```

**9** - Afficher les acteurs ayant jouer dans 2 films avec <code>Having</code>

```sql
USE prime_vdo;

SELECT acteur.prenom, acteur.nom, count(film.id)
FROM acteur 
INNER JOIN film_has_acteur ON acteur.id = film_has_acteur.acteur_id
INNER JOIN film ON film.id=film_has_acteur.film_id
GROUP BY acteur.nom HAVING count(film.id) > 0;
```  

**10** - En moyenne Combien d'acteurs jouent dans 1 film ?
| acteur_par_film |
|--- |
| 1,3333 |

```sql
USE prime_vdo;

SELECT AVG(nb_acteurs) AS moyenne_acteurs_par_film
FROM (
    SELECT film_id, COUNT(acteur_id) AS nb_acteurs
    FROM film_has_acteur
    GROUP BY film_id
) AS acteurs_par_film;
```  

**11** - Effacer les 3 tables avec <code>DROP TABLE</code>  

```sql
DROP DATABASE prime_vdo;
```