---
theme: dracula
background: https://source.unsplash.com/collection/94734566/1920x1080
class: text-center
highlighter: shiki
lineNumbers: false
drawings:
  persist: false
transition: slide-left
title: Bases de données SQL et NoSQL
---

# Bases de données SQL et NoSQL


---
layout: two-cols-header
---


# Qui suis-je? 

- 🧑🏾 **Nom**: Brice FOTZO
- 🌍 **Origine**: Bafoussam, Cameroun 
- 🎓 **Formation**: Ingénieur Généraliste(BDTN) - ESIGELEC Rouen

> Parcours Data & AI
- Analytics Engineer - **Apprenti** @ Renault
- Data Enigneer - CDI @ Starclay
- Tech Lead Data - CDI @ HephIA
- Tech Lead Data - CDI @ Servier
- Intervenant - CDD @ ESIGELEC Rouen/Poitiers

> Engagements Communautaires
- Data Engineer - **Volunteer** @ Validalab(DFG)
- MUG Leader Paris - **Volunteer** @ MongoDB
- Créateur de contenu @ LinkedIn, Medium
- Créateur de Serial Techos

---
layout: default
---

# Et vous?
## Faisons connaissance

---
layout: default
---

# Plan du module

**Cours Magistral** 
 
- **SQL Avancé** 
  - Fondamentaux
  - Requêtes avancées - CASE WHEN, Sous-requêtes
  - Analyse de données - Window Functions, Agrégations
  - CTEs et Récursion
  - Optimisation 
  - SQLAlchemy 

- **NoSQL** 
  - Introduction et concepts - Caractéristiques, choix, use cases
  - MongoDB - Pourquoi et comment, CRUD
  - Neo4j - Pourquoi et comment, CRUD

---
layout: two-cols-header
---

# Plan du module

::left::
**TD** 
  - Travaux dirigés SQL 
  - Travaux dirigés NoSQL 
  
**TP** 
  - Projet fil rouge - PostgreSQL/MongoDB/Neo4j

**Évaluations**
  - 1 Devoir surveillé 
  - TP notés et projet fil rouge 

::right::

**Ressources principales**

- Support de cours - Slides
- Exercices de cours - GitHub
- Challenges par équipes - Wooclap
---
layout: cover
background: https://source.unsplash.com/collection/94734566/1920x1080
---
# Projet fil rouge 
Simulateur de Carrière Tech

**Vue d'ensemble**
Un jeu de simulation où les joueurs :
- Font des choix de carrière dans la tech
- Reçoivent des opportunités par email
- Développent leur réseau professionnel
- Participent à des événements tech

**Mécaniques de jeu**
- **Points de départ** : Choix entre Emploi, Formation, Freelance ou Recherche
- **Gameplay par email** : Réponses aux opportunités, invitations, connexions
- **Évolution de carrière** : Progression basée sur les choix et l'expérience
- **Construction du réseau** : Connexions avec des NPCs, participation aux événements

---
layout: two-cols-header
background: https://source.unsplash.com/collection/94734566/1920x1080
---

## Infrastructure Technique

::left::
### Architecture Multi-Bases
1. **PostgreSQL**
   - Stockage des données principales
   - Entités et relations entre elles

2. **Neo4j**
   - Graphe du réseau social
   - Moteur de recommandation
   - Matching basé sur les intérêts

3. **MongoDB**
   - Boîtes mail des joueurs
   - Progression de carrière
   - Participation aux événements

::right::

### Entités Clés
- **Topics** : Domaines techniques (Web Dev, Data Science...)
- **Skills** : Compétences spécifiques (Python, AWS...)
- **Events** : Conférences, Meetups, Hackathons
- **Organizations** : Entreprises, Labos de recherche, Universités
- **Opportunities** : Emplois, Formations, Missions Freelance
- **System Persons** : NPCs avec rôles et backgrounds

---
layout: iframe  
url: https://my-path-rust.vercel.app
---


---
layout: two-cols-header
---

# Objectifs d'apprentissage

::left::

- **Compétences visées**: 
   - Maîtriser les différences entre SQL et NoSQL
   - Choisir les BDD adaptées à un besoin
   - Manipuler des BDD dans une app *Python*
   - Intégrer en continue du code BDD
   - *Déployer des bases de données*
   - *Déployer en continue des mises à jour de BDD*


::right::
- **Technologies et outils**:
   - BDD: `Postgres`, `MongoDB`, `Neo4j`
   - Virtualization: `Docker`
   - Code: `Python`, `Github Actions`
   - *Cloud: `GCP(Compute engine, Network)`*
   - *IaC: `Terraform`, `Ansible`*



---
layout: cover
# background: './images/sql-background.jpg'
---

# SQL - Fondamentaux
## Rappel des fondamentaux

---
layout: default
---

# Le modèle relationnel

- **Structure de base**
  - Tables (relations)
  - Colonnes (attributs)
  - Lignes (tuples)

- **Caractéristiques**
  - Données structurées
  - Schema prédéfini
  - Relations entre tables
  - ACID (Atomicité, Cohérence, Isolation, Durabilité)



---
layout: two-cols-header
---

# Schémas et tables 

::right::

```sql
CREATE TABLE Clients (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    email VARCHAR(100),
    date_inscription DATE
);

CREATE TABLE Commandes (
    id INT PRIMARY KEY,
    client_id INT,
    date_commande DATE,
    montant DECIMAL(10,2),
    FOREIGN KEY (client_id) 
    REFERENCES Clients(id)
);
```

::left::
- **Structure rigide**
  - Types de données définis
  - Contraintes d'intégrité
  - Relations explicites

- **Avantages**
  - Données cohérentes
  - Intégrité référentielle
  - Requêtes complexes


---
layout: iframe

# la source de la page Web
url: https://app.wooclap.com/IERLNE/questionnaires/678e060592af6046a9581f39
---

---
layout: two-cols-header
---

# Normalisation

::left::

### Pourquoi normaliser ?
- Éviter la redondance
- Maintenir l'intégrité
- Faciliter la maintenance

<br>
<br>
<br>

### Les formes normales principales
1. **1NF**: Valeurs atomiques
2. **2NF**: Dépendances fonctionnelles
3. **3NF**: Pas de dépendances transitives

::right::

<div class="mb-4">

### Bénéfices
- Moins de redondance
- Mise à jour simplifiée
- Meilleure intégrité

<br>
<br>
<br>


### Compromis
- Jointures nécessaires
- Requêtes plus complexes
</div>

---
layout: iframe

# la source de la page Web
url: https://app.wooclap.com/IERLNE/questionnaires/67884081762064bf4606a9cf
---

---
layout: two-cols-header
---

# Contraintes d'intégrité

::left::

