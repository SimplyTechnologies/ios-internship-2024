//
//  ShopDetailsViewModeling.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import Foundation

protocol ShopDetailsViewModeling: ObservableObject {
  
  var id: UUID { get }
  
  var isLoading: Bool { get set }
  
  var shop: Shop { get set }
  
}
