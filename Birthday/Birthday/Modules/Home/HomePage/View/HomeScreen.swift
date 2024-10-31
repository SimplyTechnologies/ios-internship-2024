//
//  HomeView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct HomeScreen<T: HomeViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var router: NavigationRouter
  
  @State var isEmpty: Bool = false
  
  var body: some View {
    content
      .onAppear {
        viewModel.getBirthDays()
      }
  }
  
}

extension HomeScreen {
  
  private var emptyState: some View {
    VStack(spacing: 10) {
      Image(.bunny)
        .resizable()
        .frame(width: 150, height: 150)
        .aspectRatio(contentMode: .fit)
      HStack {
        Spacer()
        Text(String.Birthday.emptyStateMessage)
          .multilineTextAlignment(.leading)
          .foregroundStyle(.rouge)
          .karmaFont(style: .bold18)
        Spacer()
      }
      .padding(.horizontal, 16)
    }
    .background(.lightPink)
  }
  
  private var content: some View {
    VStack {
      NavigationBar()
        .padding(.top, 20)
      if viewModel.isLoading {
        skeletonListView
      } else {
        list
      }
    }
    .background(Color.lightPink)
  }
  
  private var list: some View {
    ScrollView {
      PullToRefresh(coordinateSpaceName: "pull") {
        viewModel.getBirthDays()
      }
      LazyVStack(spacing: 18) {
        if !viewModel.birthdayData.isEmpty {
          ForEach(viewModel.birthdayData, id: \.id) { birthday in
            Button {
              router.push(
                TabBarView.HomeScreens.details(
                  viewModel: BirthdayDetailsViewModel(
                    homeRepository: HomeDefaultRepository(),
                    birthdayData: birthday,
                    deleteAction: {
                      viewModel.birthdayData.removeAll(where: { $0.id == birthday.id })
                    },
                    updateAction: { newBirthDay in
                      guard let index = viewModel.birthdayData.firstIndex(where: { $0.id == birthday.id } ) else { return }
                      viewModel.birthdayData[index] = newBirthDay
                    }
                  ),
                  birthday: birthday
                )
              )
            } label: {
              BirthDayCell(model: birthday)
            }
          }
        } else {
          emptyState
        }
      }
      .padding(.bottom, 20)
    }
    .padding(.horizontal, 24)
    .scrollIndicators(.hidden)
    .coordinateSpace(name: "pull")
    
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
