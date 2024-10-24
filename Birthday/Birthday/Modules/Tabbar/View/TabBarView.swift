//
//  TabBarView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct TabBarView: View {
  
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
    NavigationStack {
      HomeScreen(viewModel: HomeViewModel(homeRepository: HomeDefaultRepository()))
    }
    .tabItem { TabCellView(model: .home) }
    .tag(TabModel.home)
  }
  
  private var shopsTab: some View {
    NavigationStack {
      ShopScreen(viewModel: ShopViewModel(shopRepository: ShopDefaultRepository()))
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
    appearance.backgroundColor = UIColor.bubblegumPink
    
    appearance.stackedLayoutAppearance.selected.iconColor = UIColor.rouge
    appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightPink
    
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
  }
  
}

#Preview {
  TabBarView()
}
