//
//  CreateBirthdayViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 26.10.24.
//

import Foundation
import _PhotosUI_SwiftUI

protocol CreateBirthdayViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  var isContentValid: Bool { get set }
  var birthday: BirthdayModel { get set }
  var selectedImage: UIImage? { get set }
  var selectedItem: PhotosPickerItem? { get set }
  
  func createBirthday()
  func convertImage(image: PhotosPickerItem?) async
  func resetScreen()
  
}
