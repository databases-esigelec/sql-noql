# Exercices SQL

Pour réaliser ces exercices, nous utiliserons: https://sqliteonline.com/

## 1. Fondamentaux SQL


Nous avons une base de données Postgres gérant une bibliothèque. Les tables principales sont les auteurs et leurs livres.

## Schéma
- Auteurs(id_auteur, nom, prenom, date_naissance)
- Livres(id_livre, titre, id_auteur, annee_publication, genre)

Les données d'exemple sont fournies dans le fichier `1_fondamentaux.sql`

## Questions
1. Listez tous les livres avec le nom et prénom de leurs auteurs
2. Trouvez tous les livres publiés avant 1900, triés par année de publication

## Pour aller plus loin
1. Comptez le nombre de livres par auteur
2. Trouvez l'auteur ayant écrit le plus de livres
3. Calculez l'âge moyen des auteurs à la publication de leurs livres

## Solutions
Disponibles dans le fichier `1_solutions.sql`

# 2. Optimisation de Requêtes

Nous avons une base de données Postgres contenant des informations sur les employés d'une entreprise. L'objectif est d'optimiser une requête existante qui liste les employés des départements ayant plus de 2 personnes.

## Schéma
- Employes(id, nom, departement, salaire)

Les données d'exemple sont fournies dans le fichier `2_optimisation.sql`

## Contexte
La requête actuelle utilise une sous-requête IN qui peut être optimisée pour de meilleures performances :
```sql
SELECT * FROM employes 
WHERE departement IN (SELECT departement FROM employes GROUP BY departement HAVING COUNT(*) > 2);
```

## Questions
1. Identifiez les goulots d'étranglement potentiels dans cette requête
2. Proposez une version optimisée en utilisant une CTE et un JOIN
3. Expliquez pourquoi votre version est plus performante

## Pour aller plus loin
1. Ajoutez un index approprié pour améliorer les performances
2. Mesurez le temps d'exécution des deux versions avec EXPLAIN ANALYZE
3. Proposez d'autres optimisations possibles

## Solutions
Disponibles dans le fichier `2_solutions.sql`

# 3. Optimisation avec CTE

Nous avons une base de données de e-commerce avec des clients et leurs commandes. La requête actuelle utilise plusieurs sous-requêtes corrélées pour calculer des statistiques, ce qui n'est pas optimal.

## Schéma
- Clients(id, nom)
- Commandes(id, client_id, montant)

Les données d'exemple sont fournies dans le fichier `3_ctes.sql`

## Requête à optimiser
```sql
SELECT 
    c.nom,
    (SELECT COUNT(*) FROM commandes WHERE client_id = c.id) as nb_commandes,
    (SELECT SUM(montant) FROM commandes WHERE client_id = c.id) as total,
    (SELECT AVG(montant) FROM commandes WHERE client_id = c.id) as panier_moyen
FROM clients c
WHERE (SELECT SUM(montant) FROM commandes WHERE client_id = c.id) > 300;
```

## Questions
1. Identifiez les problèmes de performance dans cette requête
2. Réécrivez la requête en utilisant une CTE pour éviter les sous-requêtes répétées
3. Expliquez les avantages de votre optimisation

## Pour aller plus loin
1. Ajoutez d'autres métriques pertinentes (min, max, etc.)
2. Optimisez davantage avec des index appropriés
3. Comparez les plans d'exécution des deux versions

## Solutions
Disponibles dans le fichier `3_solutions.sql`

# 4. Windows Functions

Nous avons une table de ventes contenant des transactions quotidiennes par vendeur. L'objectif est d'utiliser les fonctions de fenêtrage (Windows Functions) pour analyser ces données.

## Schéma
- Ventes(id_vente, date_vente, vendeur_id, nom_vendeur, montant, departement)

Les données d'exemple sont fournies dans le fichier `4_windows_functions.sql`

## Questions
1. Pour chaque vente, calculez :
   - Le total des ventes par vendeur
   - Le classement des vendeurs
   - La moyenne mobile sur 3 jours par vendeur

2. Pour chaque vente, affichez :
   - Le pourcentage par rapport au total du département
   - La différence avec la vente précédente du même vendeur

## Pour aller plus loin
1. Calculez le rang des vendeurs basé sur leurs ventes totales
2. Affichez pour chaque vente le montant de la vente précédente
3. Créez une fenêtre mobile personnalisée (7 jours, mois, etc.)

## Solutions
Disponibles dans le fichier `4_solutions.sql`