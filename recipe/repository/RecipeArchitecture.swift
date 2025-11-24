import Foundation
import Combine

// 1. Le Protocole (Interface)
// Définit le contrat que doit respecter le repository
protocol RecipeRepository: ObservableObject {
    var recipes: [Recipe] { get }
}

// 2. Extension pour conformité
extension RecipeRepositoryDummyImpl: RecipeRepository {}

// 3. L'Injecteur (Singleton)
// Point d'accès unique aux données pour toute l'application
class Injector {
    // On instancie la classe que tu as définie dans Recipe.swift
    static let recipeRepository: RecipeRepositoryDummyImpl = RecipeRepositoryDummyImpl()
}
