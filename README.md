# Titre 1
## Titre 2
### Titre 3

|prenom|nom|date_achat|nom|prix|nb|total|
|---|---|---|---|---|---|---|
|PITT|Brad|2024-09-08 10:15:00|X box|350|1|350|
|PITT|Brad|2024-09-08 10:15:00|Machine à café|300|1|300|
|PITT|Brad|2024-09-08 10:15:00|PlayStation 3|100|2|200|

lorem upsum  
**gras**  
*italique*  
<mark>surligner</mark>  
<code>ficher.md</code>

liste :  
- rouge
    - sous liste rouge
        - sous sous liste rouge
- vert

### Gestion ds rôles et permissions SQL
```sql
CREATE ROLE Read_Only;
GANT SELECT ON Clients TO Read_Only
```

### Journaux de sécurité
Utiliser des logs pour détecter une tentative d'intrusion

### MAJ des SGDB
Les versions actuelles de certaines BDD sont trop ancienne ce qui empêche de les MAJ

### Configuration d'un Pare-feu
Changer le port de connexion de base du serveur pour rendre plus difficile les attaques sur les BDD

### Accorder tous les probilèges à un user
```sql
GRANT ALL PRIVILEGES
```

