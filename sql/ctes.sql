-- Création de la table employés
CREATE TABLE employes (
    id INT PRIMARY KEY,
    nom VARCHAR(100),
    departement VARCHAR(50),
    salaire DECIMAL(10,2)
);

-- Insertion de données représentatives
INSERT INTO employes (id, nom, departement, salaire) VALUES
-- Département IT
(1, 'Martin Philippe', 'IT', 65000.00),
(2, 'Dubois Marie', 'IT', 72000.00),
(3, 'Lefebvre Thomas', 'IT', 65000.00),
(4, 'Roux Julie', 'IT', 85000.00),

-- Département Marketing
(5, 'Bernard Sophie', 'Marketing', 52000.00),
(6, 'Petit Lucas', 'Marketing', 48000.00),
(7, 'Richard Emma', 'Marketing', 61000.00),
(8, 'Moreau Antoine', 'Marketing', 55000.00),

-- Département Finance
(9, 'Laurent Alice', 'Finance', 75000.00),
(10, 'Simon Paul', 'Finance', 82000.00),
(11, 'Michel Sarah', 'Finance', 78000.00),
(12, 'Leroy David', 'Finance', 92000.00),

-- Département RH
(13, 'Garcia Maria', 'RH', 45000.00),
(14, 'Martinez Jean', 'RH', 51000.00),
(15, 'Lopez Anna', 'RH', 48000.00);

-- Données cliens et commandes

CREATE TABLE clients (
    id INT PRIMARY KEY,
    nom VARCHAR(100)
);

CREATE TABLE commandes (
    id INT PRIMARY KEY,
    client_id INT,
    montant DECIMAL(10,2),
    FOREIGN KEY (client_id) REFERENCES clients(id)
);

-- Données de test
INSERT INTO clients VALUES
(1, 'Martin Paul'),
(2, 'Dubois Marie'),
(3, 'Bernard Luc');

INSERT INTO commandes VALUES
(1, 1, 150.00),
(2, 1, 250.00),
(3, 2, 120.00),
(4, 2, 180.00),
(5, 3, 300.00);


--- Requête à optimiser
SELECT 
    c.nom,
    (SELECT COUNT(*) FROM commandes WHERE client_id = c.id) as nb_commandes,
    (SELECT SUM(montant) FROM commandes WHERE client_id = c.id) as total,
    (SELECT AVG(montant) FROM commandes WHERE client_id = c.id) as panier_moyen
FROM clients c
WHERE (SELECT SUM(montant) FROM commandes WHERE client_id = c.id) > 300;
---
-- Plus claire
WITH stats_clients AS (
    SELECT 
        client_id,
        COUNT(*) as nb_commandes,
        SUM(montant) as total,
        AVG(montant) as panier_moyen
    FROM commandes
    GROUP BY client_id
)

SELECT 
    c.nom,
    s.nb_commandes,
    s.total,
    s.panier_moyen
FROM clients c
JOIN stats_clients s ON c.id = s.client_id
WHERE s.total > 300;


--- Requête à optimiser
SELECT * FROM employes 
WHERE departement IN (SELECT departement FROM employes GROUP BY departement HAVING COUNT(*) > 2);
--- Version optimisée avec CTE
WITH grands_dept AS (
    SELECT departement 
    FROM employes 
    GROUP BY departement 
    HAVING COUNT(*) > 10
)
SELECT e.* 
FROM employes e
JOIN grands_dept g ON e.departement = g.departement;