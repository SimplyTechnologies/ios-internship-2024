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

extension AddBirthdayScreen {
  
  private var content: some View {
    VStack {
      NavigationBar()
        .padding(.top, 20)
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
  
}
