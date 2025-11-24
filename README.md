# 🍲 Projet M2 SIME : Application Recettes (Mobile Comparative)

Ce dépôt contient l'implémentation complète du Projet n°2 "Recettes", développé en **SwiftUI** dans le cadre du module "Approche comparative des technologies mobiles".

## 🛠️ Architecture du Projet

Le projet respecte le principe de la **Séparation des Responsabilités (SoC)** et utilise le **Repository Pattern** pour la gestion des données, comme exigé par le cours.

* **Gestion de l'État (Source de Vérité)**: Le flux de données est géré par la combinaison :
    * **`RecipeRepositoryDummyImpl`**: Classé `ObservableObject` qui contient le tableau des recettes (données en dur).
    * **`@Published`**: Assure la notification automatique de toute modification des données.
    * **`@StateObject`** (dans `RecipeListView`): Écoute les changements du Repository.
* **Injection de Dépendances**: Utilisation d'une classe `Injector` (Singleton) pour fournir une instance unique du Repository à l'application.
* **Liaison de l'Édition**: L'édition est gérée par des liaisons bidirectionnelles (`@Binding`) dans la vue `EditRecipeView`.

## 🧪 Fonctionnalités Implémentées

| Fonctionnalité | Statut | Détails |
| :--- | :--- | :--- |
| **Visualisation** | ✅ Complet | Affichage de la liste, des temps (prep/cook) et des détails. |
| **Édition (CRUD)** | ✅ Complet | Modification des temps, servings, et des ingrédients (ajout/suppression/édition nom et quantité). |
| **Tri des Ingrédients** | ✅ Implémenté | Tri des ingrédients par nom via un Toggle dans l'écran d'édition. |
| **Sélection d'Image** | ✅ Implémenté | Le placeholder est cliquable et déclenche le sélecteur d'image (Fonctionnalité Native via `ImagePicker` / `UIViewControllerRepresentable`). |

## 📦 Organisation des Fichiers

| Dossier | Contenu | Rôle |
| :--- | :--- | :--- |
| `data` | `RecipeModel.swift` (Structs) | Définit les modèles de données (`Recipe`, `Ingredient`). |
| `Repository` | `RecipeRepository.swift` (Implémentation) | Contient l'implémentation `DummyImpl`, le protocole `RecipeRepository` et la classe `Injector`. |
| `Views` | `RecipeListView`, `RecipeDetailView`, `EditRecipeView` | Couche UI et Navigation (`NavigationStack`). |
| `Native` | `ImagePicker.swift` | Pont entre SwiftUI et les fonctionnalités natives (UIKit). |

## ✍️ Auteur

**Auteur :** Lotfi Abdelkadir RABAH

**Master :** M2 SIME - Université de Rouen
