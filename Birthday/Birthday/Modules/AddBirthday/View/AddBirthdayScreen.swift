//
//  AddBirthdayView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI
import PhotosUI

struct AddBirthdayScreen<T: CreateBirthdayViewModeling>: View {
  
  @StateObject var viewModel: T
  
  @Binding var selectedTab: TabModel
  
  var body: some View {
    content
      .onChange(of: selectedTab) { _ in
        resetScreen()
      }
  }
  
}

extension AddBirthdayScreen {
  
  private var content: some View {
    VStack {
      NavigationBar()
      ScrollView {
        image
        editView
      }
      .scrollIndicators(.hidden)
    }
    .padding(.horizontal, 24)
    .background(Color.lightPink)
  }
  
  private var image: some View {
    PhotosPicker(
      selection: $viewModel.selectedItem,
      matching: .images,
      photoLibrary: .shared()
    ) {
      if let image = viewModel.selectedImage {
        Image(uiImage: image)
          .resizable()
          .clipShape(Circle())
          .frame(width: 100, height: 100)
      } else {
        Image(.addPicture)
          .resizable()
          .clipShape(Circle())
          .frame(width: 100, height: 100)
      }
    }
    .onChange(of: viewModel.selectedItem) { newItem in
      Task {
        await viewModel.convertImage(image: newItem)
      }
    }
  }
  
  private var editView: some View {
    BirthDayEditCommonView(
      birthdayData: $viewModel.birtday,
      isContentvalid: $viewModel.isContentValid,
      isCreating: true
    ) { _ in
      viewModel.createBirthday()
    }
  }
  
  private func resetScreen() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      viewModel.birtday = BirthdayModel()
      viewModel.selectedItem = nil
      viewModel.selectedImage = nil
    }
  }
  
}
