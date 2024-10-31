//
//  BirthdayModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation
import BirthDayAPI

struct BirthdayModel: Eventable {
  
  private let createdAt: String?
  var  date: String?
  let id: Int?
  var image: String?
  var message, name: String?
  var relation: Relationship?
  private let upcomingAge: Int?
  private let upcomingBirthday, updatedAt: String?
  private let userId: Int?
  
  init(
    createdAt: String?,
    date: String?,
    id: Int?,
    image: String?, 
    message: String?,
    name: String?,
    relation: Relationship?,
    upcomingAge: Int?,
    upcomingBirthday: String?,
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
    self.relation = Relationship(rawValue: dto.relation)
    self.upcomingAge = dto.upcomingAge
    self.upcomingBirthday = dto.upcomingBirthday
    self.updatedAt = dto.updatedAt
    self.userId = dto.userId
  }
  
  init(createBirthdayDTO: CreateBirthdayMutation.Data.CreateBirthday) {
    id = createBirthdayDTO.id
    image = createBirthdayDTO.image
    date = createBirthdayDTO.date
    name = createBirthdayDTO.name
    message = createBirthdayDTO.message
    relation = Relationship(rawValue: createBirthdayDTO.relation)
    upcomingAge = nil
    upcomingBirthday = nil
    updatedAt = nil
    userId = nil
    createdAt = nil
  }
  
  init() {
    createdAt = nil
    date = nil
    id = nil
    image = nil
    message = nil
    name = nil
    relation = nil
    upcomingAge = nil
    upcomingBirthday = nil
    updatedAt = nil
    userId = nil
  }
  
}
