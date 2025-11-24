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
                        TextField("Quantité", value: $ingredient.quantity, format: .number)
                            .keyboardType(.decimalPad)
                            .frame(width: 80)
                            .multilineTextAlignment(.trailing)
                        
                        Text($ingredient.name.wrappedValue.isEmpty ? "New Item" : $ingredient.name.wrappedValue)
                            .lineLimit(1)
                        
                        Spacer()
                        
                        Button(action: {
                            repository.removeIngredient(recipe: recipe, ingredient: $ingredient.wrappedValue)
                        }) {
                            Image(systemName: "trash.circle.fill")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .onDelete { indices in
                    if let recipeIndex = repository.recipes.firstIndex(where: { $0.id == recipe.id }) {
                        repository.recipes[recipeIndex].ingredients.remove(atOffsets: indices)
                    }
                }
                
                Button("Add ingredient") {
                    recipe.ingredients.append(Ingredient(name: "New Item", quantity: 1.0, unit: ""))
                }
            }
            
            // Section 3 : Instructions
            Section(header: Text("Instructions").font(.headline)) {
                TextEditor(text: $recipe.directions)
                    .frame(minHeight: 150)
            }
        }
        .navigationTitle("Edit: \(recipe.name)")
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
