import Foundation

// MARK: - Modèles de données

struct Ingredient: Identifiable {
    let id = UUID() // Généré automatiquement, on ne le passe pas en paramètre
    var name: String
    var quantity: Double
    var unit: String
}

struct Recipe: Identifiable {
    let id = UUID() // Généré automatiquement
    var name: String
    var prepTimeMinutes: Int
    var cookTimeMinutes: Int
    var servings: Int
    var ingredients: [Ingredient]
    var directions: String
    
    // Propriétés calculées pour l'affichage facile
    var prepTimeString: String { "prep \(prepTimeMinutes) mins" }
    var cookTimeString: String { "cook \(cookTimeMinutes) mins" }
}

// MARK: - Implémentation Dummy (Données en dur)

// Note : On utilise une 'class' ici pour qu'elle puisse être partagée par référence
class RecipeRepositoryDummyImpl: ObservableObject {
    
    @Published var recipes: [Recipe] = [
        Recipe(
            name: "Simple Cake",
            prepTimeMinutes: 10,
            cookTimeMinutes: 30,
            servings: 12,
            ingredients: [
                Ingredient(name: "sugar", quantity: 200, unit: "g"),
                Ingredient(name: "butter", quantity: 125, unit: "g"),
                Ingredient(name: "eggs", quantity: 2, unit: ""), // Attention au type ici (Double implicite ou Int converti)
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
}	
