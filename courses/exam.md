# Devoir d'entraînement : Bases de données SQL & NoSQL
Examen blanc. L'examen réel durera 2 heures. 
Cet examen n'est pas représentatif en termes de durée de l'examen réel. 
Il permet juste d'avoir une idée du type de questions probables.


## Partie 1 : SQL (10 points)

### QCM : 2 points
Consignes : Chaque question vaut 0.5 point. Il n'y a pas de points négatifs.

1. Une transaction ACID garantit :
   a) L'atomicité uniquement
   b) La durabilité et la cohérence
   c) Les quatre propriétés : Atomicité, Cohérence, Isolation, Durabilité
   d) L'isolation et l'atomicité uniquement

2. La clause HAVING :
   a) S'utilise avant GROUP BY
   b) Filtre les résultats après agrégation
   c) Remplace la clause WHERE
   d) Ne peut pas être utilisée avec COUNT


### Questions de cours (4 points)

1. Expliquez le concept de normalisation des bases de données. Détaillez les trois premières formes normales (1NF, 2NF, 3NF). (1 point)

2. Qu'est-ce qu'un index ? Quels sont les avantages et inconvénients de leur utilisation ? (1 point)

### Exercices pratiques (4 points)

1. Créez une table Commandes avec les colonnes : id, date_commande, client_id, montant_total, statut. Le statut ne peut prendre que les valeurs 'En attente', 'En cours', 'Livrée', 'Annulée'.
> Ecrivez la requête de CREATE TABLE.

2. Considérons les tables suivantes :
```sql
produits(id, nom, prix, stock, categorie_id)
categories(id, nom, description)
```
Soit la requête:
```sql
SELECT c.nom, p.prix * stock as somme_valeur_categorie
FROM produits p
LEFT JOIN categories as C
ON c.id = p.categorie_id
WHERE p.categorie_id IN (SELECT id FROM categories)
GROUP BY c.nom
```
a) Expliquez cette requête. 

b) Trouvez l'erreur dans cette requête, puis résolvez la. 

c) Y-a-t il un moyen d'optimiser cette requête? Si oui, comment?


## Partie 2 : NoSQL (10 points)

### QCM : 2 points
Consignes : Chaque question vaut 0.5 point. Il n'y a pas de points négatifs.

1. Dans une base de données orientée graphe, que représente un nœud ?
   a) Une relation uniquement
   b) Une propriété
   c) Une entité
   d) Un index

2. Quelle caractéristique n'est PAS typique des bases NoSQL ?
   a) Schéma flexible
   b) Scalabilité horizontale
   c) Support ACID strict
   d) Gestion de données non structurées

### Questions de cours (4 points)

1. Quelles sont les différences fondamentales entre le modèle de cohérence des bases SQL et NoSQL ? Expliquez le concept de "eventual consistency". (1 point)

2. Dans le cadre d'une base de données orientée graphe (comme Neo4j), expliquez la différence entre les relations et les propriétés. Donnez un exemple concret. (1 point)

### Exercices pratiques (4 points)

1. MongoDB : Considérons la collection suivante :
```json
{
    "article_id": "A123",
    "titre": "Introduction à MongoDB",
    "auteur": {
        "nom": "Dupont",
        "email": "dupont@email.com"
    },
    "tags": ["nosql", "database", "tutorial"],
    "commentaires": [
        {
            "user": "user1",
            "texte": "Très utile !",
            "date": "2024-01-15"
        }
    ]
}
```

a) Écrivez une requête pour trouver tous les articles avec le tag "nosql"

b) Écrivez une requête pour ajouter un nouveau commentaire à un article spécifique

2. Neo4j : Écrivez une requête Cypher pour :
a) Créer un nœud Person avec les propriétés name et age
b) Créer une relation FOLLOWS entre deux personnes avec une propriété since

3. Modélisation : Vous devez concevoir une base de données pour un réseau social. Proposez une structure de données NoSQL adaptée (MongoDB ou Neo4j au choix) pour gérer :
- Les profils utilisateurs
- Les relations d'amitié
- Les posts/publications
- Les commentaires et likes

Justifiez vos choix de modélisation.

---

Ce devoir d'entraînement conserve la structure de l'original mais propose des questions différentes qui permettront aux étudiants de bien se préparer sans avoir les questions exactes de l'examen final. 
Il couvre les mêmes concepts mais sous des angles différents.
Pendant le devoir vous devrez compléter, expliquer ou corriger des requêtes mais pas en écrire comme ici.
