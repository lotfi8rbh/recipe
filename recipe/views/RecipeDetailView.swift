import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image (Placeholder)
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
                
                // Informations principales
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .bold()
                    
                    HStack {
                        Label("\(recipe.prepTimeMinutes) mins prep", systemImage: "clock")
                        Spacer()
                        Label("\(recipe.cookTimeMinutes) mins cook", systemImage: "flame")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Text("Serving: \(recipe.servings)")
                        .font(.headline)
                        .padding(.top, 4)
                }
                .padding(.horizontal)
                
                Divider()
                
                // Ingrédients
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.title2)
                        .bold()
                    
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Text("• " + ingredient.name)
                            Spacer()
                            Text("\(ingredient.quantity, specifier: "%.g") \(ingredient.unit)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.horizontal)
                
                Divider()
                
                // Instructions
                VStack(alignment: .leading, spacing: 10) {
                    Text("Directions")
                        .font(.title2)
                        .bold()
                    
                    Text(recipe.directions)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: EditRecipeView(recipe: $recipe)) {
                    Text("Edit recipe")
                }
            }
        }
    }
}
