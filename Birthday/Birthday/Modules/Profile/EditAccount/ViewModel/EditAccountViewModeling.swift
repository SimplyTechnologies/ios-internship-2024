//
//  ProfileViewModeling.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation

protocol EditAccountViewModeling: ObservableObject {

  var isLoading: Bool { get set }
  var editAccountModel: EditAccountModel { get set }

  func updateProfileData(model: EditAccountModel)

}
