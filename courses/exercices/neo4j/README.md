# TD Neo4j - Introduction au langage Cypher

**Outil :** [Neo4j Sandbox](https://sandbox.neo4j.com/) (gratuit, aucune installation)

**Ressources :** [Cypher Cheat Sheet](https://neo4j.com/docs/cypher-cheat-sheet/25/all/) | [CRUD Cypher](https://neo4j.com/docs/getting-started/cypher-intro/updating/) | [Tutoriel interactif](https://neo4j.com/docs/getting-started/cypher/intro-tutorial/) | [GraphAcademy](https://graphacademy.neo4j.com/)

---

## Aide-mémoire Cypher

```cypher
// CREATE
CREATE (a:Personne {nom: 'Alice', age: 30})
MATCH (a:Personne {nom: 'Alice'}), (b:Personne {nom: 'Bob'})
CREATE (a)-[:CONNAIT {depuis: 2020}]->(b)

// READ
MATCH (p:Personne) WHERE p.age > 25 RETURN p.nom, p.age
MATCH (a:Personne {nom: 'Alice'})-[:CONNAIT]->(ami) RETURN ami.nom

// UPDATE
MATCH (p:Personne {nom: 'Alice'}) SET p.age = 31 RETURN p

// DELETE
MATCH (p:Personne {nom: 'Charlie'}) DETACH DELETE p   // noeud + relations
MATCH (p:Personne {nom: 'Alice'}) REMOVE p.age         // propriété seule

// MERGE (crée seulement si inexistant)
MERGE (p:Personne {nom: 'Alice'}) ON CREATE SET p.creeLe = date()

// Tout supprimer
MATCH (n) DETACH DELETE n
```

---

## Exercice 1 : Réseau Social Simple

1. Créez 3 personnes : Alice (30 ans), Bob (28 ans), Claire (32 ans).
2. Créez des relations `AMI_DE` : Alice↔Bob, Bob↔Claire, Alice↔Claire.
3. Trouvez tous les amis d'Alice.
4. Trouvez les amis des amis d'Alice qu'elle ne connaît pas directement.

<details>
<summary>Solutions</summary>

```cypher
-- 1.
CREATE (:Personne {nom: 'Alice', age: 30}), (:Personne {nom: 'Bob', age: 28}), (:Personne {nom: 'Claire', age: 32})

-- 2.
MATCH (a:Personne {nom: 'Alice'}), (b:Personne {nom: 'Bob'}) CREATE (a)-[:AMI_DE]->(b)
MATCH (b:Personne {nom: 'Bob'}), (c:Personne {nom: 'Claire'}) CREATE (b)-[:AMI_DE]->(c)
MATCH (a:Personne {nom: 'Alice'}), (c:Personne {nom: 'Claire'}) CREATE (a)-[:AMI_DE]->(c)

-- 3.
MATCH (a:Personne {nom: 'Alice'})-[:AMI_DE]-(ami) RETURN ami.nom

-- 4.
MATCH (a:Personne {nom: 'Alice'})-[:AMI_DE]-()-[:AMI_DE]-(foaf)
WHERE NOT (a)-[:AMI_DE]-(foaf) AND a <> foaf
RETURN DISTINCT foaf.nom
```
</details>

---

## Exercice 2 : Entreprise et Employés

1. Créez 2 entreprises : "TechCorp" (secteur: Informatique), "DataSoft" (secteur: Data).
2. Reliez les 3 personnes via `TRAVAILLE_CHEZ` avec une propriété `poste` : Alice → TechCorp (Développeur), Bob → TechCorp (Designer), Claire → DataSoft (Data Analyst).
3. Trouvez tous les employés de TechCorp avec leur poste.
4. Trouvez les personnes travaillant dans le secteur "Informatique".

<details>
<summary>Solutions</summary>

```cypher
-- 1.
CREATE (:Entreprise {nom: 'TechCorp', secteur: 'Informatique'}), (:Entreprise {nom: 'DataSoft', secteur: 'Data'})

-- 2.
MATCH (a:Personne {nom: 'Alice'}), (t:Entreprise {nom: 'TechCorp'}) CREATE (a)-[:TRAVAILLE_CHEZ {poste: 'Développeur'}]->(t)
MATCH (b:Personne {nom: 'Bob'}), (t:Entreprise {nom: 'TechCorp'}) CREATE (b)-[:TRAVAILLE_CHEZ {poste: 'Designer'}]->(t)
MATCH (c:Personne {nom: 'Claire'}), (d:Entreprise {nom: 'DataSoft'}) CREATE (c)-[:TRAVAILLE_CHEZ {poste: 'Data Analyst'}]->(d)

-- 3.
MATCH (p:Personne)-[r:TRAVAILLE_CHEZ]->(e:Entreprise {nom: 'TechCorp'})
RETURN p.nom AS employe, r.poste AS poste

-- 4.
MATCH (p:Personne)-[:TRAVAILLE_CHEZ]->(e:Entreprise {secteur: 'Informatique'})
RETURN p.nom, e.nom
```
</details>

---

## Exercice 3 : Produits et Catégories

1. Créez 3 catégories : "Électronique", "Informatique", "Accessoires".
2. Créez 4 produits : "iPhone" (999), "MacBook" (1299), "Clavier" (79), "Écran 4K" (450).
3. Associez via `APPARTIENT_A` : iPhone → Électronique, MacBook → Informatique, Clavier → Accessoires, Écran 4K → Électronique **et** Informatique.
4. Trouvez tous les produits de la catégorie "Électronique".
5. Trouvez les produits > 500€ avec leurs catégories.

<details>
<summary>Solutions</summary>

```cypher
-- 1.
CREATE (:Categorie {nom: 'Électronique'}), (:Categorie {nom: 'Informatique'}), (:Categorie {nom: 'Accessoires'})

-- 2.
CREATE (:Produit {nom: 'iPhone', prix: 999}), (:Produit {nom: 'MacBook', prix: 1299}),
       (:Produit {nom: 'Clavier', prix: 79}), (:Produit {nom: 'Écran 4K', prix: 450})

-- 3.
MATCH (p:Produit {nom: 'iPhone'}), (c:Categorie {nom: 'Électronique'}) CREATE (p)-[:APPARTIENT_A]->(c)
MATCH (p:Produit {nom: 'MacBook'}), (c:Categorie {nom: 'Informatique'}) CREATE (p)-[:APPARTIENT_A]->(c)
MATCH (p:Produit {nom: 'Clavier'}), (c:Categorie {nom: 'Accessoires'}) CREATE (p)-[:APPARTIENT_A]->(c)
MATCH (p:Produit {nom: 'Écran 4K'}), (c1:Categorie {nom: 'Électronique'}), (c2:Categorie {nom: 'Informatique'})
CREATE (p)-[:APPARTIENT_A]->(c1), (p)-[:APPARTIENT_A]->(c2)

-- 4.
MATCH (p:Produit)-[:APPARTIENT_A]->(c:Categorie {nom: 'Électronique'})
RETURN p.nom, p.prix

-- 5.
MATCH (p:Produit)-[:APPARTIENT_A]->(c:Categorie) WHERE p.prix > 500
RETURN p.nom, p.prix, collect(c.nom) AS categories
```
</details>
