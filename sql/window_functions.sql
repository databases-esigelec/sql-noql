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

---
-- Définition des fonctions window
---

SELECT 
    nom,
    departement,
    salaire,
    AVG(salaire) OVER (PARTITION BY departement) as moy_dept,
    salaire - AVG(salaire) OVER (PARTITION BY departement) as diff_moyenne,
    RANK() OVER (PARTITION BY departement ORDER BY salaire DESC) as rang_salaire
FROM employes;