### Types de contraintes

- **PRIMARY KEY**
  - Identifiant unique
  - Non null
  - Une seule par table

- **FOREIGN KEY**
  - Référence une PRIMARY KEY
  - Assure la cohérence référentielle

- **UNIQUE**
  - Valeurs uniques
  - Peut être null
  - Plusieurs par table



::right::

### Autres contraintes

- **NOT NULL**
  - Valeur obligatoire

- **CHECK**
  - Validation personnalisée
  ```sql
  CHECK (age >= 18)
  ```

- **DEFAULT**
  - Valeur par défaut
  ```sql
  DEFAULT CURRENT_TIMESTAMP
  ```



---
layout: two-cols-header
---

# Types de relations

::left::
- **One-to-One(1:1)**
- One-to-Many(1:N)
- Many-to-Many(N:M)


::right::

<!-- **One-to-One (1:1)** -->
```sql {}{class:'!children:text-xs'}
CREATE TABLE Utilisateur (
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE Profil (
    id INT PRIMARY KEY,
    utilisateur_id INT UNIQUE,
    bio TEXT,
    FOREIGN KEY (utilisateur_id) 
    REFERENCES Utilisateur(id)
);
```

---
layout: two-cols-header
---

# Types de relations
::left::
- One-to-One(1:1)
- **One-to-Many(1:N)**
- Many-to-Many(N:M)

::right::

```sql
CREATE TABLE Auteur (
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE Livre (
    id INT PRIMARY KEY,
    titre VARCHAR(100),
    auteur_id INT,
    FOREIGN KEY (auteur_id) 
    REFERENCES Auteur(id)
);
```

---
layout: two-cols-header
---

# Types de relations
::left::
- One-to-One(1:1)
- One-to-Many(1:N)
- **Many-to-Many(N:M)**

::right::

```sql
CREATE TABLE Etudiant (
    id INT PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE Cours (
    id INT PRIMARY KEY,
    titre VARCHAR(100)
);

CREATE TABLE Inscription (
    etudiant_id INT,
    cours_id INT,
    date_inscription DATE,
    PRIMARY KEY (etudiant_id, cours_id),
    FOREIGN KEY (etudiant_id) REFERENCES Etudiant(id),
    FOREIGN KEY (cours_id) REFERENCES Cours(id)
);
```
---
layout: two-cols-header
---

# **Exemple:** Normalisation

::left::

<div class="mb-4 mr-2">

### Table non normalisée
Données de commandes dans une seule table
```sql
Commandes(
    id,
    client_nom,
    client_email,
    produit,
    montant
)
```


</div>

::right::

<v-click>
<div class="mb-4 mr-2">

### Tables normalisées (3NF)
Décomposition en 3 tables atomiques
```sql
Clients(id_client, nom, email)
Produits(id_produit, nom, prix)
Commandes(id_commande, id_client, date)
```
</div>


<div class="mb-6">

### Table de liaison
Création d'un table de liaison
```sql
Produits_Commande(
    id_commande,
    id_produit,
    quantite
)

Commandes <---> Details_Commande <---> Produits
(1,n)          (table de liaison)     (1,n)

```
</div>

</v-click>

---
layout: cover
background: https://source.unsplash.com/collection/94734566/1920x1080
---

# SQL - Requêtes avancées

## Requêtes avancées (du simple au complexe)

---
layout: two-cols-header
---

# CASE WHEN et expressions conditionnelles

::left::

### Utilisation de CASE WHEN
- Expression conditionnelle
- Multiple conditions
- Résultats dynamiques

::right::

```sql
SELECT 
    nom,
    salaire,
    CASE 
        WHEN salaire < 30000 THEN 'Junior'
        WHEN salaire < 50000 THEN 'Confirmé'
        ELSE 'Senior'
    END as niveau
FROM employes;
```

---
layout: two-cols-header
---

# Sous-requêtes

::left::

### Types de sous-requêtes
- Non corrélées (indépendantes)
- Corrélées (dépendantes)
- Dans SELECT, FROM, WHERE

::right::

```sql
-- Sous-requête non corrélée
SELECT nom 
FROM employes
WHERE departement_id IN (
    SELECT id 
    FROM departements 
    WHERE budget > 100000
);

-- Sous-requête corrélée
SELECT nom 
FROM employes e
WHERE salaire > (
    SELECT AVG(salaire)
    FROM employes
    WHERE departement_id = e.departement_id
);
```

---
layout: two-cols-header
---

# Opérateurs de sous-requêtes

::left::

### Principaux opérateurs
- EXISTS / NOT EXISTS
- IN / NOT IN
- ANY / ALL
- SOME

::right::

```sql
-- EXISTS
SELECT nom 
FROM departements d
WHERE EXISTS (
    SELECT 1 
    FROM employes
    WHERE departement_id = d.id 
    AND salaire > 50000
);

-- ANY/ALL
SELECT nom 
FROM employes
WHERE salaire > ALL (
    SELECT AVG(salaire)
    FROM employes
    GROUP BY departement_id
);
```


---
layout: cover
---

# SQL - Analyse de données
## Techniques d'analyse de données

---
layout: two-cols-header
---

# Introduction aux Window Functions

::left::

### Qu'est-ce qu'une fonction de fenêtrage ?
- Calculs sur un ensemble de lignes
- Pas de regroupement des résultats
- Garde le détail des lignes
- Permet l'analyse par "fenêtre"

### Syntaxe de base
```sql
SELECT colonne,
    fonction_window() OVER (
        PARTITION BY colonne1 
        ORDER BY colonne2
    )
FROM table;
```

::right::

<div class='ml-6'>

### Exemple simple
```sql
SELECT 
    nom,
    departement,
    salaire,
    AVG(salaire) OVER (
        PARTITION BY departement
    ) as moyenne_dept
FROM employes;
```
</div>

---
layout: two-cols-header
---

# PARTITION BY et ORDER BY

::left::

### PARTITION BY
- Divise les données en partitions
- Similaire à GROUP BY
- Garde toutes les lignes
- Calculs par partition

### ORDER BY
- Ordonne les lignes dans la partition
- Influence les fonctions
- Définit le "cadre" de calcul

::right::

```sql
SELECT 
    nom,
    departement,
    date_embauche,
    salaire,
    SUM(salaire) OVER (
        PARTITION BY departement
        ORDER BY date_embauche
        ROWS BETWEEN UNBOUNDED PRECEDING 
            AND CURRENT ROW
    ) as cumul_salaires
FROM employes;
```

---
layout: two-cols-header
---

# Fonctions de classement

::left::

### Types de classement
- **ROW_NUMBER()**
  * Numéro unique 
  * Pas de doublons

- **RANK()**
  * Même rang si égalité
  * Sauts dans la séquence

