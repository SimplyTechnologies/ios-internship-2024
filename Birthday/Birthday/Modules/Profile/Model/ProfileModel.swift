//
//  ProfileModel.swift
//  Birthday
//
//  Created by Anna Hakobyan on 23.10.24.
//

import Foundation
import BirthDayAPI

struct ProfileModel: Codable {

  let email: String?
  let firstName: String?
  let id: Int?
  let image: String?
  let lastName: String?
  var fullname: String? {
    "\(firstName ?? "") \(lastName ?? "")"
  }

  init(email: String?, firstName: String?, id: Int?, image: String?, lastName: String?) {
    self.email = email
    self.firstName = firstName
    self.id = id
    self.image = image
    self.lastName = lastName
  }

  init(dto: GetProfileQuery.Data.Profile) {
    self.email = dto.email
    self.firstName = dto.firstName
    self.id = dto.id
    self.image = dto.image
    self.lastName = dto.lastName
  }

}
