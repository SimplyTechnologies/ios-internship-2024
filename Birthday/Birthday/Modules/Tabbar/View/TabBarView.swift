//
//  TabBarView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabBarView: View {
  
  @State var selectedTab: TabModel = .home
  
  @StateObject var router = NavigationRouter()
  
  enum HomeScreens: Hashable {
    
    var id: Int {
      switch self {
      case .details(let viewmodel, let birthday):
        return 1
      }
    }

    case details(viewmodel:  BirthdayDetailsViewModel, birthday: BirthdayModel)
    
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
      HomeScreen(viewModel: HomeViewModel(homeRepository: HomeDefaultRepository(), router: router))
        .navigationDestination(for: HomeScreens.self) { screen in
          switch screen {
          case .details(let viewmodel, let birthday):
            BirthdayDetailsScreen(viewModel: viewmodel, birthdayData: birthday)
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
