//
//  ShopDetailsScreen.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import BirthDayAPI
import SwiftUI

struct ShopDetailsScreen<T: ShopDetailsViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter
  @EnvironmentObject var appState: AppState

  var body: some View {
    content
      .onChange(of: viewModel.isShowMessage) { isShow in
        appState.isShowMessage = isShow
        if isShow {
          appState.isSuccessMessage = viewModel.isSuccessMessage
          appState.message = viewModel.toastMessage
        }
      }
  }
  
}

extension ShopDetailsScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      NavigationBar {
        router.pop()
      }
      .padding(.top, 20)
      shopInfoView
    }
    .background(Color.lightPink)
    .navigationBarBackButtonHidden(true)
  }
  
  private var shopInfoView: some View {
    GeometryReader { geo in
      ScrollView {
        VStack(spacing: 0) {
          Spacer()
            .frame(height: 26)
          SkeletonImage(
            isCircular: false,
            imagePath: viewModel.shop.image ?? "",
            size: .init(width: geo.size.width, height: geo.size.width)
          )
          .clipShape(RoundedRectangle(cornerRadius: 16))
          shopName
            .padding(.top, 20)
          rate
            .padding(.top, 18)
          phone
            .padding(.top, 20)
          address
            .padding(.top, 10)
          webSite
            .padding(.top, 10)
            .padding(.bottom, 40)
          Spacer()
        }
      }
      .scrollIndicators(.hidden)
    }
    .padding(.horizontal, 24)
  }
  
  private var shopName: some View {
    Text(viewModel.shop.name ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold20)
  }
  
  private var rate: some View {
    RatingView(
      rating: $viewModel.shop.rate,
      action: {
        if let rate = viewModel.shop.rate, let id = viewModel.shop.id {
          viewModel.rateShop(payload: RateShopPayload(rating: Int(rate), shopId: id))
        }
      },
      model: viewModel.shop,
      isLoading: viewModel.isLoading
    )
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
          viewModel.phoneCallAction()
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
      shop: Shop.mockShop,
      rateComplition: { _ in }
    )
  )
  .environmentObject(AppState())
  .environmentObject(NavigationRouter(.shop))
}
