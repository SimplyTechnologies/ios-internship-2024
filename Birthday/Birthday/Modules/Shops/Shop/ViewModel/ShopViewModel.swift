//
//  ShopViewModel.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import Combine
import SwiftUI

final class ShopViewModel: ShopViewModeling {
  
  @Published var isLoading: Bool = false
  @Published var shops: [Shop] = []
  @Published var filteredShops: [Shop] = []
  @Published var isFocused: Bool = false
  @Published var searchText: String = ""
  
  private let shopRepository: ShopRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(shopRepository: ShopRepository) {
    self.shopRepository = shopRepository
    
    $searchText
      .sink { [weak self] searchText in
        guard let self else { return }
        guard !searchText.isEmpty else {
          filteredShops = shops
          return
        }
        filteredShops = shops.filter { ($0.name ?? "").lowercased().contains(searchText.lowercased()) }
      }
      .store(in: &cancellables)
  }
  
  func getShops() {
    isLoading = true
    shopRepository.getShops()
      .sink { [weak self] result in
        self?.isLoading = false
        switch result {
        case .failure(let error):
          print(error)
        default: break
        }
      } receiveValue: { [weak self] shops in
        shops.forEach {
          self?.shops.append(Shop(dto: $0))
        }
        self?.filteredShops = self?.shops ?? []
      }
      .store(in: &cancellables)
  }
  
}
