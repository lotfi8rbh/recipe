import SwiftUI

struct EditRecipeView: View {
    @Binding var recipe: Recipe

    @StateObject var repository = Injector.recipeRepository
    
    @State private var sortByName = false
    
    var body: some View {
        Form {
            
            // Section 1 : Temps et Servings
            Section(header: Text("Durée et portions").font(.headline)) {
                TextField("Prep Time (mins)", value: $recipe.prepTimeMinutes, format: .number)
                    .keyboardType(.numberPad)
                TextField("Cook Time (mins)", value: $recipe.cookTimeMinutes, format: .number)
                    .keyboardType(.numberPad)
                TextField("Serving", value: $recipe.servings, format: .number)
                    .keyboardType(.numberPad)
            }

            // Section 2 : Ingrédients
            Section(header: ingredientsHeader) {
                
                // Calcul de la liste à afficher, triée ou non
                let sortedIngredients = sortByName
                    ? recipe.ingredients.sorted(by: { $0.name < $1.name })
                    : recipe.ingredients
                
                // On utilise les indices de la liste triée pour obtenir le Binding correct
                ForEach(sortedIngredients.indices, id: \.self) { index in
                    // Obtient l'index de la recette non triée (originale)
                    let ingredientIndex = recipe.ingredients.firstIndex(where: { $0.id == sortedIngredients[index].id })!
                    
                    // Crée le Binding vers l'élément original (pour la modification)
                    let ingredientBinding = $recipe.ingredients[ingredientIndex]
                    
                    HStack {
                        // Édition de la quantité
                        TextField("Quantité", value: ingredientBinding.quantity, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                        
                        // Nom de l'ingrédient (Champ modifiable)
                        VStack(alignment: .leading) {
                            TextField("Nom de l'ingrédient", text: ingredientBinding.name)
                            
                            TextField("Unité (ex: g, cl)", text: ingredientBinding.unit)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                }
                // Suppression par 'swipe' (onDelete)
                .onDelete { indices in
                    // Transforme les indices triés en indices réels à supprimer
                    let indicesToRemove = indices.map { sortedIngredients[$0] }.compactMap { ingredientToDelete in
                        recipe.ingredients.firstIndex(where: { $0.id == ingredientToDelete.id })
                    }
                    recipe.ingredients.remove(atOffsets: IndexSet(indicesToRemove))
                    repository.updateRecipe(recipe: recipe)
                }
                
                // Bouton d'ajout
                Button("Add ingredient") {
                    recipe.ingredients.append(Ingredient(name: "", quantity: 1.0, unit: ""))
                    repository.updateRecipe(recipe: recipe)
                }
            }
            
            // Section 3 : Instructions
            Section(header: Text("Instructions").font(.headline)) {
                TextEditor(text: $recipe.directions)
                    .frame(minHeight: 150)
            }
        }
        .navigationTitle("Edit: \(recipe.name)")
        .environment(\.editMode, .constant(.active))
    }
    
    // Helper pour gérer le Toggle de tri
    var ingredientsHeader: some View {
        HStack {
            Text("Ingredients")
            Spacer()
            Toggle("Sort by name", isOn: $sortByName)
                .labelsHidden()
        }
    }
}
