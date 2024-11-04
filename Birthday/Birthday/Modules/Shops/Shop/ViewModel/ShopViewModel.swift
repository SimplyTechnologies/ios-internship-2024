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
  
  let id: UUID = UUID()
  
  private let shopRepository: ShopRepository
  private var cancellables = Set<AnyCancellable>()
  
  init(shopRepository: ShopRepository) {
    self.shopRepository = shopRepository
    
    $shops
      .sink { [weak self] shops in
        guard let self else { return }
        filterShops(searchText: searchText, shops: shops)
      }
      .store(in: &cancellables)
    
    $searchText
      .sink { [weak self] searchText in
        guard let self else { return }
        filterShops(searchText: searchText, shops: shops)
      }
      .store(in: &cancellables)
  }
  
  func getShops() {
    withAnimation {
      isLoading = true
    }
    shopRepository.getShops()
      .sink { [weak self] result in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
          withAnimation {
            self?.isLoading = false
          }
        }
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
        default: break
        }
      } receiveValue: { [weak self] shopsData in
        guard let self else { return }
        var shops: [Shop] = []
        shopsData.forEach {
          shops.append(Shop(dto: $0))
        }
        self.shops = shops
      }
      .store(in: &cancellables)
  }
  
  func toggleFavorite(shop: Shop) {
    if shop.isFavorite ?? false {
      removeFromFavorite(shopId: shop.id ?? 0)
    } else {
      addToFavorite(shopId: shop.id ?? 0)
    }
  }

  
  private func filterShops(searchText: String, shops: [Shop]) {
    guard !searchText.isEmpty else {
      filteredShops = shops
      return
    }
    filteredShops = shops.filter { ($0.name ?? "").lowercased().contains(searchText.lowercased()) }
  }
  
  private func addToFavorite(shopId: Int) {
    guard let index = filteredShops.firstIndex(where: { $0.id == shopId }) else {
      return
    }
    filteredShops[index].isLoading = true
    
    shopRepository.addToFavorite(shopId)
      .sink { [weak self] result in
        guard let self else { return }
        filteredShops[index].isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
        default: break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        if shopId == data.addShopToFavorite.shopId {
          filteredShops[index].isFavorite = true
        }
      }
      .store(in: &cancellables)
  }
  
  private func removeFromFavorite(shopId: Int) {
    guard let index = filteredShops.firstIndex(where: { $0.id == shopId }) else {
      return
    }
    filteredShops[index].isLoading = true
    
    shopRepository.removeFromFavorites(shopId)
      .sink { [weak self] result in
        guard let self else { return }
        filteredShops[index].isLoading = false
        switch result {
        case .failure(let error):
          Console.log("❌ Error: ", error)
        default: break
        }
      } receiveValue: { [weak self] data in
        guard let self else { return }
        if shopId == data.removeShopFromFavorite.shopId {
          filteredShops[index].isFavorite = false
        }
      }
      .store(in: &cancellables)
  }
  
}
