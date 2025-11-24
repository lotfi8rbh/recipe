import SwiftUI
import UIKit // Nécessaire pour accéder à UIImagePickerController

// 1. Structure qui représente le contrôleur de vue UIKit dans l'environnement SwiftUI
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage? // Le UIImage qui sera sélectionné par l'utilisateur
    @Environment(\.dismiss) var dismiss // Permet de fermer l'écran après la sélection
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator // Utilise notre Coordinator pour gérer les événements
        // Vous pouvez ajouter ici: picker.sourceType = .camera pour forcer la caméra
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // La mise à jour est généralement vide ici
    }
    
    // 2. Coordinator: Gère les événements (sélection/annulation) de UIImagePickerController
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        // Méthode appelée lorsque l'utilisateur sélectionne une image
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            
            // Récupère l'image originale ou l'image éditée
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            
            parent.dismiss() // Ferme le sélecteur
        }
        
        // Méthode appelée si l'utilisateur annule la sélection
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss() // Ferme le sélecteur
        }
    }
}