- **DENSE_RANK()**
  * Même rang si égalité
  * Pas de sauts

::right::

```sql
SELECT 
    nom,
    salaire,
    ROW_NUMBER() OVER (
        ORDER BY salaire DESC
    ) as num,
    RANK() OVER (
        ORDER BY salaire DESC
    ) as rang,
    DENSE_RANK() OVER (
        ORDER BY salaire DESC
    ) as rang_dense
FROM employes;
```

---
layout: two-cols-header
---

# Fonctions d'agrégation avec OVER

::left::

### Fonctions disponibles
- SUM()
- AVG()
- COUNT()
- MIN()
- MAX()

### Utilisation
- Par partition
- Cumul
- Moyenne mobile

::right::

```sql
SELECT 
    date_vente,
    montant,
    SUM(montant) OVER (
        ORDER BY date_vente
        ROWS BETWEEN 3 PRECEDING 
            AND CURRENT ROW
    ) as moyenne_mobile_4j,
    COUNT(*) OVER (
        PARTITION BY EXTRACT(MONTH FROM date_vente)
    ) as ventes_du_mois
FROM ventes;
```

---
layout: two-cols-header
---

# Fonctions LAG, LEAD, FIRST_VALUE, LAST_VALUE

::left::

### Navigation entre lignes
- LAG(): valeur précédente
- LEAD(): valeur suivante
- FIRST_VALUE(): première valeur
- LAST_VALUE(): dernière valeur

### Applications
- Comparaison avec période précédente
- Analyse de tendances
- Calcul de variations

::right::

```sql
SELECT 
    date_vente,
    montant,
    LAG(montant) OVER (
        ORDER BY date_vente
    ) as montant_precedent,
    LEAD(montant) OVER (
        ORDER BY date_vente
    ) as montant_suivant,
    montant - LAG(montant) OVER (
        ORDER BY date_vente
    ) as variation
FROM ventes;
```


---
layout: iframe

# la source de la page Web
url: https://app.wooclap.com/IERLNE/questionnaires/6788436dff0260760abcffc1
---
---
layout: cover
---

# SQL - CTEs et Récursion
## Requêtes hiérarchiques et CTEs

---
layout: two-cols-header
---

# Common Table Expressions (CTE)

::left::

### Qu'est-ce qu'une CTE ?
- Table temporaire nommée
- Valable pour une seule requête
- Améliore la lisibilité
- Permet la récursivité

### Avantages
- Code plus modulaire
- Réutilisation dans la même requête
- Alternative aux sous-requêtes
- Plus facile à maintenir

::right::

```sql
WITH ventes_dept AS (
    SELECT 
        departement,
        SUM(montant) as total_ventes,
        COUNT(*) as nb_ventes
    FROM ventes
    GROUP BY departement
),
stats_dept AS (
    SELECT 
        departement,
        total_ventes / nb_ventes as panier_moyen
    FROM ventes_dept
)
SELECT * FROM stats_dept
WHERE panier_moyen > 1000;
```

---
layout: two-cols-header
---

# CTEs vs Sous-requêtes

::left::

### Sous-requêtes
```sql
SELECT 
    nom,
    (SELECT COUNT(*) 
     FROM commandes 
     WHERE client_id = c.id) as nb_commandes,
    (SELECT SUM(montant) 
     FROM commandes 
     WHERE client_id = c.id) as total
FROM clients c;
```

::right::

<div class="ml-4">

### Avec CTE
```sql
WITH stats_clients AS (
    SELECT 
        client_id,
        COUNT(*) as nb_commandes,
        SUM(montant) as total
    FROM commandes
    GROUP BY client_id
)
SELECT 
    c.nom,
    s.nb_commandes,
    s.total
FROM clients c
JOIN stats_clients s 
    ON c.id = s.client_id;
```
</div>
---
layout: two-cols-header
---

# Requêtes récursives

::left::

### Fonctionnement
1. Requête d'ancrage (non récursive)
2. Partie récursive
3. UNION ALL entre les deux
4. Condition d'arrêt

### Applications
- Structures hiérarchiques
- Organigrammes
- Catégories/sous-catégories
- Graphes de relations

::right::

```sql
WITH RECURSIVE employes_hierarchie AS (
    -- Ancrage : managers principaux
    SELECT 
        id, nom, manager_id, 1 as niveau
    FROM employes
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Partie récursive
    SELECT 
        e.id, 
        e.nom, 
        e.manager_id, 
        h.niveau + 1
    FROM employes e
    JOIN employes_hierarchie h 
        ON e.manager_id = h.id
)
SELECT * FROM employes_hierarchie
ORDER BY niveau, nom;
```

---
layout: two-cols-header
---

# Cas d'utilisation des CTEs récursives

::left::

### Navigation dans un arbre
- Trouver tous les subordonnés
- Trouver tous les supérieurs
- Calculer la profondeur

### Calculs itératifs
- Suites numériques
- Chemins dans un graphe
- Décomposition de valeurs

::right::

```sql
-- Trouver tous les subordonnés
WITH RECURSIVE subordonnees AS (
    SELECT id, nom
    FROM employes
    WHERE manager_id = 1  -- ID du manager

    UNION ALL
    
    SELECT e.id, e.nom
    FROM employes e
    JOIN subordonnees s 
        ON e.manager_id = s.id
)
SELECT * FROM subordonnees;
```
---
layout: iframe
url: https://app.wooclap.com/IERLNE/questionnaires/678ecfee958d7b2255f4daa5
---

---
layout: cover
---

# SQL - Optimisation
## Performance et optimisation

---
layout: two-cols-header
---

# Pourquoi et quand indexer ?

::left::

### Objectifs de l'indexation
- Accélérer les recherches
- Optimiser les tris
- Améliorer les jointures
- Garantir l'unicité

### Quand indexer ?
- Colonnes de recherche fréquente
- Clés étrangères
- Colonnes de tri fréquent
- Colonnes de jointure

::right::

### À éviter
- Tables peu volumineuses
- Colonnes rarement utilisées
- Colonnes très variables
- Colonnes fréquemment mises à jour

```sql
-- Index pertinent
CREATE INDEX idx_recherche_email 
ON utilisateurs(email)
WHERE statut = 'actif';

-- Index moins pertinent
CREATE INDEX idx_date_creation
ON logs(date_creation);  -- Trop de mises à jour
```

---
layout: two-cols-header
---

# Types d'index

::left::

### Index simple
```sql
-- Sur une seule colonne
CREATE INDEX idx_nom 
ON employes(nom);
```

### Index composite
```sql
-- Sur plusieurs colonnes
CREATE INDEX idx_nom_dept 
ON employes(departement, nom);
-- Ordre important !
```

