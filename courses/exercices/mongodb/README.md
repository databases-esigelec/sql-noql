# TD MongoDB - Introduction

**Outil :** [OneCompiler MongoDB](https://onecompiler.com/mongodb)

**Ressources :** [CRUD Operations](https://www.mongodb.com/docs/manual/crud/) | [Query Operators](https://www.mongodb.com/docs/manual/reference/operator/query/) | [Update Operators](https://www.mongodb.com/docs/manual/reference/operator/update/) | [MongoDB Cheat Sheet](https://www.mongodb.com/developer/products/mongodb/cheat-sheet/)

---

## Aide-mémoire CRUD

```javascript
// CREATE
db.col.insertOne({nom: 'Alice', age: 30})
db.col.insertMany([{nom: 'Bob'}, {nom: 'Claire'}])

// READ
db.col.find()                                  // tout
db.col.find({age: {$gt: 25}})                  // filtre
db.col.find({tags: 'sport'})                   // valeur dans tableau
db.col.find({age: {$gte: 20, $lte: 30}})      // intervalle
db.col.find({$or: [{age: 25}, {nom: 'Bob'}]}) // OR

// UPDATE
db.col.updateOne({nom: 'Alice'}, {$set: {age: 31}})       // modifier
db.col.updateMany({}, {$inc: {stock: 5}})                  // incrémenter
db.col.updateOne({nom: 'Alice'}, {$push: {tags: 'sport'}}) // ajouter au tableau

// DELETE
db.col.deleteOne({nom: 'Alice'})
db.col.deleteMany({actif: false})
```

---

## Exercice 1 : Gestion d'une bibliothèque

Collection `livres` : `{titre, auteur, annee, genre, disponible}`

1. Insérez 3 livres différents.
2. Trouvez tous les livres disponibles.
3. Mettez à jour la disponibilité d'un livre.

<details>
<summary>Solutions</summary>

```javascript
// 1.
db.livres.insertMany([
  {titre: 'Les Misérables', auteur: 'Victor Hugo', annee: 1862, genre: 'Roman', disponible: true},
  {titre: "L'Étranger", auteur: 'Albert Camus', annee: 1942, genre: 'Roman', disponible: true},
  {titre: 'Harry Potter', auteur: 'J.K. Rowling', annee: 1997, genre: 'Fantasy', disponible: false}
])

// 2.
db.livres.find({disponible: true})

// 3.
db.livres.updateOne({titre: 'Harry Potter'}, {$set: {disponible: true}})
```
</details>

---

## Exercice 2 : Catalogue de produits

Collection `produits` : `{nom, prix, stock, categories: [String]}`

1. Ajoutez 4 produits avec différentes catégories.
2. Trouvez les produits dont le prix est inférieur à 50€.
3. Augmentez le stock de tous les produits de 5 unités.

<details>
<summary>Solutions</summary>

```javascript
// 1.
db.produits.insertMany([
  {nom: 'Clavier', prix: 45, stock: 20, categories: ['Informatique', 'Accessoires']},
  {nom: 'Écran 4K', prix: 350, stock: 8, categories: ['Informatique', 'Électronique']},
  {nom: 'Souris', prix: 25, stock: 50, categories: ['Informatique', 'Accessoires']},
  {nom: 'Webcam', prix: 75, stock: 15, categories: ['Électronique', 'Accessoires']}
])

// 2.
db.produits.find({prix: {$lt: 50}})

// 3.
db.produits.updateMany({}, {$inc: {stock: 5}})
```
</details>

---

## Exercice 3 : Gestion des utilisateurs

Collection `utilisateurs` : `{nom, email, age, actif, interets: [String]}`

1. Créez 3 utilisateurs avec des intérêts différents.
2. Trouvez les utilisateurs actifs de plus de 25 ans.
3. Ajoutez un nouvel intérêt à un utilisateur spécifique.

<details>
<summary>Solutions</summary>

```javascript
// 1.
db.utilisateurs.insertMany([
  {nom: 'Alice', email: 'alice@mail.com', age: 30, actif: true, interets: ['sport', 'musique']},
  {nom: 'Bob', email: 'bob@mail.com', age: 22, actif: true, interets: ['cinema', 'jeux']},
  {nom: 'Claire', email: 'claire@mail.com', age: 28, actif: false, interets: ['lecture', 'voyage']}
])

// 2.
db.utilisateurs.find({actif: true, age: {$gt: 25}})

// 3.
db.utilisateurs.updateOne({nom: 'Alice'}, {$push: {interets: 'cuisine'}})
```
</details>

---

**Points clés couverts :** CRUD (`insertMany`, `find`, `updateOne/Many`, `deleteOne`), opérateurs de comparaison (`$lt`, `$gt`, `$gte`), opérateurs de modification (`$set`, `$inc`, `$push`), tableaux, conditions multiples.
