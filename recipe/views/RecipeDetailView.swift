import SwiftUI

struct RecipeDetailView: View {
    @State var recipe: Recipe
    
    // MARK: - Fonctionnalité Native : Image Picker
    
    @State private var showingImagePicker = false
    @State private var inputUIImage: UIImage?
    @State private var recipeImage: Image?   
    
    func loadImage() {
        guard let inputImage = inputUIImage else { return }
        recipeImage = Image(uiImage: inputImage)
    }
    
    // MARK: - Corps de la Vue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Image (Placeholder cliquable et dynamique)
                (recipeImage ?? Image(systemName: "photo"))
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .background(Color.gray.opacity(0.3)) // Fond si aucune image
                    .overlay(
                        Group {
                            if recipeImage == nil {
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            } else {
                                EmptyView()
                            }
                        }
                    )
                    .onTapGesture {
                        showingImagePicker = true
                    }
                
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
                            Text("\(ingredient.quantity, specifier: "%.0f") \(ingredient.unit)")
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
        // Déclenche le sélecteur d'image
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputUIImage)
        }
    }
}
