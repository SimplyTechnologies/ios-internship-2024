//
//  BirthDayDetailsViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation
import PhotosUI
import SwiftUI

protocol BirthDayDetailsViewModeling: Toastable {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var deleteAction: () -> () { get set }
  var updateAction: (BirthdayModel) -> () { get set }
  var birthdayData: BirthdayModel { get set }
  var selectedImage: UIImage? { get set }
  var isEditing: Bool { get set }
  var isGeneratingMessage: Bool { get set }
  var isDeleting: Bool { get set }
  var isPickerPresented: Bool { get set }
  var isShowPickerOptions: Bool { get set }
  var selectedSourceType: UIImagePickerController.SourceType { get set }
  
  func updateBirthday()
  func deleteBirthDay(id: Int, completion: @escaping (Error?) -> ())
  var birthdayCopy: BirthdayModel { get set }
  var isDoneActive: Bool { get set }
  func cancelEdit()
  
}
