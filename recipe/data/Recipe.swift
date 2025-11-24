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

// MARK: - Protocole et Implémentation du Repository

protocol RecipeRepository: ObservableObject {
    var recipes: [Recipe] { get }
    func updateRecipe(recipe: Recipe)
    func removeIngredient(recipe: Recipe, ingredient: Ingredient)
}

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
    
    func updateRecipe(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
        }
    }
    
    func removeIngredient(recipe: Recipe, ingredient: Ingredient) {
        if let recipeIndex = recipes.firstIndex(where: { $0.id == recipe.id }),
           let ingredientIndex = recipes[recipeIndex].ingredients.firstIndex(where: { $0.id == ingredient.id }) {
            
            recipes[recipeIndex].ingredients.remove(at: ingredientIndex)
        }
    }
}

// MARK: - L'Injecteur

class Injector {
    static let recipeRepository = RecipeRepositoryDummyImpl()
}
