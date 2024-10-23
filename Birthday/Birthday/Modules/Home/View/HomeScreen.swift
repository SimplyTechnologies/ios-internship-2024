//
//  HomeView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct HomeScreen<T: HomeViewModeling>: View {
  
  @ObservedObject var viewModel: T
  
  var body: some View {
    content
      .onLoad {
        viewModel.getBirthDays()
      }
  }
  
}

extension HomeScreen {
  
  private var content: some View {
    VStack {
      image
      list
    }
    .background(Color.lightPink)
  }
  
  private var list: some View {
    ScrollView {
      LazyVStack(spacing: 18) {
        ForEach(viewModel.birthdayData, id: \.id) { birthday in
          BirthDayCell(model: birthday)
        }
      }
    }
    .padding(.horizontal, 24)
    .scrollIndicators(.hidden)
  }
  
  private var image: some View {
    Image(.birth)
  }
  
}
