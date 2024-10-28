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
  var firstName: String
  let id: Int?
  var image: String?
  var lastName: String
  var fullname: String? {
    firstName + " " + lastName
  }

  init(
    email: String? = nil,
    firstName: String,
    id: Int? = nil,
    image: String? = nil,
    lastName: String
  ) {
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
