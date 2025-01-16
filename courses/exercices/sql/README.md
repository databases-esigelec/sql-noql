# Exercices SQL Avancé
Pour réaliser ces exercices, nous utiliserons: https://sqliteonline.com/

## Exercice 1 : Fondamentaux SQL


Nous avons une base de données Postgres gérant une bibliothèque. Les tables principales sont les auteurs et leurs livres.

### Schéma
- Auteurs(id_auteur, nom, prenom, date_naissance)
- Livres(id_livre, titre, id_auteur, annee_publication, genre)

### Questions
1. Listez tous les livres avec le nom et prénom de leurs auteurs
2. Trouvez tous les livres publiés avant 1900, triés par année de publication

<details>
<summary>Solutions</summary>

-- 1. Écrivez une requête SQL pour obtenir la liste de tous les livres avec le nom et prénom de leurs auteurs.

SELECT l.titre, a.nom, a.prenom
FROM livres l
JOIN auteurs a ON l.id_auteur = a.id_auteur;

-- 2. Écrivez une requête SQL pour trouver tous les livres publiés avant 1900, triés par année de publication.

SELECT titre, annee_publication
FROM livres
WHERE annee_publication < 1900
ORDER BY annee_publication;

</details>

## Exercice 2 : Requêtes avancées

### Base de données fournie
```sql
employes(id, nom, salaire, departement_id)
departements(id, nom, budget)
```

### Questions
1. Listez les employés dont le salaire est supérieur à la moyenne de leur département
2. Classez les départements par nombre d'employés gagnant plus de 50000
3. Pour chaque employé, affichez une classification ('Junior', 'Senior') basée sur le salaire

<details>
<summary>Solutions</summary>

```sql
-- 1. Salaire > moyenne département
SELECT e.nom, e.salaire
FROM employes e
WHERE e.salaire > (
    SELECT AVG(salaire)
    FROM employes
    WHERE departement_id = e.departement_id
);

-- 2. Classement départements
SELECT d.nom, COUNT(*) as nb_emp
FROM departements d
JOIN employes e ON d.id = e.departement_id
WHERE e.salaire > 50000
GROUP BY d.id, d.nom
ORDER BY nb_emp DESC;

-- 3. Classification
SELECT 
    nom,
    CASE 
        WHEN salaire > 45000 THEN 'Senior'
        ELSE 'Junior'
    END as niveau
FROM employes;
```
</details>

## Exercice 3 : Window Functions

### Tables disponibles
```sql
ventes(id, vendeur_id, montant, date_vente)
vendeurs(id, nom)
```

### Questions
1. Classez les vendeurs par leur chiffre d'affaires total
2. Calculez la moyenne mobile sur 3 jours des ventes
3. Pour chaque vente, montrez la différence avec la vente précédente du même vendeur

<details>
<summary>Solutions</summary>

```sql
-- 1. Classement vendeurs
SELECT 
    v.nom,
    SUM(s.montant) as ca_total,
    RANK() OVER (ORDER BY SUM(s.montant) DESC) as classement
FROM vendeurs v
JOIN ventes s ON v.id = s.vendeur_id
GROUP BY v.id, v.nom;

-- 2. Moyenne mobile
SELECT 
    date_vente,
    montant,
    AVG(montant) OVER (
        ORDER BY date_vente
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moyenne_mobile
FROM ventes;

-- 3. Différence avec vente précédente
SELECT 
    date_vente,
    vendeur_id,
    montant,
    montant - LAG(montant) OVER (
        PARTITION BY vendeur_id 
        ORDER BY date_vente
    ) as difference
FROM ventes;
```
</details>

## Exercice 4 : CTEs et Récursion

### Tables disponibles
```sql
employes(id, nom, manager_id)
categories(id, nom, parent_id)
```

### Questions
1. Affichez l'arbre hiérarchique des employés avec leur niveau
2. Trouvez tous les subordonnés d'un manager donné (id = 1)
3. Listez toutes les catégories et leurs sous-catégories

<details>
<summary>Solutions</summary>

```sql
-- 1. Hiérarchie employés
WITH RECURSIVE org_chart AS (
    SELECT id, nom, manager_id, 1 as niveau
    FROM employes
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT e.id, e.nom, e.manager_id, o.niveau + 1
    FROM employes e
    JOIN org_chart o ON e.manager_id = o.id
)
SELECT * FROM org_chart;

-- 2. Subordonnés
WITH RECURSIVE subord AS (
    SELECT id, nom
    FROM employes
    WHERE manager_id = 1  -- ID du manager

    UNION ALL
    
    SELECT e.id, e.nom
    FROM employes e
    JOIN subord s ON e.manager_id = s.id
)
SELECT * FROM subord;
```
</details>

## Exercice 5 : Optimisation

### Scénario
Base de données avec des millions de lignes :
```sql
utilisateurs(id, nom, email, ville)
commandes(id, user_id, montant, date)
```

### Questions
1. Créez les index appropriés
2. Optimisez la requête suivante :
```sql
SELECT *
FROM utilisateurs u
JOIN commandes c ON u.id = c.user_id
WHERE LOWER(u.ville) = 'paris'
AND c.date >= '2024-01-01';
```

<details>
<summary>Solutions</summary>

```sql
-- 1. Index pertinents
CREATE INDEX idx_ville ON utilisateurs(LOWER(ville));
CREATE INDEX idx_commandes_date_user ON commandes(date, user_id);

-- 2. Requête optimisée
SELECT 
    u.id, u.nom, u.email,
    c.montant, c.date
FROM utilisateurs u
JOIN commandes c ON u.id = c.user_id
WHERE LOWER(u.ville) = 'paris'
    AND c.date >= '2024-01-01';
```

**Explications :**
- Index sur ville pour la recherche rapide
- Index composite sur commandes pour optimiser la jointure et le filtrage par date
- Sélection ciblée des colonnes nécessaires uniquement
</details>

## Exercice 6 : SQLAlchemy

### Modèles fournis
```python
class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    orders = relationship("Order")

class Order(Base):
    __tablename__ = 'orders'
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    amount = Column(Integer)
```

### Questions
1. Créez un nouvel utilisateur avec une commande
2. Trouvez les utilisateurs avec leurs commandes
3. Calculez le total des commandes par utilisateur

<details>
<summary>Solutions</summary>

```python
# 1. Création
new_user = User(name="Alice")
new_order = Order(amount=100)
new_user.orders.append(new_order)
session.add(new_user)
session.commit()

# 2. Lecture avec jointure
users = session.query(User)\
    .options(joinedload(User.orders))\
    .all()

# 3. Total des commandes
from sqlalchemy import func
totals = session.query(
    User.name,
    func.sum(Order.amount)
)\
.join(Order)\
.group_by(User.id, User.name)\
.all()
```
</details>
