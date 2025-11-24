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
                
                ForEach($recipe.ingredients) { $ingredient in
                    HStack {
                        // Édition de la quantité
                        TextField("Quantité", value: $ingredient.quantity, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                        
                        // Nom de l'ingrédient (fixe le problème du 'wrappedValue')
                        VStack(alignment: .leading) {
                            TextField("Nom de l'ingrédient", text: $ingredient.name)
                            
                            TextField("Unité (ex: g, cl)", text: $ingredient.unit)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                }
                .onDelete { indices in
                    recipe.ingredients.remove(atOffsets: indices)
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
