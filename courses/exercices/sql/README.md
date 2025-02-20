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
<summary>Données</summary>
    
```sql
CREATE TABLE auteurs (
    id_auteur INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    date_naissance DATE
);

CREATE TABLE livres (
    id_livre INT PRIMARY KEY,
    titre VARCHAR(100),
    id_auteur INT,
    annee_publication INT,
    genre VARCHAR(50),
    FOREIGN KEY (id_auteur) REFERENCES auteurs(id_auteur)
);

INSERT INTO auteurs (id_auteur, nom, prenom, date_naissance) VALUES
(1, 'Hugo', 'Victor', '1802-02-26'),
(2, 'Camus', 'Albert', '1913-11-07'),
(3, 'Rowling', 'J.K.', '1965-07-31');

INSERT INTO livres (id_livre, titre, id_auteur, annee_publication, genre) VALUES
(1, 'Les Misérables', 1, 1862, 'Roman'),
(2, 'L''Étranger', 2, 1942, 'Roman'),
(3, 'Harry Potter à l''école des sorciers', 3, 1997, 'Fantasy'),
(4, 'Notre-Dame de Paris', 1, 1831, 'Roman'),
(5, 'La Peste', 2, 1947, 'Roman');
```
</details>

<details>
<summary>Solutions</summary>
    
```sql
-- 1. Écrivez une requête SQL pour obtenir la liste de tous les livres avec le nom et prénom de leurs auteurs.

SELECT l.titre, a.nom, a.prenom
FROM livres l
JOIN auteurs a ON l.id_auteur = a.id_auteur;

-- 2. Écrivez une requête SQL pour trouver tous les livres publiés avant 1900, triés par année de publication.

SELECT titre, annee_publication
FROM livres
WHERE annee_publication < 1900
ORDER BY annee_publication;
```
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
<summary>Données</summary>

```sql
-- Création des tables
CREATE TABLE departements (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    budget DECIMAL(12,2)
);

CREATE TABLE employes (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    salaire DECIMAL(10,2),
    departement_id INTEGER REFERENCES departements(id)
);

-- Insertion des données pour les départements
INSERT INTO departements (nom, budget) VALUES
    ('R&D', 1000000.00),
    ('Marketing', 800000.00),
    ('Ventes', 900000.00),
    ('RH', 400000.00);

-- Insertion des données pour les employés
INSERT INTO employes (nom, salaire, departement_id) VALUES
    ('Alice Martin', 65000.00, 1),    -- R&D
    ('Bob Dupont', 45000.00, 1),      -- R&D
    ('Claire Durant', 72000.00, 1),   -- R&D
    ('David Bernard', 58000.00, 2),   -- Marketing
    ('Emma Petit', 48000.00, 2),      -- Marketing
    ('François Leroy', 52000.00, 2),  -- Marketing
    ('Gabriel Moreau', 63000.00, 3),  -- Ventes
    ('Hélène Dubois', 55000.00, 3),   -- Ventes
    ('Ivan Rousseau', 42000.00, 3),   -- Ventes
    ('Julie Lambert', 47000.00, 4),   -- RH
    ('Kevin Martin', 38000.00, 4),    -- RH
    ('Laura Simon', 44000.00, 4);     -- RH
```
</details>

<details>
<summary>Solutions</summary>

```sql
-- 1. Salaire > moyenne département
SELECT 
    e.nom as employe,
    e.salaire,
    d.nom as departement,
    ROUND(dept_avg.moyenne_salaire, 2) as moyenne_departement
FROM employes e
JOIN departements d ON e.departement_id = d.id
JOIN (
    SELECT 
        departement_id,
        AVG(salaire) as moyenne_salaire
    FROM employes
    GROUP BY departement_id
) dept_avg ON e.departement_id = dept_avg.departement_id
WHERE e.salaire > dept_avg.moyenne_salaire
ORDER BY d.nom, e.salaire DESC;

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
<summary>Données</summary>

```sql
-- Création des tables
CREATE TABLE vendeurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE ventes (
    id SERIAL PRIMARY KEY,
    vendeur_id INTEGER REFERENCES vendeurs(id),
    montant DECIMAL(10,2),
    date_vente DATE
);

-- Insertion des données de test pour les vendeurs
INSERT INTO vendeurs (nom) VALUES
    ('Marie Dupont'),
    ('Jean Martin'),
    ('Sophie Bernard'),
    ('Lucas Petit');

