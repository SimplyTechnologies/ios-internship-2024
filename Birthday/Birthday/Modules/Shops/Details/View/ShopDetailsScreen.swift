//
//  ShopDetailsScreen.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct ShopDetailsScreen<T: ShopDetailsViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter

  var body: some View {
    content
  }
  
}

extension ShopDetailsScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      NavigationBar {
        router.pop()
      }
      .padding(.top, 20)
      Spacer()
        .frame(height: 26)
      shopInfoView
      Spacer()
    }
    .background(Color.lightPink)
    .navigationBarBackButtonHidden(true)
  }
  
  private var shopInfoView: some View {
    VStack(spacing: 0) {
      image
      Spacer()
        .frame(height: 20)
      shopName
      Spacer()
        .frame(height: 18)
      rate
      Spacer()
        .frame(height: 20)
      phone
      Spacer()
        .frame(height: 10)
      address
      Spacer()
        .frame(height: 10)
      webSite
    }
    .padding(.horizontal, 24)
  }

  private var image: some View {
    CircularImage(
      imagePath: viewModel.shop.image ?? "",
      size: .init(width: 100, height: 100)
    )
  }
  
  private var shopName: some View {
    Text(viewModel.shop.name ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold20)
  }
  
  private var rate: some View {
    RatingView(rating: $viewModel.shop.rate)
  }
  
  private var phone: some View {
    HStack(spacing: 4) {
      Text(String.Shop.phone)
        .foregroundStyle(.black)
        .karmaFont(style: .bold20)
      
      Text(viewModel.shop.phone ?? "")
        .foregroundStyle(.black)
        .karmaFont(style: .bold20)
        .lineLimit(nil)
        .underline()
        .onTapGesture {
          UIApplication.shared.open(URL(string: "tel://\(viewModel.shop.phone ?? "")")!)
        }
    }
  }
  
  private var address: some View {
    HStack(alignment: .top, spacing: 4) {
      Text(String.Shop.address)
        .foregroundStyle(.black)
        .karmaFont(style: .bold20)
      
      Text(viewModel.shop.address ?? "")
        .foregroundStyle(.black)
        .karmaFont(style: .bold20)
        .lineLimit(nil)
        .underline()
    }
  }
  
  @ViewBuilder
  private var webSite: some View {
    if let url = URL(string: viewModel.shop.url ?? "") {
      Link(destination: url) {
        Text(String.Shop.website)
          .foregroundStyle(.black)
          .karmaFont(style: .bold16)
          .lineLimit(nil)
          .underline()
      }
    }
  }
  
}

#Preview {
  ShopDetailsScreen(
    viewModel: ShopDetailsViewModel(
      shopRepository: ShopDefaultRepository(),
      shop: Shop.mockShop
    )
  )
}
