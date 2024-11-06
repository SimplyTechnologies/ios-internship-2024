//
//  BirthdayModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import BirthDayAPI
import Foundation

struct BirthdayModel: Eventable, Equatable {
  
  private let createdAt: String?
  var date: String?
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
    createdAt = dto.createdAt
    date = dto.date
    id = dto.id
    image = dto.image
    message = dto.message
    name = dto.name
    relation = Relationship(rawValue: dto.relation)
    upcomingAge = dto.upcomingAge
    upcomingBirthday = dto.upcomingBirthday
    updatedAt = dto.updatedAt
    userId = dto.userId
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
    date = Date().toISO8601String
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
  
  static func == (lhs: BirthdayModel, rhs: BirthdayModel) -> Bool {
    lhs.image == rhs.image &&
    lhs.name == rhs.name &&
    lhs.message == rhs.message &&
    lhs.createdAt == rhs.createdAt &&
    lhs.id == rhs.id &&
    lhs.relation == rhs.relation &&
    lhs.upcomingAge == rhs.upcomingAge &&
    lhs.upcomingBirthday == rhs.upcomingBirthday &&
    lhs.userId == rhs.userId &&
    lhs.updatedAt == rhs.updatedAt &&
    lhs.date?.toFormattedDate() == rhs.date?.toFormattedDate()
  }
  
}

extension BirthdayModel {
  
  static let mock: BirthdayModel = .init(
    createdAt: "",
    date: "1999-11-03T09:54:33.000Z",
    id: 1,
    image: "https://randomuser.me/api/portraits/med/women/19.jpg",
    message: "Be Happy",
    name: "John",
    relation: .friend,
    upcomingAge: 12,
    upcomingBirthday: nil,
    updatedAt: nil,
    userId: 2
  )
  
}