-- Insertion des données de test pour les ventes
INSERT INTO ventes (vendeur_id, montant, date_vente) VALUES
    (1, 1500.00, '2024-01-15'),
    (2, 2300.00, '2024-01-15'),
    (3, 1800.00, '2024-01-15'),
    (1, 2100.00, '2024-01-16'),
    (2, 1900.00, '2024-01-16'),
    (3, 2500.00, '2024-01-16'),
    (4, 1700.00, '2024-01-16'),
    (1, 2800.00, '2024-01-17'),
    (2, 2200.00, '2024-01-17'),
    (3, 1950.00, '2024-01-17'),
    (4, 2400.00, '2024-01-17'),
    (1, 1600.00, '2024-01-18'),
    (2, 2700.00, '2024-01-18'),
    (3, 2100.00, '2024-01-18'),
    (4, 1900.00, '2024-01-18');
```
</details>

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
<summary>Données</summary>

```sql
-- Création des tables
CREATE TABLE employes (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    manager_id INTEGER REFERENCES employes(id)
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    parent_id INTEGER REFERENCES categories(id)
);

-- Insertion des données pour les employés
INSERT INTO employes (id, nom, manager_id) VALUES
    (1, 'Alice Martin', NULL),                -- PDG
    (2, 'Bob Dupont', 1),                     -- Directeur sous Alice
    (3, 'Claire Durant', 1),                  -- Directrice sous Alice
    (4, 'David Bernard', 2),                  -- Manager sous Bob
    (5, 'Emma Petit', 2),                     -- Manager sous Bob
    (6, 'François Leroy', 3),                 -- Manager sous Claire
    (7, 'Gabriel Moreau', 4),                 -- Employé sous David
    (8, 'Hélène Dubois', 4),                 -- Employé sous David
    (9, 'Ivan Rousseau', 5),                 -- Employé sous Emma
    (10, 'Julie Lambert', 6);                -- Employé sous François

-- Insertion des données pour les catégories
INSERT INTO categories (id, nom, parent_id) VALUES
    (1, 'Électronique', NULL),
    (2, 'Ordinateurs', 1),
    (3, 'Smartphones', 1),
    (4, 'Laptops', 2),
    (5, 'Desktops', 2),
    (6, 'Android', 3),
    (7, 'iOS', 3),
    (8, 'Ultrabooks', 4),
    (9, 'Gaming', 4);

```
</details>

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
<summary>Données</summary>

```sql
-- Création des tables
CREATE TABLE utilisateurs (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    email VARCHAR(255),
    ville VARCHAR(100)
);

CREATE TABLE commandes (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES utilisateurs(id),
    montant DECIMAL(10,2),
    date DATE
);

-- Insertion de données de test pour les utilisateurs
INSERT INTO utilisateurs (nom, email, ville) VALUES
    ('Jean Dupont', 'jean.dupont@mail.com', 'Paris'),
    ('Marie Martin', 'marie.martin@mail.com', 'Lyon'),
    ('Pierre Durant', 'pierre.durant@mail.com', 'Paris'),
    ('Sophie Bernard', 'sophie.bernard@mail.com', 'Marseille'),
    ('Lucas Petit', 'lucas.petit@mail.com', 'Paris'),
    ('Emma Leroy', 'emma.leroy@mail.com', 'Lyon'),
    ('Thomas Roux', 'thomas.roux@mail.com', 'Paris'),
    ('Julie Moreau', 'julie.moreau@mail.com', 'Marseille'),
    ('Nicolas Girard', 'nicolas.girard@mail.com', 'Paris'),
    ('Clara Simon', 'clara.simon@mail.com', 'Lyon');

-- Insertion de données de test pour les commandes
INSERT INTO commandes (user_id, montant, date) VALUES
    (1, 150.00, '2024-01-05'),
    (1, 200.00, '2024-01-15'),
    (2, 75.50, '2023-12-28'),
    (3, 320.00, '2024-01-10'),
    (3, 180.00, '2024-01-20'),
    (4, 95.00, '2024-01-08'),
    (5, 250.00, '2024-01-12'),
    (6, 130.00, '2023-12-30'),
    (7, 420.00, '2024-01-18'),
    (8, 160.00, '2024-01-07'),
    (9, 290.00, '2024-01-14'),
    (10, 110.00, '2023-12-25');
```
</details>

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
