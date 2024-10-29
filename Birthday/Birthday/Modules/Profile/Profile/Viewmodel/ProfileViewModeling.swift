//
//  ProfileViewModeling.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation

protocol ProfileViewModeling: ObservableObject {

  var isLoading: Bool { get set }
  var profileData: ProfileModel { get set }

  func getProfileData()

}
