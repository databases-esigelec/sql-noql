# Guide rapide - TDs SQL/NoSQL

## TP PostgreSQL

1. Cloner le dépôt et se placer dans le bon répertoire :
```bash
git clone https://github.com/databases-esigelec/sql-noql
# ou
git pull # si vous avez déjà cloné le dépôt
# Naviguer dans le répertoire de TDs
cd courses/exercices/tds
```

2. Lancer les services PostgreSQL et Jupyter :
```bash
docker-compose up -d postgres jupyter
```

3. Vérifier que PostgreSQL est bien lancé :
```bash
docker ps 
```

4. Ouvrir Jupyter :
- Consulter les logs de Jupyter pour obtenir le token :
```bash
docker-compose logs jupyter
```
- Naviguer à l'adresse entourée: http://localhost:8888/lab?token=\<token>
![alt text](image.png)

- Ouvrir le notebook `work/sql.ipynb` dans le répertoire work
- Exécuter la cellule d'installation des dépendances :
```python
!pip install psycopg2-binary sqlalchemy pandas numpy
```

5. Tester la connexion avec la méthode `test_postgres_connection` définie dans la première cellule de code :
```python
print(test_postgres_connection())
# Doit afficher True
```

> **Note** : Si vous avez des problèmes de connexion, vérifiez que les informations de connexion dans le notebook sont correctes.

Si vous avez bien suivi les étapes, vous devriez être prêt à commencer les exercices. Plus qu'à suivre les instructions du notebook !

## TP MongoDB

1. Se placer dans le répertoire des TPs :
```bash
cd courses/exercices/tds
```

2. Lancer MongoDB et Jupyter :
```bash
docker-compose up -d mongo-server jupyter
```

3. Ouvrir Jupyter (même procédure que pour PostgreSQL) 
- Ouvrir le notebook `work/mongodb.ipynb`
- Installer pymongo :
```python
!pip install pymongo
```

4. Tester la connexion avec la méthode `test_mongo_connection` définie dans la première cellule de code :
```python
print(test_postgres_connection())
# Doit afficher True
```
> **Note** : Si vous avez des problèmes de connexion, vérifiez que les informations de connexion dans le notebook sont correctes.

Si vous avez bien suivi les étapes, vous devriez être prêt à commencer les exercices. Plus qu'à suivre les instructions du notebook !


## TP Neo4j

1. Se placer dans le répertoire des TPs :
```bash
cd courses/exercices/tds
```

2. Charger les données dump (important) :
```bash
# S'assurer que Neo4j est arrêté
docker-compose stop neo4j
rm -rf ./neo4j/data/* #pour Linux et MacOS
Remove-Item -Recurse -Force ./neo4j/data/* #pour Windows


# Charger le dump(Linux, MacOS)
docker run --interactive --tty --rm \
  -v ./neo4j/data:/data \
  -v ./backups:/backups \
  -v ./neo4j/logs:/logs \
  -v ./conf:/var/lib/neo4j/conf/ \
  --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes \
  neo4j/neo4j-admin:4.4.15-enterprise \
  neo4j-admin load --database=neo4j --from=/backups/validalab.dump

  # Charger le dump(Windows)
  docker run --interactive --tty --rm `
  -v ${PWD}/neo4j/data:/data `
  -v ${PWD}/backups:/backups `
  -v ${PWD}/neo4j/logs:/logs `
  -v ${PWD}/conf:/var/lib/neo4j/conf/ `
  --env NEO4J_ACCEPT_LICENSE_AGREEMENT=yes `
  neo4j/neo4j-admin:4.4.15-enterprise `
  neo4j-admin load --database=neo4j --from=/backups/validalab.dump
```

3. Lancer Neo4j et Jupyter :
```bash
docker-compose up -d neo4j jupyter
```

4. Ouvrir Jupyter (même procédure que pour PostgreSQL)
- Ouvrir le notebook `work/neo4j.ipynb`
- Installer neo4j :
```python
!pip install neo4j
```

5. Tester la connexion avec la méthode `test_neo4j_connection` définie dans la première cellule de code :
```python
print(test_neo4j_connection())
# Doit afficher True
```

> **Note** : Si vous avez des problèmes de connexion, vérifiez que les informations de connexion dans le notebook sont correctes.

Si vous avez bien suivi les étapes, vous devriez être prêt à commencer les exercices. Plus qu'à suivre les instructions du notebook !

## En cas de problème

- Pour voir les logs d'un service :
```bash
docker-compose logs [service]
```

- Pour redémarrer un service :
```bash
docker-compose restart [service]
```

- Pour tout réinitialiser :
```bash
docker-compose down
docker-compose up -d [services-necessaires]
```
