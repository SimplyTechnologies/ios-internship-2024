//
//  ProfileViewModeling.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation

protocol EditAccountViewModeling: ObservableObject {
  
  var id: UUID { get }

  var isLoading: Bool { get set }
  
  var editAccountModel: EditAccountModel { get set }
  var profileModel: ProfileModel { get set }
  
  var name: String { get set }
  var surname: String { get set }
  
  var isNameFocused: Bool { get set }
  var isSurnameFocused: Bool { get set }

  func updateProfileData(model: EditAccountModel, completion: @escaping () -> Void)

}
