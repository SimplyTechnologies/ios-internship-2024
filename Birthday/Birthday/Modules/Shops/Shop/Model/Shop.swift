//
//  Shop.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import BirthDayAPI
import Foundation

struct Shop: Hashable {
  
  let id: Int?
  let image: String?
  let address: String?
  var isFavorite: Bool?
  let name: String?
  let phone: String?
  var rate: Double?
  let url: String?
  
  var isLoading: Bool = false

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

extension Shop {
  
  static let mockShop = Shop(
    id: 1,
    image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh2iqPBVW415Fm46oaLkdPKSp21VFDpm3Aug&s",
    address: "8 Vahram Papazyan St, Yerevan 0012",
    isFavorite: false,
    name: "Rio Mall",
    phone: "(011) 281888",
    rate: 12,
    url: "https://riomall.am/public/"
  )
  
}
