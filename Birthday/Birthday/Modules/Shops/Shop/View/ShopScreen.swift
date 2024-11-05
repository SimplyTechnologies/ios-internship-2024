//
//  ShopScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct ShopScreen<T: ShopViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter
  @EnvironmentObject var appState: AppState
  
  var body: some View {
    content
      .onLoad {
        viewModel.getShops()
      }
      .navigationBarBackButtonHidden(true)
  }
  
}

extension ShopScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      if router.path.count > 0 {
        NavigationBar {
          router.pop()
        }
        .padding(.top, 20)
      } else {
        Image(.birth)
          .padding(.top, 20)
      }
      Spacer()
        .frame(height: 22)
      searchBar
        .padding(.horizontal, 24)
      Spacer()
        .frame(height: 10)
      list
    }
    .background(Color.lightPink)
  }
  
  private var list: some View {
    VStack {
      if viewModel.isLoading {
        skeletonListView
      } else if viewModel.filteredShops.isEmpty {
        noSearchResultView
      } else {
        ScrollView {
          PullToRefresh(coordinateSpaceName: "pull") {
            viewModel.getShops()
          }
          Spacer().frame(height: 10)
          
          LazyVStack(spacing: 18) {
            ForEach(getDisplayedShops(), id: \.id) { shop in
              createShopCell(for: shop)
            }
          }
          .padding(.horizontal, 24)
          Spacer().frame(height: 10)
        }
        .scrollIndicators(.hidden)
        .coordinateSpace(name: "pull")
      }
    }
  }
  
  @ViewBuilder
  private func createShopCell(for shop: Shop) -> some View {
    ShopCell(model: .constant(shop), isLoading: shop.isLoading) {
      viewModel.toggleFavorite(shop: shop)
    }
    .onTapGesture {
      let shopDetailsViewModel = ShopDetailsViewModel(
        shopRepository: ShopDefaultRepository(),
        shop: shop
      )
      
      if router.type == .home {
        router.push(
          TabBarView.HomeScreens.shopDetails(
            viewModel: shopDetailsViewModel
          )
        )
      } else {
        router.push(
          TabBarView.ShopScreens.details(
            viewModel: shopDetailsViewModel
          )
        )
      }
    }
  }
  
  private var searchBar: some View {
    SearchBar(
      searchText: $viewModel.searchText,
      isFocused: $viewModel.isFocused
    )
  }
  
  private var noSearchResultView: some View {
    VStack(alignment: .center, spacing: 0) {
      Spacer()
      Image(systemName: "exclamationmark.magnifyingglass")
        .renderingMode(.template)
        .resizable()
        .frame(width: 42, height: 42)
        .foregroundStyle(.black)
      Spacer()
        .frame(height: 12)
      Text(String.Field.searchNoResultTitle)
        .foregroundStyle(Color.black)
        .karmaFont(style: .bold26)
        .multilineTextAlignment(.center)
      Spacer()
        .frame(height: 12)
      Text(String.Field.searchNoResultDescription)
        .foregroundStyle(Color.spanishGray)
        .karmaFont(style: .regular14)
        .multilineTextAlignment(.center)
      Spacer()
    }
    .padding(.horizontal, 24)
  }
  
  private var skeletonListView: some View {
    ScrollView {
      LazyVStack(spacing: 18) {
        ForEach(0 ..< 10, id: \.self) { _ in
          SkeletonView()
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(height: 110)
        }
      }
      .padding(.horizontal, 24)
    }
    .scrollIndicators(.hidden)
  }
  
  private func getDisplayedShops() -> [Shop] {
    let favoriteShops = viewModel.filteredShops.filter { $0.isFavorite == true }
    let otherShops = viewModel.filteredShops.filter { $0.isFavorite != true }
    
    return favoriteShops.isEmpty ? viewModel.filteredShops : favoriteShops + otherShops
  }

}
