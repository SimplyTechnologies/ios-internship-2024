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
      ZStack {
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
      .onTapGesture {
        viewModel.isShowPickerOptions = true
      }
      .confirmationDialog("", isPresented: $viewModel.isShowPickerOptions) {
        Button(String.Button.camera) {
          viewModel.selectedSourceType = .camera
          viewModel.isPickerPresented = true
        }
        Button(String.Button.gallery) {
          viewModel.selectedSourceType = .photoLibrary
          viewModel.isPickerPresented = true
        }
        Button(String.Button.cancel, role: .cancel) {}
      }
      .fullScreenCover(isPresented: $viewModel.isPickerPresented) {
        ImagePicker(
          image: $viewModel.selectedImage,
          isPickerPresented: $viewModel.isPickerPresented,
          sourceType: viewModel.selectedSourceType
        )
      }
  }
  
  private var editView: some View {
    BirthDayEditCommonView(
      birthdayData: $viewModel.birthday,
      isContentvalid: $viewModel.isContentValid, 
      isCreating: true
    ) { _ in
      viewModel.createBirthday()
    }
  }
  
}
