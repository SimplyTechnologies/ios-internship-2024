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
      searchBar
        .padding(.top, 22)
        .padding(.horizontal, 24)
      list
        .padding(.top, 10)
    }
    .background(Color.lightPink)
  }
  
  private var list: some View {
    VStack(spacing: 0) {
      if viewModel.isLoading {
        skeletonListView
      } else {
        if viewModel.filteredShops.isEmpty {
          noSearchResultView
        } else {
          ScrollView {
            PullToRefresh(coordinateSpaceName: "pull") {
              viewModel.getShops()
            }
            .padding(.bottom, 10)
            LazyVStack(spacing: 18) {
              ForEach($viewModel.filteredShops, id: \.id) { $shop in
                Button {
                  navigateToDetails(by: shop)
                } label: {
                  ShopCell(model: $shop, isLoading: shop.isLoading) {
                    viewModel.toggleFavorite(shop: shop)
                  }
                }
                .buttonStyle(PressedButtonStyle())
                .disabled(shop.isLoading)
              }
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
          }
          .scrollIndicators(.hidden)
          .coordinateSpace(name: "pull")
        }
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

      Text(String.Field.searchNoResultTitle)
        .foregroundStyle(Color.black)
        .karmaFont(style: .bold26)
        .multilineTextAlignment(.center)
        .padding(.top, 12)
      
      Text(String.Field.searchNoResultDescription)
        .foregroundStyle(Color.spanishGray)
        .karmaFont(style: .regular14)
        .multilineTextAlignment(.center)
        .padding(.top, 12)

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
      .padding(.top, 16)
    }
    .scrollIndicators(.hidden)
  }
  
  private func navigateToDetails(by shop: Shop) {
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
