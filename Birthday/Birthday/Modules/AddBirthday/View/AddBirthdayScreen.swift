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
      .onAppear {
        viewModel.resetScreen()
      }
  }
  
}

extension AddBirthdayScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      NavigationBar()
        .padding(.top, 20)
      ScrollView {
        VStack {
          image
            .padding(.top, 10)
          editView
        }
        .padding(.horizontal, 24)
        .scrollIndicators(.hidden)
      }
    }
    .background(Color.lightPink.ignoresSafeArea(.all))
  }
  
  private var image: some View {
    ZStack {
      Image(uiImage: viewModel.selectedImage ?? .addPicture)
        .resizable()
        .clipShape(Circle())
        .frame(width: 100, height: 100)
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
