# **ADR**

Architectural Decision Records

Historique des journaux de mises à jour importantes

#### Table of contents

* [Octobre 2022](#2022-octobre)

<a name="2022-octobre"></a>

## Octobre 2022

###### Date 2022/10/24

Titre : Récupération des fichiers json liés aux mods

Contexte :

* Le métier a besoin de mods pour fonctionner. Un mod est un objet de jeu, il est composé de plusieurs fichiers Json.

- Tous les mods utiles pour le métier sont stockées dans une base de données sqlite externe qui est encapsulé dans un fichier `file.content` lorsqu'il est téléchargé.
- L'extension du fichier `file.content` doit être changé en `file.zip` puis être dézippé afin de générer un `file.sqlite` qui sera ensuite parsé pour en extraire les fichiers json stocker dans les tables.

Descision : 

- Recuperer les fichiers json

Conséquence : 

* Permets de vérifier que je dispose bien de toutes les données nécessaire afin de créer les mods pour le métier

---
