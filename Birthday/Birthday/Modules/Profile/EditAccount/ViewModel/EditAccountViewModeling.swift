//
//  ProfileViewModeling.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import SwiftUI
import PhotosUI

protocol EditAccountViewModeling: Toastable {

  var id: UUID { get }
  var isLoading: Bool { get set }
  var editAccountModel: EditAccountModel { get set }
  var profileModel: ProfileModel { get set }
  var isNameFocused: Bool { get set }
  var isSurnameFocused: Bool { get set }
  var selectedPickerItem: PhotosPickerItem? { get set }
  var selectedImage: UIImage? { get set }
  var isDisabled: Bool { get }

  func updateProfileData(completion: @escaping () -> Void)
  func convertImage(image: PhotosPickerItem?) async

}
