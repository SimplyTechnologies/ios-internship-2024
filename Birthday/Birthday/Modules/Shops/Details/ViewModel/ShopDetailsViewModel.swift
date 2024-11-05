//
//  ShopDetailsViewModel.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import Combine
import SwiftUI
import BirthDayAPI

final class ShopDetailsViewModel: ShopDetailsViewModeling {

  
  
  @Published var isLoading: Bool = false
  @Published var shop: Shop
  @Published var toastMessage: String = ""
  @Published var isSuccessMessage: Bool = false
  @Published var isShowMessage: Bool = false

  var rateComplition: (Shop) -> ()
  var id: UUID
  
  private let shopRepository: ShopRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(shopRepository: ShopRepository, shop: Shop, rateComplition: @escaping (Shop) -> ()) {
    self.shopRepository = shopRepository
    self.shop = shop
    self.id = UUID()
    self.rateComplition = rateComplition
  }
  
  func rateShop(payload: RateShopPayload) {
    isLoading = true
    shopRepository.rateShop(payload: payload)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure(let error):
          Console.log("❌ Error: ", error)
          self.showToast(message: error.localizedDescription, isSuccess: false)
        default: break
        }
      }, receiveValue: { [weak self] success in
        guard let self else { return }
        if success {
          rateComplition(shop)
        }
        showToast(message: "Rating submitted successfully!⭐", isSuccess: true)
      })
      .store(in: &cancellables)
  }
  
}
