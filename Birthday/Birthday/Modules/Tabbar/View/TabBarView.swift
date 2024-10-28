//
//  TabBarView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabBarView: View {
  
  @StateObject private var homeRouter = NavigationRouter()
  @StateObject private var shopRouter = NavigationRouter()
  
  @State var selectedTab: TabModel = .home
  
  init() {
    customiseTabBar()
  }
  
  var body: some View {
    tabBar
  }
  
}

extension TabBarView {
  
  private var tabBar: some View {
    TabView(selection: $selectedTab) {
      homeTab
      shopsTab
      addTab
      profileTab
    }
  }
  
  private var homeTab: some View {
    NavigationStack(path: $homeRouter.path) {
      HomeScreen(
        viewModel: HomeViewModel(
          homeRepository: HomeDefaultRepository()
        )
      )
      .navigationDestination(for: HomeScreens.self) { screen in
        switch screen {
        case .details(let viewModel, let birthday):
          BirthdayDetailsScreen(viewModel: viewModel, birthdayData: birthday)
        }
      }
    }
    .environmentObject(homeRouter)
    .tabItem { TabCellView(model: .home) }
    .tag(TabModel.home)
  }
  
  private var shopsTab: some View {
    NavigationStack(path: $shopRouter.path) {
      ShopScreen(
        viewModel: ShopViewModel(
          shopRepository: ShopDefaultRepository()
        )
      )
      .navigationDestination(for: ShopScreens.self) { screen in
        switch screen {
        case .details(let viewModel):
          ShopDetailsScreen(viewModel: viewModel)
        }
      }
    }
    .environmentObject(shopRouter)
    .tabItem { TabCellView(model: .shops) }
    .tag(TabModel.shops)
  }
  
  private var addTab: some View {
    NavigationStack {
      AddBirthdayScreen(
        viewModel: CreateBirthdayViewModel(
          newBirthdayRepository: NewBirthdayDefaultRepository()
        )
      )
    }
    .tabItem { TabCellView(model: .addBirthday) }
    .tag(TabModel.addBirthday)
  }
  
  private var profileTab: some View {
    NavigationStack {
      ProfileScreen()
    }
    .tabItem { TabCellView(model: .profile) }
    .tag(TabModel.profile)
  }
  
  private func customiseTabBar() {
    let appearance = UITabBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = UIColor.bubblegumPink
    
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.rouge
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightPink
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
}

extension TabBarView {
  
  enum HomeScreens: Hashable {
    
    case details(viewModel:  BirthdayDetailsViewModel, birthday: BirthdayModel)
    
    var id: Int {
      switch self {
      case .details: 1
      }
    }
    
    static func == (lhs: TabBarView.HomeScreens, rhs: TabBarView.HomeScreens) -> Bool {
      return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(self.id)
    }
    
  }
  
}

extension TabBarView {
  
  enum ShopScreens: Hashable {
    
    case details(viewModel: ShopDetailsViewModel)
    
    var id: UUID {
      switch self {
      case let .details(viewModel): viewModel.id
      }
    }
    
    static func == (lhs: TabBarView.ShopScreens, rhs: TabBarView.ShopScreens) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      switch self {
      case let .details(viewModel):
        hasher.combine(viewModel.id)
      }
    }
    
  }
  
}

#Preview {
  TabBarView()
}
