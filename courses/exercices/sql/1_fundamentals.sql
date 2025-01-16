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

-- Question 1
SELECT l.titre, a.nom, a.prenom
FROM livres l
JOIN auteurs a ON l.id_auteur = a.id_auteur;

-- Question 2
SELECT titre, annee_publication
FROM livres
WHERE annee_publication < 1900
ORDER BY annee_publication;