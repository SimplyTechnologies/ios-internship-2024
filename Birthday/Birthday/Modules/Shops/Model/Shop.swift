//
//  Shop.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import Foundation
import BirthDayAPI

struct Shop {
  
  let id: Int?
  let image: String?
  let address: String?
  var isFavorite: Bool?
  let name: String?
  let phone: String?
  let rate: Double?
  let url: String?
  
  init(
    id: Int?,
    image: String?,
    address: String?,
    isFavorite: Bool?,
    name: String?,
    phone: String?,
    rate: Double?,
    url: String?
  ) {
    self.id = id
    self.image = image
    self.address = address
    self.isFavorite = isFavorite
    self.name = name
    self.phone = phone
    self.rate = rate
    self.url = url
  }

  init(dto: GetShopsQuery.Data.Shop) {
    self.id = dto.id
    self.image = dto.image
    self.address = dto.address
    self.isFavorite = dto.isFavorite
    self.name = dto.name
    self.phone = dto.phone
    self.rate = dto.rate
    self.url = dto.url
  }
  
}
