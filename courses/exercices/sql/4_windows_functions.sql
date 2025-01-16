-- Création de la table
CREATE TABLE ventes (
    id_vente INT PRIMARY KEY,
    date_vente DATE,
    vendeur_id INT,
    nom_vendeur VARCHAR(50),
    montant DECIMAL(10,2),
    departement VARCHAR(50)
);

-- Insertion des données
INSERT INTO ventes VALUES
(1, '2024-01-01', 1, 'Alice', 1200.00, 'Électronique'),
(2, '2024-01-01', 2, 'Bob', 800.00, 'Électronique'),
(3, '2024-01-02', 1, 'Alice', 1500.00, 'Électronique'),
(4, '2024-01-02', 3, 'Charlie', 950.00, 'Informatique'),
(5, '2024-01-03', 2, 'Bob', 2000.00, 'Électronique'),
(6, '2024-01-03', 3, 'Charlie', 1100.00, 'Informatique'),
(7, '2024-01-04', 1, 'Alice', 1300.00, 'Électronique'),
(8, '2024-01-04', 2, 'Bob', 1700.00, 'Électronique');

-- Questions :

-- 1. Écrivez une requête qui calcule pour chaque vente :
-- Le total des ventes du vendeur
-- Le classement du vendeur par montant total des ventes
-- La moyenne mobile des ventes sur 3 jours par vendeur

-- 2. Écrivez une requête qui affiche pour chaque vente :
-- Le pourcentage que représente chaque vente par rapport au total du département
-- La différence avec la vente précédente du même vendeur

-- 3. Pour chaque vendeur, affichez :
-- Son nom
-- Le montant total de ses ventes
-- Son rang basé sur le total des ventes


-- 4. Pour chaque vente, affichez :
-- La date
-- Le nom du vendeur
-- Le montant
-- Le montant de la vente précédente du même vendeur

--- Question 1
SELECT 
    id_vente,
    date_vente,
    nom_vendeur,
    montant,
    SUM(montant) OVER (PARTITION BY nom_vendeur) as total_vendeur,
    RANK() OVER (ORDER BY SUM(montant) OVER (PARTITION BY nom_vendeur) DESC) as classement,
    AVG(montant) OVER (
        PARTITION BY nom_vendeur 
        ORDER BY date_vente 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as moyenne_mobile_3j
FROM ventes;

-- Question 2
SELECT 
    id_vente,
    nom_vendeur,
    departement,
    montant,
    ROUND(
        montant * 100.0 / SUM(montant) OVER (PARTITION BY departement),
        2
    ) as pourcentage_dept,
    montant - LAG(montant) OVER (
        PARTITION BY nom_vendeur 
        ORDER BY date_vente
    ) as diff_vente_precedente
FROM ventes;
-- Question 3
SELECT 
    nom_vendeur,
    SUM(montant) OVER (PARTITION BY nom_vendeur) as total_ventes,
    RANK() OVER (ORDER BY SUM(montant) OVER (PARTITION BY nom_vendeur) DESC) as rang
FROM ventes
GROUP BY nom_vendeur;

-- Question 4
SELECT 
    date_vente,
    nom_vendeur,
    montant,
    LAG(montant) OVER (
        PARTITION BY nom_vendeur 
        ORDER BY date_vente
    ) as vente_precedente
FROM ventes;
