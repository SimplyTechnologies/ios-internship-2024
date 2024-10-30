//
//  TabBarView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabBarView: View {
  
  @StateObject private var homeRouter = NavigationRouter("Home")
  @StateObject private var shopRouter = NavigationRouter("Shop")
  @StateObject private var profileRouter = NavigationRouter("Profile")
  
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
        viewModel:
          HomeViewModel(
            homeRepository: HomeDefaultRepository()
          )
      )
      .navigationDestination(for: HomeScreens.self) { screen in
        switch screen {
        case .details(let viewModel, _):
          BirthdayDetailsScreen(viewModel: viewModel)
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
    NavigationStack(path: $profileRouter.path) {
      ProfileScreen(viewModel: ProfileViewModel(profileRepository: ProfileDefaultRepository()))
        .navigationDestination(for: ProfileScreens.self) { screen in
          switch screen {
          case let .editProfile(viewModel: viewModel, profileModel, doneAction):
            EditAccountScreen<EditAccountViewModel>(
              viewModel: viewModel,
              model: profileModel) {
                doneAction()
              }
          case .changePassword: Text("Change password")
          }
        }
    }
    .environmentObject(profileRouter)
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
    
    case details(viewModel: BirthdayDetailsViewModel, birthday: BirthdayModel)
    
    var id: UUID {
      switch self {
      case let .details(viewModel, _): viewModel.id
      }
    }
    
    static func == (lhs: TabBarView.HomeScreens, rhs: TabBarView.HomeScreens) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      switch self {
      case let .details(viewModel, _):
        hasher.combine(viewModel.id)
      }
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

extension TabBarView {
  
  enum ProfileScreens: Hashable {
    
    case editProfile(viewModel: EditAccountViewModel, profileModel: ProfileModel, doneAction: () -> Void)
    case changePassword(viewModel: ChangePasswordViewModel)
    
    var id: UUID {
      switch self {
      case let .editProfile(viewModel, _, _): viewModel.id
      case let .changePassword(viewModel): viewModel.id
      }
    }
    
    static func == (lhs: TabBarView.ProfileScreens, rhs: TabBarView.ProfileScreens) -> Bool {
      lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      switch self {
      case let .editProfile(viewModel, _, _):
        hasher.combine(viewModel.id)
      case let .changePassword(viewModel):
        hasher.combine(viewModel.id)
      }
    }
    
  }
  
}

#Preview {
  TabBarView()
}
