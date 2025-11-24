import SwiftUI

struct RecipeListView: View {
    // Injection de la source de vérité via Injector
    @StateObject var repository = Injector.recipeRepository
    
    var body: some View {
        NavigationStack {
            List(repository.recipes) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                    HStack(spacing: 12) {
                        Image(systemName: "fork.knife.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.orange)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(recipe.name)
                                .font(.headline)
                            
                            HStack {
                                Text(recipe.prepTimeString)
                                Text("•")
                                Text(recipe.cookTimeString)
                            }
                            .font(.caption)
                            .foregroundColor(.gray)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Recipes")
        }
    }
}

#Preview {
    RecipeListView()
}
