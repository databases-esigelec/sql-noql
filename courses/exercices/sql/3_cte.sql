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