::right::

### Index partiel
```sql
-- Condition WHERE
CREATE INDEX idx_commandes_importantes 
ON commandes(date_commande) 
WHERE montant > 1000;
```

### Index sur expression
```sql
-- Sur une expression
CREATE INDEX idx_email_lower 
ON utilisateurs(LOWER(email));
```

---
layout: two-cols-header
---

# Optimisation des requêtes

::left::

### Bonnes pratiques
- Éviter SELECT *
- Limiter les résultats
- Utiliser des index existants
- Optimiser les jointures

### Points d'attention
- Cardinalité des jointures
- Ordre des jointures
- Conditions du WHERE
- Taille des résultats intermédiaires

::right::

```sql
-- Avant optimisation
SELECT *
FROM commandes c
JOIN clients cl ON c.client_id = cl.id
WHERE LOWER(cl.email) LIKE '%@gmail.com'
AND c.date_commande >= '2023-01-01';

-- Après optimisation
SELECT 
    c.id, c.date_commande, 
    cl.nom, cl.email
FROM clients cl
JOIN commandes c ON c.client_id = cl.id
WHERE cl.email LIKE '%@gmail.com'
AND c.date_commande >= '2023-01-01';
```

---
layout: two-cols-header
---

# Bonnes pratiques de performance

::left::

### 1. Structure et conception
- Normalisation appropriée
- Types de données adaptés
- Contraintes pertinentes
- Index stratégiques

### 2. Écriture des requêtes
- Utiliser les index existants
- Éviter les fonctions sur les colonnes indexées
- Préférer EXISTS à IN pour les sous-requêtes
- Limiter le nombre de jointures

::right::

### 3. Maintenance
- Mettre à jour les statistiques
- Reconstruire les index fragmentés
- Surveiller les requêtes lentes
- Analyser les plans d'exécution

```sql
-- Exemple de bonne pratique
SELECT c.nom, COUNT(o.id) as nb_commandes
FROM clients c
LEFT JOIN commandes o ON c.id = o.client_id
    AND o.date_commande >= CURRENT_DATE - INTERVAL '30 days'
GROUP BY c.id, c.nom
HAVING COUNT(o.id) > 0;
```

---
layout: iframe
url: https://app.wooclap.com/IERLNE/questionnaires/67884f43762064bf460ad9c3
---

---
layout: cover
---

# SQL - ORM(Object-Relational Mapping)
## Intégration avec SQLAlchemy

---
layout: two-cols-header
---

# Introduction à SQLAlchemy

::left::

### Qu'est-ce que SQLAlchemy ?
- ORM Python le plus populaire
- Abstraction de la base de données
- Mapping objet-relationnel
- API complète et flexible

### Architecture
- Engine (connexion)
- Session (transactions)
- Model (définition des tables)
- Query API (requêtes)

::right::

```python
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base

# Connexion
engine = create_engine('postgresql://user:pwd@localhost/db')

# Session
Session = sessionmaker(bind=engine)
session = Session()

# Base pour les modèles
Base = declarative_base()
```

---
layout: two-cols-header
---

# Mapping objet-relationnel

::left::

### Définition des modèles
```python
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String, unique=True)
    orders = relationship("Order", back_populates="user")
```

::right::

### Relations
```python
class Order(Base):
    __tablename__ = 'orders'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    amount = Column(Integer)
    user = relationship("User", 
                       back_populates="orders")
```

---
layout: two-cols-header
---

# Requêtes avec SQLAlchemy

::left::

### Opérations CRUD
```python
# Create
new_user = User(name="Alice", email="alice@email.com")
session.add(new_user)
session.commit()

# Read
user = session.query(User).filter_by(name="Alice").first()

# Update
user.email = "newemail@email.com"
session.commit()

# Delete
session.delete(user)
session.commit()
```

::right::

### Requêtes complexes
```python
# Jointures
results = session.query(User, Order)\
    .join(Order)\
    .filter(Order.amount > 100)\
    .all()

# Agrégations
from sqlalchemy import func
avg_amount = session.query(
    func.avg(Order.amount))\
    .scalar()

# Window Functions
from sqlalchemy import over
rank = func.rank()\
    .over(order_by=Order.amount.desc())
```

---
layout: two-cols-header
---

# Avantages de l'ORM

::left::

### Bénéfices
- Code plus pythonique
- Abstraction de la base
- Portabilité
- Sécurité automatique

### Limitations
- Performance vs SQL pur
- Courbe d'apprentissage
- Complexité pour requêtes avancées

::right::

### Bonnes pratiques
```python
# Sessions contextuelles
with Session() as session:
    user = session.query(User).get(1)
    user.name = "New Name"
    session.commit()

# Chargement efficace
users = session.query(User)\
    .options(joinedload(User.orders))\
    .filter(User.active == True)\
    .all()

# Pagination
page = session.query(User)\
    .order_by(User.id)\
    .limit(20)\
    .offset(40)\
    .all()
```


---
layout: cover
background: https://source.unsplash.com/collection/94734566/1920x1080
---

# Introduction au NoSQL
## Au-delà du relationnel

---
layout: two-cols-header
---

# Pourquoi NoSQL ?

::left::

<div class="mb-6">

### Limites du SQL
- Schéma rigide
- Scalabilité verticale
- Performances avec grands volumes
- Structures complexes
- Coût des jointures

</div>

<div>

### Besoins modernes
- Données non structurées
- Scalabilité horizontale
- Haute disponibilité
- Temps réel
- Agilité de développement

</div>

::right::

```mermaid
graph TB
    A[Challenges] --> B[Volume]
    A --> C[Vélocité]
    A --> D[Variété]
    B --> E[Big Data]
    C --> E
    D --> E
    E --> F[NoSQL]
```

---
layout: default
---

# Le théorème CAP

<div class="grid grid-cols-3 gap-4">

<div>

### Cohérence
- Tous les nœuds voient les mêmes données
- Lectures cohérentes
- Transactions ACID

</div>

<div>

### Disponibilité
- Chaque requête reçoit une réponse
- Sans erreur
- Sans garantie de fraîcheur

</div>

<div>

### Tolérance au partitionnement
- Le système continue de fonctionner
- Malgré les pertes de messages
- Ou pannes réseau

</div>

</div>

<div class="mt-8">

```mermaid
graph TD
    C[Cohérence] --- CA[MongoDB]
    C --- CP[Redis]
    A[Disponibilité] --- CA
    A --- AP[Cassandra]
    P[Partitionnement] --- CP
    P --- AP
```

</div>

---
layout: two-cols-header
---

# Types de bases NoSQL

::left::

<div class="mb-6">

