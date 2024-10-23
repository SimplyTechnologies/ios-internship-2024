//
//  BirthdayModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import BirthDayAPI

struct BirthdayModel {
  
  let createdAt, date: String?
  let id: Int?
  let image: String?
  let message, name, relation: String?
  let upcomingAge: Int?
  let upcomingBirthday, updatedAt: String?
  let userId: Int?
  
  init(
    createdAt: String?,
    date: String?,
    id: Int?,
    image: String?, 
    message: String?,
    name: String?,
    relation: String?,
    upcomingAge: Int?, upcomingBirthday: String?,
    updatedAt: String?,
    userId: Int?
    ) {
    self.createdAt = createdAt
    self.date = date
    self.id = id
    self.image = image
    self.message = message
    self.name = name
    self.relation = relation
    self.upcomingAge = upcomingAge
    self.upcomingBirthday = upcomingBirthday
    self.updatedAt = updatedAt
    self.userId = userId
  }
  
  init(dto: GetBirthDayListQuery.Data.Birthday) {
    self.createdAt = dto.createdAt
    self.date = dto.date
    self.id = dto.id
    self.image = dto.image
    self.message = dto.message
    self.name = dto.name
    self.relation = dto.relation
    self.upcomingAge = dto.upcomingAge
    self.upcomingBirthday = dto.upcomingBirthday
    self.updatedAt = dto.updatedAt
    self.userId = dto.userId
  }
  
}
