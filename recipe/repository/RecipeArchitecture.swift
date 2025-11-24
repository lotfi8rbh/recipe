import Foundation
import Combine
import SwiftUI

// MARK: - Protocole du Repository (Contrat)

protocol RecipeRepository: ObservableObject {
    var recipes: [Recipe] { get }
    func updateRecipe(recipe: Recipe)
}

// MARK: - Implémentation Dummy (Source de vérité)

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
        ),
        
        Recipe(
            name: "Pancakes",
            prepTimeMinutes: 5,
            cookTimeMinutes: 10,
            servings: 4,
            ingredients: [
                Ingredient(name: "flour", quantity: 250, unit: "g"),
                Ingredient(name: "milk", quantity: 30, unit: "cl"),
                Ingredient(name: "eggs", quantity: 2, unit: ""),
                Ingredient(name: "sugar", quantity: 30, unit: "g"),
                Ingredient(name: "baking powder", quantity: 5, unit: "g")
            ],
            directions: "Mélanger tous les ingrédients secs, puis ajouter le lait et les œufs. Cuire à la poêle."
        ),
        Recipe(
            name: "Beef Stroganoff",
            prepTimeMinutes: 20,
            cookTimeMinutes: 35,
            servings: 6,
            ingredients: [
                Ingredient(name: "beef", quantity: 500, unit: "g"),
                Ingredient(name: "mushrooms", quantity: 250, unit: "g"),
                Ingredient(name: "liquid cream", quantity: 20, unit: "cl"),
                Ingredient(name: "broth", quantity: 10, unit: "cl"),
                Ingredient(name: "onion", quantity: 1, unit: ""),
                Ingredient(name: "mustard", quantity: 1, unit: "tbsp")
            ],
            directions: "Faire revenir la viande et l'oignon, ajouter les champignons, puis la crème et la moutarde."
        ),
        Recipe(
            name: "Salade César",
            prepTimeMinutes: 15,
            cookTimeMinutes: 0,
            servings: 2,
            ingredients: [
                Ingredient(name: "lettuce", quantity: 1, unit: "head"),
                Ingredient(name: "chicken", quantity: 200, unit: "g"),
                Ingredient(name: "parmesan", quantity: 50, unit: "g"),
                Ingredient(name: "croutons", quantity: 100, unit: "g"),
                Ingredient(name: "sauce", quantity: 5, unit: "cl")
            ],
            directions: "Couper la laitue, cuire le poulet, mélanger avec les autres ingrédients et la sauce."
        ),
        Recipe(
            name: "Muffins aux Myrtilles",
            prepTimeMinutes: 15,
            cookTimeMinutes: 20,
            servings: 12,
            ingredients: [
                Ingredient(name: "flour", quantity: 300, unit: "g"),
                Ingredient(name: "sugar", quantity: 150, unit: "g"),
                Ingredient(name: "eggs", quantity: 2, unit: ""),
                Ingredient(name: "milk", quantity: 15, unit: "cl"),
                Ingredient(name: "butter", quantity: 100, unit: "g"),
                Ingredient(name: "blueberries", quantity: 150, unit: "g")
            ],
            directions: "Mélanger les ingrédients humides et secs séparément, puis combiner et ajouter les myrtilles. Cuire au four."
        )
    ]
    
    func updateRecipe(recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index] = recipe
        }
    }
}

// MARK: - L'Injecteur

class Injector {
    static let recipeRepository = RecipeRepositoryDummyImpl()
}