### Document (MongoDB)
```json
{
  "id": 1,
  "nom": "Dupont",
  "adresses": [
    {
      "type": "domicile",
      "ville": "Paris"
    },
    {
      "type": "travail",
      "ville": "Lyon"
    }
  ]
}
```

</div>

<div>

### Clé-valeur (Redis)
```bash
SET user:1:nom "Dupont"
SET user:1:email "dupont@mail.com"
HSET user:1 nom "Dupont" email "dupont@mail.com"
```

</div>

::right::

<div class="mb-6">

### Colonnes (Cassandra)
```sql
CREATE TABLE users (
  user_id uuid,
  year int,
  month int,
  events map<timestamp, text>,
  PRIMARY KEY ((user_id), year, month)
);
```

</div>

<div>

### Graphe (Neo4j)
```cypher
CREATE (u:User {name: 'Dupont'})
CREATE (p:Post {title: 'NoSQL'})
CREATE (u)-[:AUTHORED]->(p)
```

</div>

---
layout: two-cols-header
---

# Caractéristiques NoSQL

::left::

<div class="mb-4">

### Cloud et coûts
- Utilisent des architecture Cloud
- Très souvent Pay as you go
- Licences gratuites car Open Source

### Open Source
- Open source, donc facilement modifiable et extensible.
- Contributeurs et communautés très actives


### Flexibilité
- Modélisation à l'écriture
- Pas de schéma prédéfini
- Dénormalisation acceptée
- Attention celà n'exclue pas une modélisation rigoureuse

</div>

::right::

<div class="col-md-6">


### Scalabilité
- Support pour des données volumineuses
- Capacité à scaler horizontalement(sauf Graphes)

### Disponibilité
- Tolérant aux interruptions de réseau
- Assure la continuité de service


</div>

<div>

### Patterns courants
- Embedded Documents
- References
- Buckets
- Extended Reference
- Subset Pattern

</div>




---
layout: default
---

# Comparaison SQL vs NoSQL

<div class="grid grid-cols-2 gap-4">

<div>

### SQL
- Schéma fixe
- Relations
- Transactions ACID
- Jointures
- Scalabilité verticale
- Requêtes complexes
- Cohérence forte

</div>

<div>

### NoSQL
- Schéma flexible
- Documents imbriqués
- BASE (Basic Availability)
- Dénormalisation
- Scalabilité horizontale
- Requêtes simples
- Cohérence éventuelle

</div>

</div>

<div class="mt-6">

### Critères de choix
1. Nature des données (structurées vs non structurées)
2. Volume et croissance prévue
3. Patterns d'accès (lectures vs écritures)
4. Besoins en cohérence
5. Expertise de l'équipe

</div>

---
layout: two-cols-header
---

# Cas d'usage

::left::

<div class="mb-4">

### Applications idéales
- Réseaux sociaux
- IoT / Big Data
- Logging
- E-commerce
- Temps réel
- Contenu mobile

</div>

<div>

### Exemples concrets
- Facebook : Cassandra
- LinkedIn : MongoDB
- Twitter : Redis
- Amazon : DynamoDB

</div>

::right::

```mermaid
graph TB
    A[Cas d'usage] --> B[Temps réel]
    A --> C[Big Data]
    A --> D[Mobile]
    B --> E[Redis]
    B --> F[MongoDB]
    C --> G[Cassandra]
    C --> H[HBase]
    D --> F
    D --> I[CouchDB]
```

---
layout: iframe
url: https://app.wooclap.com/IERLNE/questionnaires/678858c2ab98a0451c9acab1
---

---
layout: cover
---

# MongoDB
## Une base de données orientée document

---
layout: default
---

# Qu'est-ce que MongoDB ?

### Caractéristiques principales
- Base de données NoSQL orientée document
- Documents au format BSON (Binary JSON)
- Schéma flexible et dynamique
- Scalabilité horizontale native
- Haute disponibilité avec la réplication

### Architecture
- Collections ≈ Tables en SQL
- Documents ≈ Lignes en SQL
- Champs ≈ Colonnes en SQL
- Index supportés
- Pas de jointures natives

---
layout: two-cols-header
---

# Structure des données

::left::

### Document BSON
```json
{
  "_id": ObjectId("5f7d3"),
  "nom": "Dupont",
  "age": 30,
  "adresses": [
    {
      "type": "domicile",
      "ville": "Paris",
      "code_postal": "75001"
    },
    {
      "type": "travail",
      "ville": "Lyon",
      "code_postal": "69001"
    }
  ],
  "tags": ["VIP", "Premium"]
}
```

::right::

### Types de données
- Strings
- Numbers (Integer, Float, Decimal)
- Dates
- Boolean
- Arrays
- Embedded Documents
- ObjectId
- Null
- Binary Data
- Regular Expression

---
layout: two-cols-header
---

# Opérations CRUD

::left::

### Create
```javascript
// Insérer un document
db.clients.insertOne({
  nom: "Dupont",
  age: 30
})

// Insérer plusieurs documents
db.clients.insertMany([
  { nom: "Martin", age: 25 },
  { nom: "Bernard", age: 35 }
])
```

### Read
```javascript
// Trouver tous les clients
db.clients.find()

// Avec filtre
db.clients.find({
  age: { $gt: 30 }
})
```

::right::

### Update
```javascript
// Modifier un document
db.clients.updateOne(
  { nom: "Dupont" },
  { $set: { age: 31 } }
)

// Modifier plusieurs documents
db.clients.updateMany(
  { age: { $lt: 30 } },
  { $set: { statut: "jeune" } }
)
```

### Delete
```javascript
// Supprimer un document
db.clients.deleteOne({
  nom: "Dupont"
})

// Supprimer plusieurs documents
db.clients.deleteMany({
  age: { $lt: 25 }
})
```

---
layout: default
---

# Requêtes avancées

### Opérateurs de comparaison
```javascript
{
  age: { $gt: 25 },        // plus grand que
  prix: { $lte: 100 },     // plus petit ou égal
  statut: { $ne: "inactif" }, // différent de
  tags: { $in: ["VIP", "Premium"] } // dans la liste
}
```

### Opérateurs logiques
```javascript
{
  $and: [
    { age: { $gt: 25 } },
    { ville: "Paris" }
  ],
  $or: [
    { statut: "VIP" },
    { points: { $gt: 100 } }
  ]
}
```

---
layout: two-cols-header
---

# Indexation avec MongoDB

::left::

### Types d'index
- Single Field Index
- Compound Index
- Text Index
- Geospatial Index
- ...

### Création d'index
```javascript
// Index simple
db.clients.createIndex({ nom: 1 })

// Index composé
db.clients.createIndex(
  { ville: 1, age: -1 }
)

// Index unique
db.clients.createIndex(
  { email: 1 },
  { unique: true }
)
```

