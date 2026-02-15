

# 🧠 Atelier Design

## Concevoir **SmartCity Explorer** 
Un complément data-driven à ville-Idéale.fr

**TD – Séance de design**

> Aujourd’hui : pas de code, on pense **architecture data**

---

## 🎯 Objectif de la séance

À la fin de cet atelier, vous devez être capables de :

* formaliser un **besoin produit** (personas + scénarios)
* raisonner en **requêtes** avant le modèle
* choisir **où vivent les données** (SQL / Mongo / Neo4j)
* définir un **MVP** clair et testable
* établir un **contrat de cohérence** entre plusieurs bases

👉 Vous construisez la **spécification** du projet fil rouge.

---

## 🧩 Règles du jeu
1. On se met par groupe de 4
1. On part du **besoin utilisateur**, pas de la techno
2. Chaque choix doit être **justifié par une requête**
3. Il n’y a pas *une* réponse…
4. …mais il y a des réponses **difficiles à maintenir / tester / expliquer**
5. Le bon design = **simple, cohérent, exploitable**

---

## 🧠 Contexte réel

Vous êtes un couple (ou une famille) et vous cherchez une ville où vivre.

Vous voulez :

* comparer plusieurs villes
* comprendre *pourquoi* une ville est bien/notée
* lire des avis concrets (texte)
* obtenir des recommandations “villes similaires”

👉 Le web existe déjà, mais l’expérience est inefficace pour comparer.

---

## 🎭 Personas (on commence par eux)

### Persona A — Résidence principale

> “Je veux acheter en Île-de-France, pas trop cher, santé accessible, environnement correct, loisirs.”

### Persona B — Investissement locatif

> “Je veux une ville ‘safe’, dynamique, transport ok, et une demande locative.”

### Persona C — Étudiant / jeune actif

> “Je veux transport + enseignement + culture.”

---

## ❓ Questions produit à poser (collectif)

1. Quel est **le job to be done** ?
2. Quel est **le résultat attendu** en 30 secondes ?
3. Qu’est-ce que l’utilisateur compare exactement ?
4. Qu’est-ce qui doit être **filtrable** ? (critères)
5. Qu’est-ce qui doit être **lisible** ? (avis)
6. Qu’est-ce qui doit être **recommandable** ? (similarité)
7. Quels sont les **pièges** ? (subjectivité, biais, peu d’avis)

> On écrit les réponses au tableau. On ne design pas encore.

---

## 🔥 Définition du produit (à obtenir)

À la fin, votre app doit permettre :

<v-click>
✅ Rechercher une ville
</v-click>
<br>
<v-click>
✅ Filtrer selon des critères
</v-click>
<br>
<v-click>
✅ Trier (ex : qualité de vie, sécurité)
</v-click>
<br>
<v-click>
✅ Consulter les détails (scores + avis)
</v-click>
<br>
<v-click>
✅ Voir les “forces” d’une ville
</v-click>
<br>
<v-click>
✅ Obtenir des recommandations de villes similaires
</v-click>

---

## 🧠 Brainstorm collectif — “Quelles données existent ?”

Donnez-moi les “choses” qu’un système comme ça doit manipuler.

👉 On liste sans trier.

Exemples (à faire émerger) :

<v-click>
* Ville, département, région
</v-click>
<br>
<v-click>
* Critères (environnement, sécurité…)
</v-click>
<br>
<v-click>
* Scores par critère
</v-click>
<br>
<v-click>
* Avis / commentaires (texte)
</v-click>
<br>
<v-click>
* Auteur (pseudo)
</v-click>
<br>
<v-click>
* Tags / thématiques
</v-click>
<br>
<v-click>
* Similarité entre villes
</v-click>
<br>
<v-click>
* “Forces” d’une ville
</v-click>
<br>
<v-click>
* Recherches / filtres / tri
</v-click>


---

## 🔍 Exercice — Inventaire data (en binômes)

### En binômes (4 min)

Listez **12 objets / attributs** possibles.

Puis répondez :

* Qu’est-ce qui est **stable** ?
* Qu’est-ce qui est **variable** ?
* Qu’est-ce qui est **massivement textuel** ?
* Qu’est-ce qui est **relationnel/graph** ?

---

## 🚧 Stop au scope explosion

On définit un **MVP**.

### Question clé

**Quelles entités sont indispensables pour que l’app soit utile ?**

👉 MVP = version minimale utile *pour comparer et décider*.

---

## ✅ MVP attendu (objectif implicite)

Pour guider vers le bon design, on vise :

```text
MVP :
- City
- Department
- Region
- Scores (par ville)
- Review (avis/commentaire)
- Criterion (critère)
```

> Tout le reste = backlog (prix immo, démographie avancée, transports détaillés…)

---

## 🔑 Requêtes avant modèle (le cœur de l’atelier)

Un bon modèle rend les bonnes requêtes faciles.

