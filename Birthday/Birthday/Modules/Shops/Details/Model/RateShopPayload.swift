//
//  RateShopPayload.swift
//  Birthday
//
//  Created by Anna Hakobyan on 04.11.24.
//

import Foundation
import Combine

struct RateShopPayload: Codable {

  var rating: Int
  let shopId: Int

  init(rating: Int, shopId: Int) {
    self.rating = rating
    self.shopId = shopId
  }

}