::right::

### Bonnes pratiques
- Index sur les champs fréquemment recherchés
- Attention aux index composés : ordre important
- Éviter la sur-indexation
- Utiliser explain() pour analyser
- Index en arrière-plan pour la production

### Analyse des index
```javascript
// Analyser une requête
db.clients.find({ 
  ville: "Paris" 
}).explain("executionStats")

// Liste des index
db.clients.getIndexes()

// Statistiques d'index
db.clients.stats()
```

---
layout: two-cols-header
---

# Cas d'utilisation de MongoDB

::left::

### Idéal pour
- Applications web modernes
- Contenu varié et évolutif
- Données semi-structurées
- Besoin de scalabilité horizontale
- Développement agile
- Applications temps réel

::right::

### Exemples concrets
1. **E-commerce**
   - Catalogues de produits
   - Paniers utilisateurs
   - Historique des commandes

2. **Applications mobiles**
   - Profils utilisateurs
   - Contenu généré par les utilisateurs
   - Données de géolocalisation

3. **Analytics**
   - Logs d'événements
   - Données IoT
   - Métriques en temps réel

---
layout: two-cols-header
---

# Modélisation des données

::left::

### Patterns de conception
- Embedded Documents
```javascript
{
  _id: 1,
  item: "Xbox Series X",
  manufacturer: {
    name: "Microsoft",
    address: "Redmond, WA",
    phone: "123-456-7890"
  }
}
```

- References
```javascript
{
  _id: 1,
  item: "Xbox Series X",
  manufacturer_id: 123
}
```

::right::

### Bonnes pratiques
- Privilégier l'embedding pour les relations 1:1
- Utiliser les références pour les relations N:M
- Dénormaliser stratégiquement
- Limiter la taille des documents
- Concevoir pour les cas d'utilisation

### Anti-patterns
- Jointures côté application excessive
- Documents trop profonds
- Arrays non bornés
- Références en cascade

---
layout: cover
background: https://source.unsplash.com/collection/94734566/1920x1080
---

# MongoDB - Innovations 2025
## Les dernières avancées qui transforment le NoSQL

---
layout: two-cols-header
---

# MongoDB 8.2 - Dernière version

::left::

<div class="mb-4">

### 🚀 Version actuelle : **MongoDB 8.2**
Sortie récente avec des fonctionnalités majeures

</div>

<div class="mb-4">

### Nouveautés principales

**Search & Vector Search Community** 🔍
- Recherche full-text native
- Vector Search dans Community Edition
- Capacités IA pour tous

**Hybrid Search** 🔀
- Stage `$scoreFusion` pour recherche hybride
- Combinaison texte + vecteurs
- Pertinence améliorée

</div>

::right::

<div class="mb-4">

**Queryable Encryption amélioré** 🔐
- Requêtes prefix, suffix, substring
- Champs chiffrés interrogeables
- Sécurité maximale sans compromis

**Améliorations techniques** ⚡
- `$currentDate` avec aggregate()
- Métriques disk usage standardisées
- Performance optimisée

</div>

<div class="mt-4 p-4 bg-green-900 rounded">

💡 **MongoDB 8.2** apporte des fonctionnalités Atlas vers les déploiements self-managed

</div>

---
layout: two-cols-header
---

# Queryable Encryption
## Sécurité maximale des données

::left::

<div class="mb-4">

### Chiffrement interrogeable
- **At rest** : Données chiffrées au repos
- **In transit** : Données chiffrées en transit
- **In use** : Données utilisables chiffrées

</div>

<div>

### Cas d'usage
- Données médicales (HIPAA)
- Informations bancaires (PCI-DSS)
- Données personnelles (RGPD)
- Secteur public et défense

### Nouveauté 8.2
```javascript
// Recherche sur champs chiffrés
db.patients.find({
  nom: { $regex: "^Dup" }  // Prefix search
})
```

</div>

::right::

<div class="flex items-center justify-center h-full">
  <img src="/images/encryption.png" class="rounded-lg shadow-lg"/>
</div>

---
layout: two-cols-header
---

# Vector Search & RAG
## MongoDB et l'Intelligence Artificielle

::left::

<div class="mb-6">

### Architecture RAG complète
- **Vector Search** : Recherche sémantique
- **Embeddings** : Vectorisation de données
- **Reranking** : Optimisation des résultats
- **LLM Integration** : Intégration modèles IA

</div>

<div>

### Cas d'usage IA
- Chatbots intelligents
- Moteurs de recommandation
- Recherche sémantique
- Assistants virtuels
- Analyse de documents

</div>

::right::

<div class="flex items-center justify-center h-full">
  <img src="/images/pipeline.png" class="rounded-lg shadow-lg"/>
</div>

---
layout: default
---

# Vector Search en pratique

### Créer un index vectoriel
```javascript
db.products.createSearchIndex({
  name: "vector_index",
  type: "vectorSearch",
  definition: {
    fields: [{
      type: "vector",
      path: "embedding",
      numDimensions: 1536,
      similarity: "cosine"
    }]
  }
})
```

### Recherche vectorielle
```javascript
db.products.aggregate([
  {
    $vectorSearch: {
      index: "vector_index",
      path: "embedding",
      queryVector: [0.123, 0.456, ...], // 1536 dimensions
      numCandidates: 100,
      limit: 10
    }
  },
  {
    $project: {
      name: 1,
      description: 1,
      score: { $meta: "vectorSearchScore" }
    }
  }
])
```

---
layout: two-cols-header
---

# Agents IA avec MongoDB
## Memory & State Management

::left::

<div class="mb-6">

### Architecture Agent-Database
**Cycle de l'Agent**
1. **Perceive** : Perception de l'environnement
2. **Decide** : Prise de décision
3. **Act** : Action et exécution

**Rôle de MongoDB**
- Memory & State persistant
- Contexte et historique
- Contraintes et règles
- Capture des résultats

</div>

::right::

<div class="flex items-center justify-center h-full">
  <img src="/images/agents.png" class="rounded-lg shadow-lg"/>
</div>

---
layout: default
---

# Pourquoi MongoDB pour l'IA ?

<div class="grid grid-cols-2 gap-6">

<div>

### Avantages techniques
- **Schéma flexible** : Adaptation rapide aux données IA
- **Vector Search natif** : Pas besoin de base vectorielle séparée
- **Performance** : Requêtes vectorielles rapides
- **Scalabilité** : Gestion de millions de vecteurs
- **Unified Platform** : Données + Vecteurs + Métadonnées

</div>

<div>

### Use cases concrets
1. **RAG (Retrieval-Augmented Generation)**
   - Documentation technique
   - Support client automatisé

2. **Agents autonomes**
   - Memory à long terme
   - Context management

