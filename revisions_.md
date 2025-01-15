# NoSQL Databases - Révision
## Plan du cours


# 1. Concepts Fondamentaux
## Propriétés BASE
- **B**asically Available
- **S**oft State
- **E**ventually Consistent

## Théorème CAP
- Consistency (Cohérence)
- Availability (Disponibilité)
- Partition Tolerance (Tolérance au partitionnement)
<!-- - *Exercice de discussion: Quel compromis choisir?* -->

---
# 2. Types de Bases NoSQL
## Les 4 familles principales
1. Clé-valeur (Redis)
2. Document (MongoDB)
3. Colonne (Cassandra)
4. Graphe (Neo4j)

*Exercice pratique: Pour chaque type, donnez un cas d'usage*

---
# 3. MongoDB en détail
## Structure
- Base de données
- Collections
- Documents
- Champs

## Opérations CRUD
- Create: `insertOne()`, `insertMany()`
- Read: `find()`, `findOne()`
- Update: `updateOne()`, `updateMany()`
- Delete: `deleteOne()`, `deleteMany()`

---
# 4. Requêtes MongoDB
## Opérateurs de comparaison
- `$eq`: égal
- `$ne`: différent
- `$gt`: supérieur
- `$lt`: inférieur
- `$in`: dans une liste

*Exercice: Écrire des requêtes simples*

---
# 5. Write Concerns
## Niveaux
- `{w: 0}`: Sans accusé
- `{w: 1}`: Primary only
- `{w: "majority"}`: Majorité

*Discussion: Cas d'usage pour chaque niveau*

---
# 6. Neo4j
## Éléments de base
- Nœuds
- Relations
- Propriétés

## Cypher Query Language
```cypher
MATCH (n:Person)-[:FOLLOWS]->(m:Person)
RETURN n.name, m.name
```

---
# 7. Optimisation Neo4j
## Bonnes pratiques
- Utiliser les labels
- Indexer les propriétés clés
- Commencer par les patterns restrictifs

---
# 8. Cas Pratique
## Réseau Social
- Modélisation des données
- Choix technologiques
- Compromis CAP
- Scalabilité

---
# 9. Questions d'examen types
1. QCM sur les concepts
2. Questions théoriques
3. Exercices pratiques MongoDB
4. Exercices pratiques Neo4j

---
# 10. Ressources
- CM
- Exercices de training
