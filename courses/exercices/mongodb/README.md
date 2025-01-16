
# Exercices MongoDB

Pour réaliser ces exercices, nous utiliserons: https://onecompiler.com/mongodb


### Exercice 1 : Gestion d'une bibliothèque
**Structure :**
```javascript
// Collection : livres
{
    _id: ObjectId(),
    titre: String,
    auteur: String,
    annee: Number,
    genre: String,
    disponible: Boolean
}
```

**Questions :**
1. Insérez 3 livres différents
2. Trouvez tous les livres disponibles
3. Mettez à jour la disponibilité d'un livre


### Exercice 2 : Catalogue de produits
**Structure :**
```javascript
// Collection : produits
{
    _id: ObjectId(),
    nom: String,
    prix: Number,
    stock: Number,
    categories: [String]
}
```

**Questions :**
1. Ajoutez 4 produits avec différentes catégories
2. Trouvez les produits dont le prix est inférieur à 50€
3. Augmentez le stock de tous les produits de 5 unités


### Exercice 3 : Gestion des utilisateurs
**Structure :**
```javascript
// Collection : utilisateurs
{
    _id: ObjectId(),
    nom: String,
    email: String,
    age: Number,
    actif: Boolean,
    interets: [String]
}
```

**Questions :**
1. Créez 3 utilisateurs avec des intérêts différents
2. Trouvez les utilisateurs actifs de plus de 25 ans
3. Ajoutez un nouvel intérêt à un utilisateur spécifique


Ces exercices couvrent :
- Les opérations CRUD basiques
- Les opérateurs de comparaison ($lt, $gt)
- Les opérateurs de modification ($set, $inc, $push)
- Les tableaux
- Les requêtes avec conditions multiples