3. **Recommandation**
   - Similar items
   - Personnalisation

4. **Analyse sémantique**
   - Clustering de documents
   - Classification automatique

</div>

</div>

<div class="mt-6 p-4 bg-blue-900 rounded">

🔥 **MongoDB se positionne comme la base de données de référence pour l'IA moderne**

</div>

---
layout: iframe
url: https://app.wooclap.com/IERLNE/questionnaires/6788bc78c2c45244acd9d297
---
---
layout: cover
# background: './images/pont.png'
---

# Neo4j
## Base de données orientée graphe

---
layout: two-cols-header
# image: '/images/ponts.png'
---
# Le problème des 7 ponts

::left::

**Ponts de Koenigsberg**

<div class="mr-4 mt-6">
<img src="/images/ponts.png"/>
</div>

::right::

**Vue simplifiée**

<div class="mr-4 mt-6">
  <img src="/images/ponts-simple.png"/>
</div>

---
layout: default
# image: '/images/ponts.png'
---
# Le problème des 7 ponts





<div class="mr-4 mt-6">
  <img src="/images/image.png"/>
</div>

---
layout: default
---

# Qu'est-ce que Neo4j ?


### Caractéristiques principales
- Base de données orientée graphe
- Modélisation naturelle des relations
- Langage de requête Cypher
- ACID compliant
- Très performant pour les données connectées

### Architecture
- Nœuds (Nodes) ≈ Entités
- Relations (Relationships) ≈ Connexions
- Propriétés ≈ Attributs
- Labels ≈ Types de nœuds
- Types de relations

---
layout: two-cols-header
---

# Structure d'un graphe

::left::

### Éléments de base
```mermaid
graph LR
    A[Personne:Alice] -->|CONNAIT| B[Personne:Bob]
    B -->|TRAVAILLE_POUR| C[Entreprise:Tech]
    A -->|AIME| D[Produit:Phone]
```

### Types de nœuds (Labels)
- Personne
- Entreprise
- Produit
- Lieu
- Événement

::right::

### Relations et propriétés
```cypher
CREATE (p:Personne {
  nom: "Alice",
  age: 30
})-[r:TRAVAILLE_POUR {
  depuis: "2020",
  poste: "Développeur"
}]->(e:Entreprise {
  nom: "Tech Corp",
  secteur: "IT"
})
```

---
layout: two-cols-header
---

# Langage Cypher

::left::

### Création de nœuds
```cypher
// Créer un nœud
CREATE (p:Personne {
  nom: "Alice",
  age: 30
})

// Créer une relation
MATCH (a:Personne {nom: "Alice"})
MATCH (b:Personne {nom: "Bob"})
CREATE (a)-[r:CONNAIT]->(b)
```

### Lecture
```cypher
// Trouver des nœuds
MATCH (p:Personne)
WHERE p.age > 25
RETURN p

// Avec relations
MATCH (p:Personne)-[r:TRAVAILLE_POUR]->(e:Entreprise)
RETURN p, r, e
```

::right::

### Modification
```cypher
// Mettre à jour un nœud
MATCH (p:Personne {nom: "Alice"})
SET p.age = 31

// Modifier une relation
MATCH ()-[r:TRAVAILLE_POUR]->()
SET r.poste = "Senior Dev"
```

### Suppression
```cypher
// Supprimer un nœud
MATCH (p:Personne {nom: "Alice"})
DELETE p

// Supprimer une relation
MATCH ()-[r:CONNAIT]->()
DELETE r
```

---
layout: default
---

# Requêtes avancées

### Navigation dans le graphe
```cypher
// Chemins de longueur variable
MATCH (a:Personne {nom: "Alice"})-[*1..3]->(b)
RETURN b

// Plus court chemin
MATCH p=shortestPath(
  (a:Personne)-[*]->(b:Personne)
)
WHERE a.nom = "Alice" AND b.nom = "Charlie"
RETURN p
```

### Agrégation et patterns complexes
```cypher
// Groupement et comptage
MATCH (p:Personne)-[:TRAVAILLE_POUR]->(e:Entreprise)
RETURN e.nom, count(p) as nb_employes
ORDER BY nb_employes DESC

// Pattern complexe
MATCH (p1:Personne)-[:CONNAIT]->(p2:Personne)-[:TRAVAILLE_POUR]->(e:Entreprise)
WHERE p1.nom = "Alice" AND e.secteur = "IT"
RETURN DISTINCT p2.nom as contacts_it
```

---
layout: two-cols-header
---

# Modélisation avec Neo4j

::left::

### Bonnes pratiques
1. **Labels**
   - Utilisez des labels multiples
   - Hiérarchie de labels
   - Nommage clair

2. **Relations**
   - Direction significative
   - Nommage explicite
   - Propriétés utiles

3. **Propriétés**
   - Attributs atomiques
   - Indexation stratégique
   - Pas de tableaux complexes

::right::

### Patterns communs
```mermaid
graph TD
    A[User] -->|POSTED| B[Post]
    B -->|TAGGED| C[Topic]
    A -->|FOLLOWS| A
    B -->|REPLY_TO| B
```

### Anti-patterns
- Relations sans direction
- Propriétés redondantes
- Sur-utilisation des labels
- Relations génériques

---
layout: two-cols-header
---

# Indexation et Performances

::left::

### Types d'index
- Indexes par label/propriété
- Composite indexes
- Full-text indexes
- Range indexes

### Création d'index
```cypher
// Index simple
CREATE INDEX FOR (p:Personne) 
ON (p.nom)

// Index composé
CREATE INDEX FOR (p:Personne)
ON (p.nom, p.age)

// Index full-text
CREATE FULLTEXT INDEX personneSearch 
FOR (p:Personne) 
ON EACH [p.nom, p.description]
```

::right::

### Optimisation
1. **Stratégies d'indexation**
   - Index sur les propriétés filtrées
   - Index sur les propriétés de jointure
   - Éviter la sur-indexation

2. **Analyse des performances**
   ```cypher
   PROFILE
   MATCH (p:Personne)-[:CONNAIT]->()
   RETURN p.nom, count(*) as relations
   ```

3. **Monitoring**
   - Utilisation de la mémoire
   - Temps de réponse
   - Cache hits/misses

---
layout: default
---

# Cas d'utilisation de Neo4j

### Idéal pour
- Réseaux sociaux
- Systèmes de recommandation
- Détection de fraude
- Graphes de connaissances
- Gestion des identités
- Analyse d'impact

### Exemples concrets
1. **Réseaux sociaux**
```cypher
// Trouver les amis des amis
MATCH (p:Personne {nom:"Alice"})-[:CONNAIT]->(ami)-[:CONNAIT]->(amiDami)
WHERE NOT (p)-[:CONNAIT]->(amiDami)
RETURN DISTINCT amiDami.nom as suggestions
```

