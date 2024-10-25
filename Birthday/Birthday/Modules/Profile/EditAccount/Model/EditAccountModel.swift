//
//  EditAccountModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 24.10.24.
//

import Foundation
import Combine
import BirthDayAPI

struct EditAccountModel: Codable {
  
  var firstName: String
  var image: String
  var lastName: String
  
  init(firstName: String, image: String, lastName: String) {
    self.firstName = firstName
    self.image = image
    self.lastName = lastName
  }
  
  init(dto: UpdateProfileMutation.Data.UpdateProfile) {
    self.firstName = dto.firstName
    self.image = dto.image ?? ""
    self.lastName = dto.lastName
  }
}
