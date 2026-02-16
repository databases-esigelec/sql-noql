# TD SQL Avancé

**Outil recommandé :** [DB Fiddle (PostgreSQL)](https://www.db-fiddle.com/) ou tout autre outil PostgreSQL en ligne.

---

## Base de données commune (Exercices 2 à 5)

Les exercices 2 à 5 partagent la même base de données. Exécutez ce script une seule fois avant de commencer.
<details>
<summary>Données</summary>
    
```sql
CREATE TABLE departements (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    budget DECIMAL(12,2)
);

CREATE TABLE employes (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    salaire DECIMAL(10,2),
    departement_id INTEGER REFERENCES departements(id),
    manager_id INTEGER REFERENCES employes(id)
);

CREATE TABLE ventes (
    id SERIAL PRIMARY KEY,
    employe_id INTEGER REFERENCES employes(id),
    montant DECIMAL(10,2),
    date_vente DATE
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    parent_id INTEGER REFERENCES categories(id)
);

-- Départements
INSERT INTO departements (nom, budget) VALUES
    ('R&D', 1000000.00),
    ('Marketing', 800000.00),
    ('Ventes', 900000.00),
    ('RH', 400000.00);

-- Employés (avec hiérarchie)
INSERT INTO employes (id, nom, salaire, departement_id, manager_id) VALUES
    (1,  'Alice Martin',    75000.00, 1, NULL),  -- PDG
    (2,  'Bob Dupont',      65000.00, 1, 1),     -- Directeur R&D
    (3,  'Claire Durant',   63000.00, 2, 1),     -- Directrice Marketing
    (4,  'David Bernard',   58000.00, 3, 1),     -- Directeur Ventes
    (5,  'Emma Petit',      48000.00, 1, 2),     -- R&D
    (6,  'François Leroy',  52000.00, 2, 3),     -- Marketing
    (7,  'Gabriel Moreau',  55000.00, 3, 4),     -- Ventes
    (8,  'Hélène Dubois',   42000.00, 3, 4),     -- Ventes
    (9,  'Ivan Rousseau',   47000.00, 4, 1),     -- RH
    (10, 'Julie Lambert',   38000.00, 4, 9),     -- RH
    (11, 'Kevin Martin',    44000.00, 1, 2),     -- R&D
    (12, 'Laura Simon',     41000.00, 2, 3);     -- Marketing

-- Ventes (sur plusieurs jours, liées aux employés du département Ventes)
INSERT INTO ventes (employe_id, montant, date_vente) VALUES
    (4, 1500.00, '2024-01-15'), (7, 2300.00, '2024-01-15'), (8, 1800.00, '2024-01-15'),
    (4, 2100.00, '2024-01-16'), (7, 1900.00, '2024-01-16'), (8, 2500.00, '2024-01-16'),
    (4, 2800.00, '2024-01-17'), (7, 2200.00, '2024-01-17'), (8, 1950.00, '2024-01-17'),
    (4, 1600.00, '2024-01-18'), (7, 2700.00, '2024-01-18'), (8, 2100.00, '2024-01-18'),
    (4, 3100.00, '2024-01-19'), (7, 1800.00, '2024-01-19'), (8, 2400.00, '2024-01-19');

-- Catégories (arborescence produits)
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

---

## Exercice 1 : Fondamentaux SQL

### Schéma
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

### Questions

1. Listez tous les livres avec le nom et prénom de leurs auteurs.
2. Trouvez tous les livres publiés avant 1900, triés par année de publication.

<details>
<summary>Solutions</summary>

```sql
-- 1. Livres avec auteurs
SELECT l.titre, a.nom, a.prenom
FROM livres l
JOIN auteurs a ON l.id_auteur = a.id_auteur;

-- 2. Livres publiés avant 1900
SELECT titre, annee_publication
FROM livres
WHERE annee_publication < 1900
ORDER BY annee_publication;
```
</details>

---

## Exercice 2 : Requêtes avancées

> Utilise la base de données commune.

### Questions

1. Listez les employés dont le salaire est supérieur à la moyenne de leur département.
2. Classez les départements par nombre d'employés gagnant plus de 50 000.
3. Pour chaque employé, affichez une classification : **Senior** si salaire > 50 000, **Junior** sinon.

<details>
<summary>Solutions</summary>

```sql
-- 1. Salaire > moyenne du département
SELECT 
    e.nom AS employe,
    e.salaire,
    d.nom AS departement,
    ROUND(moy.avg_sal, 2) AS moyenne_departement
FROM employes e
JOIN departements d ON e.departement_id = d.id
JOIN (
    SELECT departement_id, AVG(salaire) AS avg_sal
    FROM employes
    GROUP BY departement_id
) moy ON e.departement_id = moy.departement_id
WHERE e.salaire > moy.avg_sal
ORDER BY d.nom, e.salaire DESC;

-- 2. Départements classés par nb d'employés > 50 000
SELECT d.nom, COUNT(*) AS nb_emp
FROM departements d
JOIN employes e ON d.id = e.departement_id
WHERE e.salaire > 50000
GROUP BY d.id, d.nom
ORDER BY nb_emp DESC;

-- 3. Classification Junior / Senior (seuil : 50 000)
SELECT 
    nom,
    salaire,
    CASE 
        WHEN salaire > 50000 THEN 'Senior'
        ELSE 'Junior'
    END AS niveau
FROM employes;
```
</details>

---

## Exercice 3 : Window Functions

> Utilise la base de données commune (tables `ventes` et `employes`).

### Questions

1. Classez les employés par leur chiffre d'affaires total (RANK).
2. Calculez la moyenne mobile sur 3 jours des ventes.
3. Pour chaque vente, montrez la différence avec la vente précédente du même employé.

<details>
<summary>Solutions</summary>

```sql
-- 1. Classement par CA total
SELECT 
    e.nom,
    SUM(v.montant) AS ca_total,
    RANK() OVER (ORDER BY SUM(v.montant) DESC) AS classement
FROM employes e
JOIN ventes v ON e.id = v.employe_id
GROUP BY e.id, e.nom;

-- 2. Moyenne mobile sur 3 jours
SELECT 
    date_vente,
    montant,
    ROUND(AVG(montant) OVER (
        ORDER BY date_vente
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ), 2) AS moyenne_mobile
FROM ventes;

-- 3. Différence avec la vente précédente du même employé
SELECT 
    e.nom,
    v.date_vente,
    v.montant,
    v.montant - LAG(v.montant) OVER (
        PARTITION BY v.employe_id 
        ORDER BY v.date_vente
    ) AS difference
FROM ventes v
JOIN employes e ON v.employe_id = e.id;
```
</details>

---

## Exercice 4 : CTEs et Récursion

> Utilise la base de données commune (tables `employes` et `categories`).

### Questions

1. Affichez l'arbre hiérarchique des employés avec leur niveau dans l'organisation.
2. Trouvez tous les subordonnés (directs et indirects) du manager `id = 1`.
3. Listez toutes les catégories avec leur chemin complet depuis la racine.

<details>
<summary>Solutions</summary>

```sql
-- 1. Hiérarchie complète des employés
WITH RECURSIVE org AS (
    SELECT id, nom, manager_id, 1 AS niveau
    FROM employes
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.id, e.nom, e.manager_id, o.niveau + 1
    FROM employes e
    JOIN org o ON e.manager_id = o.id
)
SELECT * FROM org ORDER BY niveau, nom;

-- 2. Tous les subordonnés du manager id = 1
WITH RECURSIVE subord AS (
    SELECT id, nom
    FROM employes
    WHERE manager_id = 1

    UNION ALL

    SELECT e.id, e.nom
    FROM employes e
    JOIN subord s ON e.manager_id = s.id
)
SELECT * FROM subord;

-- 3. Catégories avec chemin complet
WITH RECURSIVE arbre AS (
    SELECT id, nom, parent_id, nom::TEXT AS chemin, 1 AS niveau
    FROM categories
    WHERE parent_id IS NULL

    UNION ALL

    SELECT c.id, c.nom, c.parent_id,
           a.chemin || ' > ' || c.nom,
           a.niveau + 1
    FROM categories c
    JOIN arbre a ON c.parent_id = a.id
)
SELECT nom, chemin, niveau FROM arbre ORDER BY chemin;
```
</details>

---

## Exercice 5 : Optimisation

> Utilise la base de données commune.

### Contexte

Imaginez que les tables `employes` et `ventes` contiennent des millions de lignes. On souhaite optimiser cette requête :

```sql
SELECT *
FROM employes e
JOIN ventes v ON e.id = v.employe_id
WHERE LOWER(e.nom) = 'david bernard'
AND v.date_vente >= '2024-01-01';
```

### Questions

1. Créez les index appropriés pour accélérer cette requête.
2. Réécrivez la requête de manière optimisée et expliquez chaque amélioration.
3. Comment vérifieriez-vous que vos optimisations sont efficaces ?

<details>
<summary>Solutions</summary>

```sql
-- 1. Index appropriés

-- Index fonctionnel pour éviter le scan complet sur LOWER(nom)
CREATE INDEX idx_employes_nom_lower ON employes (LOWER(nom));

-- Index composite sur ventes : date + employe_id couvre le WHERE et le JOIN
CREATE INDEX idx_ventes_date_employe ON ventes (date_vente, employe_id);

-- 2. Requête optimisée
SELECT 
    e.id, e.nom, e.salaire,
    v.montant, v.date_vente
FROM employes e
JOIN ventes v ON e.id = v.employe_id
WHERE LOWER(e.nom) = 'david bernard'
  AND v.date_vente >= '2024-01-01';
```

**Améliorations apportées :**

- **`SELECT *` → colonnes explicites** : évite de charger des données inutiles, réduit les I/O et permet au moteur d'utiliser des index couvrants.
- **Index fonctionnel sur `LOWER(nom)`** : sans cet index, PostgreSQL doit appliquer `LOWER()` à chaque ligne. L'index permet un accès direct.
- **Index composite `(date_vente, employe_id)`** : filtre d'abord par date (clause WHERE), puis facilite la jointure sur `employe_id` sans accès supplémentaire à la table.

```sql
-- 3. Vérification avec EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT 
    e.id, e.nom, e.salaire,
    v.montant, v.date_vente
FROM employes e
JOIN ventes v ON e.id = v.employe_id
WHERE LOWER(e.nom) = 'david bernard'
  AND v.date_vente >= '2024-01-01';
```

`EXPLAIN ANALYZE` exécute réellement la requête et affiche le plan choisi par le moteur (type de scan, usage des index, temps d'exécution). On vérifie que les **Index Scan** remplacent les **Seq Scan**.

</details>

---

## Exercice 6 : SQLAlchemy

### Setup

```python
from sqlalchemy import create_engine, Column, Integer, String, ForeignKey, func
from sqlalchemy.orm import declarative_base, relationship, sessionmaker, joinedload

engine = create_engine('sqlite:///test.db')
Base = declarative_base()
Session = sessionmaker(bind=engine)

class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    name = Column(String)
    orders = relationship("Order", back_populates="user")

class Order(Base):
    __tablename__ = 'orders'
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    amount = Column(Integer)
    user = relationship("User", back_populates="orders")

Base.metadata.create_all(engine)
session = Session()
```

### Questions

1. Créez un nouvel utilisateur avec une commande associée.
2. Récupérez tous les utilisateurs avec leurs commandes (en une seule requête).
3. Calculez le total des commandes par utilisateur.

<details>
<summary>Solutions</summary>

```python
# 1. Création d'un utilisateur avec une commande
new_user = User(name="Alice")
new_user.orders.append(Order(amount=100))
session.add(new_user)
session.commit()

# 2. Lecture avec jointure (eager loading)
users = session.query(User)\
    .options(joinedload(User.orders))\
    .all()

for u in users:
    print(f"{u.name}: {[o.amount for o in u.orders]}")

# 3. Total des commandes par utilisateur
totals = session.query(
    User.name,
    func.sum(Order.amount).label("total")
)\
.join(Order)\
.group_by(User.id, User.name)\
.all()

for name, total in totals:
    print(f"{name}: {total}")
```
</details>
