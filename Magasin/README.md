**Mise en situation 1** : Gestion des Stocks pour une Entreprise de Distribution 
Vous travaillez pour une entreprise de distribution qui doit gérer des milliers de produits. Vous devez créer un système capable de suivre les stocks, les fournisseurs et les ventes en temps réel. Quels types de tables et de requêtes créeriez-vous pour répondre à ce besoin ? 

CREATE TABLE

**Mise en situation 2 **: Système de Gestion des Employés dans une Grande Entreprise 
Une grande entreprise souhaite centraliser les informations sur ses employés, y compris les salaires, les départements et les projets sur lesquels ils travaillent. Comment organiseriez-vous cette base de données pour faciliter les rapports et les analyses ? 


**Mise en situation 3** : Analyse des Données de Vente pour un Magasin en Ligne 
Vous devez créer des tableaux de bord pour suivre les ventes, les clients et les produits les plus populaires. Quels types de requêtes SQL ou NoSQL utiliseriez-vous pour générer ces rapports ? 

**Mise en situation 4** : Réseau Social avec Fonctionnalités Avancées 
Vous développez un réseau social avec des fonctionnalités avancées comme les groupes, les messages privés et les recommandations d'amis. Comment structureriez-vous cette base de données pour garantir des temps de réponse rapides ? 

**Mise en situation 5** : Système de Gestion des Réservations pour une Chaîne d'Hôtels 
Vous devez créer un système pour gérer les réservations, les paiements et les chambres pour une chaîne d'hôtels. Comment organiseriez-vous les tables et les relations pour garantir une gestion efficace des réservations ? 


# Questions de Révision 

Comment une transaction est-elle gérée en SQL et pourquoi est-ce important ?  
En cas de panne, les données sont toujours accessible

Quelle est la différence entre DELETE et TRUNCATE en SQL ?  
TRUNCATE --> vide toute la table sans la supprimer

Pourquoi utiliser une base NoSQL comme MongoDB au lieu de SQL pour certaines applications ?  

### Différence table de fait table de dimension  
Table de fait : possibilité de transformation (ajout de données, calcul, etc...)  
Table de dimension : données brutes

### Diagrame en étoile
Toutes les relations se dirigent vers une seule table de fait.  

### Diagrame en flocon
Plusieurs table de fait = diagrame en flocon