### Question

**Quelles questions un utilisateur se pose ?**

---

## ✍️ Exercice — 10 requêtes en langage naturel

Chaque groupe écrit **10 requêtes**, classées en 3 catégories :

### A) Search / comparaison (SQL-like)

* “Quelles villes en IDF ont sécurité ≥ 7 et santé ≥ 6 ?”
* “Top 10 villes par qualité de vie dans le 95”

### B) Détails & lecture (document/text)

* “Afficher les 20 derniers avis sur Bezons”
* “Chercher dans les avis ‘insécurité’”

### C) Recommandation & exploration (graph)

* “Villes similaires à Bezons”
* “Quelles villes partagent les mêmes forces que Bezons ?”

---

## ⚖️ Vos requêtes = votre contrat

> Si votre modèle ne rend pas ces requêtes simples,
> alors votre modèle est mauvais.

Gardez ces requêtes visibles pour la suite.

---

## 🧱 Nature des données (tri structurant)

On classe vos données selon leur nature :

1. **Structuré & stable**
2. **Flexible & textuel**
3. **Relations & sémantique**

---

## 🤔 Questions de tri (guidées)

Pour chaque objet (ville, score, avis, similarité…) :

* Schéma fixe ou variable ?
* Contraintes nécessaires ?
* Beaucoup de texte ?
* Valeur portée par les **liens** ?
* Requête type “chemins / voisins / similarité” ?

---

## 💡 Mapping techno (sans trancher trop vite)

* Structuré & stable → **PostgreSQL**
* Flexible & textuel → **MongoDB**
* Relations & sémantique → **Neo4j**

---

## 🏗️ Décision d’architecture (ce qu’on veut voir)

### PostgreSQL (à faire émerger)

* Villes, départements, régions
* Scores par critère
* Tri / filtres / agrégations

### MongoDB

* Avis textuels (longs, variables)
* Tags
* Recherche texte

### Neo4j

* Critères comme nœuds
* Relation **STRONG_IN** entre ville et critère
* (Option) similarité entre villes

---

## ✅ Relation clé à faire émerger : STRONG_IN

On veut arriver à cette idée :

> Une ville a des “forces” : critères où elle est très bonne.

Modèle graphe :

```text
(:City)-[:STRONG_IN]->(:Criterion)
```

Questions aux étudiants :

* comment définir “forte” ? (seuil)
* où vit le score brut ?
* que gagne-t-on à projeter ça dans Neo4j ?

---

## 🎯 Seuil STRONG_IN (à décider en groupe)

Proposition :

* STRONG_IN si score ≥ 7.0

Questions :

* seuil unique ou par critère ?
* quel impact sur le nombre de relations ?
* comment le calculer depuis les scores ?

---

## ❓ Challenge architecture (questions pièges)

1. Pourquoi ne pas tout mettre en SQL ?
2. Pourquoi ne pas stocker les avis en SQL ?
3. Pourquoi MongoDB est meilleur pour le texte ?
4. Pourquoi Neo4j au lieu d’une table City_Criterion ?
5. Où vivent les **scores officiels** ?
6. Quelle base est la **source de vérité** ?

---

## 🔗 Contrat entre les bases (gouvernance)

Avoir plusieurs bases = règles claires.

### Questions clés

* Quelle base fait foi pour les scores ?
* Où vit le texte des avis ?
* Où vivent les relations STRONG_IN ?
* Quel identifiant commun ?
* Quelles règles de cohérence minimales ?

---

## ✍️ À produire — Gouvernance

Dans votre Markdown :

```text
- Source de vérité (structuré + scores) :
- Source de vérité (avis textuels) :
- Source de vérité (relations sémantiques) :
- Identifiant commun :
- 2 règles de cohérence :
```

---

## 🧠 Architecture globale

### Question clé

Quel est le rôle du backend FastAPI ?

Attendus :

* centraliser les accès DB
* appliquer les filtres et règles
* calculer QoL si besoin
* exposer un contrat API stable
* servir Streamlit

---

## ✍️ À produire — Architecture

```text
- Rôle du backend :
- Flux (API → DBs) :
- Ce que chaque base ne fait PAS :
```

---

## 🎤 Mini restitution (2 minutes / groupe)

Chaque groupe présente :

* son MVP (entités)
* 5 requêtes clés (1 SQL, 1 Mongo, 1 Neo4j minimum)
* répartition SQL/Mongo/Neo4j
* 1 décision forte + justification

On évalue la qualité du raisonnement.

---

## 📦 Livrable attendu

Un **fichier Markdown unique** contenant :

1. Personas + 2 scénarios
2. MVP (entités)
3. 10 requêtes clés (catégorisées)
4. Répartition SQL / MongoDB / Neo4j + justification
5. Gouvernance (source de vérité + règles)
6. Architecture globale (backend + flux)

