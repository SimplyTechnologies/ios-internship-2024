//
//  User.swift
//  Birthday
//
//  Created by Narek on 23.10.24.
//

import Foundation
import BirthDayAPI

struct User {
  
  let id: Int?
  let image: String?
  let firstName: String?
  let lastName: String?
  let email: String?
  
  init(id: Int?, image: String?, firstName: String?, lastName: String?, email: String?) {
    self.id = id
    self.image = image
    self.firstName = firstName
    self.lastName = lastName
    self.email = email
  }
  
  init(dto: SignUpMutation.Data.SignUp) {
    self.id = dto.id
    self.image = dto.image
    self.firstName = dto.firstName
    self.lastName = dto.lastName
    self.email = dto.email
  }
  
}