2. **Recommandations**
```cypher
// Produits fréquemment achetés ensemble
MATCH (p:Produit)<-[:A_ACHETE]-(c:Client)-[:A_ACHETE]->(autreProduit:Produit)
WHERE p.id = "123"
RETURN autreProduit.nom, count(*) as frequence
ORDER BY frequence DESC
LIMIT 5
```

3. **Détection de fraude**
```cypher
// Identifier les cycles de transactions suspects
MATCH chemin = (c:Compte)-[:TRANSFERT*3..5]->(c)
WHERE ALL(r IN relationships(chemin) WHERE r.montant > 10000)
RETURN chemin
```
---
layout: iframe
url: https://app.wooclap.com/IERLNE/questionnaires/6788bec9c2c45244acdce4c2
---

---
layout: cover
---


# Travaux Dirigés
## SQL et NoSQL en pratique

---
layout: default
---

# Organisation du TD

### Durée totale : 4 heures
- PostgreSQL : 60 minutes
- MongoDB : 80 minutes
- Pause: 10 minutes
- Neo4j : 80 minutes
- Révisions et questions : 15 minutes

### Objectifs
- Mettre en pratique les concepts vus en cours
- Développer des compétences pratiques
- Comprendre les cas d'usage spécifiques
- Comparer les approches SQL et NoSQL

---
layout: default
---

# TD 1 : PostgreSQL Avancé (45min)

### Exercice 1: Fenêtrage et CTE (15min)
```sql
-- Base de données fournie : entreprise
-- Tables: employes, departements, projets, assignments

-- 1.1 Écrivez une requête utilisant une fenêtre pour:
--   - Calculer le salaire moyen par département
--   - Afficher l'écart entre le salaire de chaque employé et la moyenne
--   - Classer les employés par salaire dans chaque département

-- 1.2 Utilisez une CTE pour:
--   - Identifier les départements où le salaire moyen est supérieur à la moyenne globale
--   - Lister les employés de ces départements
```

### Exercice 2: Requêtes complexes et optimisation (15min)
```sql
-- 2.1 Analysez et optimisez la requête suivante:
SELECT e.nom, d.nom_dept, COUNT(p.id) as nb_projets
FROM employes e
LEFT JOIN departements d ON e.dept_id = d.id
LEFT JOIN assignments a ON e.id = a.employe_id
LEFT JOIN projets p ON a.projet_id = p.id
GROUP BY e.nom, d.nom_dept;

-- 2.2 Proposez des index pertinents
-- 2.3 Utilisez EXPLAIN ANALYZE pour comparer les performances
```

### Exercice 3: Triggers et fonctions (15min)
```sql
-- 3.1 Créez un trigger qui:
--   - Met à jour la date de dernière modification d'un projet
--   - Vérifie que le nombre d'employés par projet ne dépasse pas 10

-- 3.2 Créez une fonction qui:
--   - Calcule le coût total d'un projet
--   - Prend en compte les salaires et les ressources
```

---
layout: default
---

# TD 2 : MongoDB (90min)

### Exercice 1: E-commerce (30min)
```javascript
// Base de données: ecommerce
// Collections: produits, commandes, clients

// 1.1 Créez les schémas suivants:
// - Produit (nom, prix, catégorie, stock, fournisseur)
// - Client (nom, email, adresses[], panier)
// - Commande (client, produits[], total, statut)

// 1.2 Écrivez les requêtes pour:
// - Lister les produits par catégorie avec stock < 10
// - Trouver les clients ayant dépensé plus de 1000€
// - Calculer le chiffre d'affaires par catégorie
```

### Exercice 2: Agrégation (30min)
```javascript
// 2.1 Pipeline d'agrégation pour:
// - Analyser les ventes mensuelles
// - Calculer le panier moyen
// - Identifier les meilleurs clients

// 2.2 Utiliser $lookup pour:
// - Joindre les informations clients et commandes
// - Enrichir les commandes avec détails produits
```

### Exercice 3: Modélisation et Performance (30min)
```javascript
// 3.1 Comparez ces deux modèles:
// Modèle 1: Documents embarqués
{
  client: { ... },
  produits: [ ... ],
  adresseLivraison: { ... }
}

// Modèle 2: Références
{
  client_id: "...",
  produits: ["id1", "id2"],
  adresse_id: "..."
}

// 3.2 Créez des index appropriés
// 3.3 Analysez les performances avec explain()
```

---
layout: default
---

# TD 3 : Neo4j (90min)

### Exercice 1: Réseau Social (30min)
```cypher
// Base de données: socialnetwork
// Nœuds: User, Post, Group

// 1.1 Créez un graphe de test avec:
// - 10 utilisateurs
// - Relations d'amitié
// - Posts et commentaires
// - Groupes et membres

// 1.2 Requêtes de base:
// - Trouver les amis communs
// - Lister les posts d'amis
// - Identifier les groupes populaires
```

### Exercice 2: Recommandations (30min)
```cypher
// 2.1 Développez des requêtes de recommandation:
// - Amis suggérés (amis d'amis)
// - Groupes susceptibles d'intéresser
// - Posts pertinents

// 2.2 Ajoutez des scores de pertinence:
// - Basés sur les intérêts communs
// - Pondérés par l'activité récente
```

### Exercice 3: Analyse de graphe (30min)
```cypher
// 3.1 Requêtes d'analyse:
// - Calculer la centralité des utilisateurs
// - Identifier les influenceurs
// - Détecter les communautés

// 3.2 Performance et optimisation:
// - Créer des index appropriés
// - Optimiser les requêtes complexes
// - Analyser les plans d'exécution
```

---
layout: default
---

# Livrables et Évaluation

### Pour chaque exercice
- Scripts SQL/NoSQL commentés
- Justification des choix de modélisation
- Analyse des performances
- Suggestions d'optimisation

### Critères d'évaluation
1. Fonctionnalité (40%)
   - Requêtes correctes
   - Résultats attendus
   - Gestion des erreurs

2. Performance (30%)
   - Optimisation
   - Indexation
   - Choix de modélisation

3. Style et bonnes pratiques (30%)
   - Code clair et documenté
   - Respect des conventions
   - Pertinence des choix techniques

---
layout: default
---

# Solutions types et ressources

### Documentation officielle
- PostgreSQL: postgresql.org/docs/
- MongoDB: docs.mongodb.com
- Neo4j: neo4j.com/docs/

### Outils recommandés
- pgAdmin ou DBeaver pour PostgreSQL
- MongoDB Compass
- Neo4j Browser

### Environnement de test
- Données de test fournies
- Scripts d'initialisation
- Configurations recommandées