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
