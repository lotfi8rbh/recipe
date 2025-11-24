import Foundation
import Combine

// MARK: - Modèles de données

struct Ingredient: Identifiable {
    let id = UUID()
    var name: String
    var quantity: Double
    var unit: String
}

struct Recipe: Identifiable {
    let id = UUID()
    var name: String
    var prepTimeMinutes: Int
    var cookTimeMinutes: Int
    var servings: Int
    var ingredients: [Ingredient]
    var directions: String
    
    var prepTimeString: String { "prep \(prepTimeMinutes) mins" }
    var cookTimeString: String { "cook \(cookTimeMinutes) mins" }
}

// MARK: - Protocole du Repository (Contrat)

protocol RecipeRepository: ObservableObject {
    var recipes: [Recipe] { get }
    func updateRecipe(recipe: Recipe)
    // NOTE: removeIngredient n'est plus requis ici si nous gérons la suppression via .onDelete
}

// MARK: - Implémentation Dummy (Source de vérité)

// CORRECTION : La classe déclare maintenant qu'elle se conforme au Protocole
class RecipeRepositoryDummyImpl: RecipeRepository {
    
    @Published var recipes: [Recipe] = [
        Recipe(
            name: "Simple Cake",
            prepTimeMinutes: 10,
            cookTimeMinutes: 30,
            servings: 12,
            ingredients: [
                Ingredient(name: "sugar", quantity: 200, unit: "g"),
                Ingredient(name: "butter", quantity: 125, unit: "g"),
                Ingredient(name: "eggs", quantity: 2, unit: ""),
                Ingredient(name: "flour", quantity: 200, unit: "g"),
                Ingredient(name: "baking powder", quantity: 10, unit: "g"),
                Ingredient(name: "milk", quantity: 12.5, unit: "cl")
            ],
            directions: "Mélanger le sucre et le beurre..."
        ),
        Recipe(
            name: "Chocolate Cake",
            prepTimeMinutes: 15,
            cookTimeMinutes: 25,
            servings: 8,
            ingredients: [
                Ingredient(name: "chocolate", quantity: 200, unit: "g"),
                Ingredient(name: "sugar", quantity: 200, unit: "g"),
                Ingredient(name: "butter", quantity: 125, unit: "g"),
                Ingredient(name: "eggs", quantity: 4, unit: ""),
                Ingredient(name: "flour", quantity: 125, unit: "g"),
                Ingredient(name: "baking powder", quantity: 5, unit: "g")
            ],
            directions: "Faire fondre le chocolat..."
        ),
        Recipe(
            name: "Clafoutis",
            prepTimeMinutes: 15,
            cookTimeMinutes: 35,
            servings: 8,
            ingredients: [
                Ingredient(name: "pear", quantity: 6, unit: ""),
                Ingredient(name: "sugar", quantity: 180, unit: "g"),
                Ingredient(name: "eggs", quantity: 6, unit: ""),
                Ingredient(name: "flour", quantity: 125, unit: "g"),
                Ingredient(name: "liquid cream", quantity: 50, unit: "cl"),
                Ingredient(name: "milk", quantity: 25, unit: "cl"),
                Ingredient(name: "butter", quantity: 10, unit: "g")
            ],
            directions: "Disposer les poires..."
        )
    ]
    
    // Fonction requise par le protocole pour propager les changements locaux
    func updateRecipe(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
            // L'ajout ou la suppression dans EditRecipeView appelle cette fonction.
        }
    }
    
    // NOTE : La fonction removeIngredient est retirée car non requise par le protocole
    // et sa logique est maintenant implémentée directement via .onDelete.
    func removeIngredient(recipe: Recipe, ingredient: Ingredient) {
        // Cette fonction n'est plus utilisée, mais est maintenue vide
        // si elle est requise par le protocole (selon la version de ton protocole).
        // Si tu as un protocole à jour, elle devrait être retirée.
    }
}

// MARK: - L'Injecteur

class Injector {
    // Fournit l'instance unique du repository
    static let recipeRepository = RecipeRepositoryDummyImpl()
}
