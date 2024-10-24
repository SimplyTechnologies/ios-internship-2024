//
//  TabBarView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabBarView: View {
  
  @State var selectedTab: TabModel = .home
  
  @ObservedObject var router = NavigationRouter()
  
  enum HomeScreens: Hashable {
    
    case details(viewmodel:  BirthdayDetailsViewModel, birthday: BirthdayModel)
    
    var id: Int {
      switch self {
      case .details:
        return 1
      }
    }
    
    static func == (lhs: TabBarView.HomeScreens, rhs: TabBarView.HomeScreens) -> Bool {
      return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
      hasher.combine(self.id)
    }
    
  }
  
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
    NavigationStack(path: $router.path) {
      HomeScreen(viewModel: HomeViewModel(homeRepository: HomeDefaultRepository()))
        .environmentObject(router)
        .navigationDestination(for: HomeScreens.self) { screen in
          switch screen {
          case .details(let viewmodel, let birthday):
            BirthdayDetailsScreen(viewModel: viewmodel, birthdayData: birthday)
              .environmentObject(router)
          }
        }
    }
    .tabItem { TabCellView(model: .home) }
    .tag(TabModel.home)
  }
  
  private var shopsTab: some View {
    NavigationStack {
      ShopsScreen()
    }
    .tabItem { TabCellView(model: .shops) }
    .tag(TabModel.shops)
  }
  
  private var addTab: some View {
    NavigationStack {
      AddBirthdayScreen()
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
    appearance.backgroundColor = UIColor.mainPink
    
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.rouge
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightPink
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
}

#Preview {
  TabBarView()
}
