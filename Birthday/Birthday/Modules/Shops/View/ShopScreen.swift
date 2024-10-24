//
//  ShopScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct ShopScreen<T: ShopViewModeling>: View {
  
  @ObservedObject var viewModel: T

  var body: some View {
    content
      .onLoad {
        viewModel.getShops()
      }
  }
  
}

extension ShopScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      Image(.birth)
      Spacer().frame(height: 22)
      searchBar
        .padding(.horizontal, 24)
      Spacer().frame(height: 10)
      list
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
            Spacer().frame(height: 10)
            LazyVStack(spacing: 18) {
              ForEach($viewModel.filteredShops, id: \.id) { $shop in
                ShopCell(model: $shop)
              }
            }
            .padding(.horizontal, 24)
            Spacer().frame(height: 10)
          }
          .scrollIndicators(.hidden)
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
      Spacer().frame(height: 12)
      Text(String.Field.searchNoResultTitle)
        .foregroundStyle(Color.black)
        .karmaFont(style: .bold26)
        .multilineTextAlignment(.center)
      Spacer().frame(height: 12)
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
      LazyVStack(spacing: 8) {
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
  
}
