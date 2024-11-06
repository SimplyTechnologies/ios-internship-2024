//
//  ShopDetailsViewModeling.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import Foundation
import BirthDayAPI

protocol ShopDetailsViewModeling: Toastable, ObservableObject {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var shop: Shop { get set }
  
  func phoneCallAction()
  func rateShop(payload: RateShopPayload)
  
}
