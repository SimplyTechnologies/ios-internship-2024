//
//  CreateBirthdayViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 26.10.24.
//

import Foundation
import PhotosUI
import SwiftUI

protocol CreateBirthdayViewModeling: Toastable {
  
  var isLoading: Bool { get set }
  var isContentValid: Bool { get set }
  var birthday: BirthdayModel { get set }
  var selectedImage: UIImage? { get set }
  var isPickerPresented: Bool { get set }
  var isShowPickerOptions: Bool { get set }
  var selectedSourceType: UIImagePickerController.SourceType { get set }

  func createBirthday()
  func resetScreen()
  
}
