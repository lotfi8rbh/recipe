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
