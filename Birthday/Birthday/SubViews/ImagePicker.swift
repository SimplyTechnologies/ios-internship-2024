//
//  ImagePicker.swift
//  Birthday
//
//  Created by Narek on 05.11.24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
  
  @Binding var image: UIImage?
  @Binding var isPickerPresented: Bool
  
  var allowsEditing: Bool = true
  var sourceType: UIImagePickerController.SourceType = .photoLibrary

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  func makeUIViewController(context: Context) -> UIViewController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    picker.allowsEditing = allowsEditing
    picker.sourceType = sourceType
    picker.mediaTypes = ["public.image"]
    return picker
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    let parent: ImagePicker

    init(_ parent: ImagePicker) {
      self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      picker.dismiss(animated: true)
      parent.isPickerPresented = false

      if let editedImage = info[.editedImage] as? UIImage {
        parent.image = editedImage
      } else if let originalImage = info[.originalImage] as? UIImage {
        parent.image = originalImage
      }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      picker.dismiss(animated: true)
      parent.isPickerPresented = false
    }
    
  }
  
}
