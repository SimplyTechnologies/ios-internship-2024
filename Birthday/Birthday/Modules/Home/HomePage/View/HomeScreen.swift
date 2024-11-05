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
  
  var body: some View {
    content
      .onLoad {
        viewModel.getBirthDays()
      }
  }
  
}

extension HomeScreen {
  
  private var emptyState: some View {
    ZStack {
      Color.lightPink
      if viewModel.isShowEmpty {
        VStack(spacing: 10) {
          Image(.bunny)
            .resizable()
            .frame(width: 150, height: 150)
            .aspectRatio(contentMode: .fit)
          HStack {
            Spacer()
            Text(String.Birthday.emptyStateMessage)
              .multilineTextAlignment(.center)
              .foregroundStyle(.rouge)
              .karmaFont(style: .bold18)
            Spacer()
          }
          .padding(.horizontal, 16)
        }
      }
    }
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
          cells
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
  
  private var cells: some View {
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
            )
          )
        )
      } label: {
        BirthDayCell(model: birthday)
      }
      .buttonStyle(PressedButtonStyle())
    }
  }
  
  private var skeletonListView: some View {
    ScrollView {
      LazyVStack(spacing: 18) {
        ForEach(0 ..< 10, id: \.self) { _ in
          SkeletonView()
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .frame(height: 110)
        }
      }
      .padding(.horizontal, 24)
      .padding(.top, 10)
    }
    .scrollIndicators(.hidden)
  }
  
}
