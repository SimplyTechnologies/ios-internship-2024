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
  
  let id: UUID = UUID()
  var rateComplition: (Shop) -> ()
  
  private let shopRepository: ShopRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(shopRepository: ShopRepository, shop: Shop, rateComplition: @escaping (Shop) -> ()) {
    self.shopRepository = shopRepository
    self.shop = shop
    self.rateComplition = rateComplition
  }
  
  func rateShop(payload: RateShopPayload) {
    isLoading = true
    isShowMessage = false
    shopRepository.rateShop(payload: payload)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .failure(let error):
            Console.log("❌ Error: ", error)
            self.showToast(message: error.localizedDescription, isSuccess: false)
          default: break
          }
        }, receiveValue: { [weak self] rateResult in
          guard let self else { return }
          let message = String(format: String.Toast.shopRate, "\(rateResult.shopCurrentRating)")
          showToast(message: message, isSuccess: true)
          var shop = self.shop
          shop.rate = rateResult.shopCurrentRating
          rateComplition(shop)
        }
      )
      .store(in: &cancellables)
  }
  
  func phoneCallAction() {
    guard let url = URL(string: "tel://\(shop.phone ?? "")"),
          UIApplication.shared.canOpenURL(url)
    else { return }
    UIApplication.shared.open(url)
  }
}
