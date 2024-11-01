//
//  ChangePasswordScreen.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Combine
import SwiftUI

struct ChangePasswordScreen<T: ChangePasswordViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case oldPassword, newPassword, repeatPassword
  }
  
  @StateObject var viewModel: T
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var router: NavigationRouter
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil

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

extension ChangePasswordScreen {
  
  private var content: some View {
    ZStack {
      Color.lightPink.ignoresSafeArea()
      VStack(spacing: 0) {
        NavigationBar {
          router.pop()
        }
        GeometryReader { geo in
          ScrollViewReader { scrollReader in
            ScrollView {
              VStack(spacing: 0) {
                Spacer()
                  .frame(height: geo.size.height * 0.2)
                Spacer()
                changePasswordForm
                Spacer()
                doneButton
                Spacer()
                  .frame(height: 40)
              }
              .frame(height: geo.size.height)
            }
            .scrollIndicators(.hidden)
            .disableBounces()
            .onAppear {
              self.scrollProxy = scrollReader
            }
          }
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .keyboard) {
        keyboardButtons
      }
    }
  }
  
  private var keyboardButtons: some View {
    HStack(spacing: 8) {
      Spacer()
      Button {
        goUp()
      } label: {
        Image(systemName: "chevron.up")
      }
      .disabled(focusedField == .oldPassword)
        
      Button {
        goDown()
      } label: {
        Image(systemName: "chevron.down")
      }
      .disabled(focusedField == .repeatPassword)
    }
  }
  
  private var changePasswordForm: some View {
    VStack(spacing: 24) {
      oldPasswordField
      newPasswordField
      repeatPasswordField
      Spacer()
    }
    .padding(.horizontal, 60)
    .onChange(of: focusedField) { newField in
      if let newField {
        withAnimation {
          scrollProxy?.scrollTo(newField.rawValue, anchor: .center)
        }
      }
    }
  }
  
  private var oldPasswordField: some View {
    InputField(
      text: $viewModel.oldPassword,
      isFocused: $viewModel.isOldPasswordFocused,
      isValidField: $viewModel.isValidOldPassword,
      isShow: $viewModel.isShowOldPassword,
      placeholderText: String.Field.oldPassword,
      isSecureField: true,
      backgroundColor: .white
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .oldPassword)
    .modifier(
      FieldErrorModifier(
        title: viewModel.oldPasswordErrorMessage,
        isHidden: viewModel.isValidOldPassword
      )
    )
    .id(Field.oldPassword.rawValue)
    .onTapGesture {
      viewModel.isOldPasswordFocused = true
    }
  }
  
  private var newPasswordField: some View {
    InputField(
      text: $viewModel.newPassword,
      isFocused: $viewModel.isNewPasswordFocused,
      isValidField: $viewModel.isValidNewPassword,
      isShow: $viewModel.isShowNewPassword,
      placeholderText: String.Field.newPassword,
      isSecureField: true,
      backgroundColor: .white
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .newPassword)
    .modifier(
      FieldErrorModifier(
        title: viewModel.newPasswordErrorMessage,
        isHidden: viewModel.isValidNewPassword
      )
    )
    .id(Field.newPassword.rawValue)
    .onTapGesture {
      viewModel.isNewPasswordFocused = true
    }
  }
  
  private var repeatPasswordField: some View {
    InputField(
      text: $viewModel.repeatPassword,
      isFocused: $viewModel.isRepeatPasswordFocused,
      isValidField: $viewModel.isValidRepeatPassword,
      isShow: $viewModel.isShowRepeatPassword,
      placeholderText: String.Field.repeatNewPassword,
      isSecureField: true,
      backgroundColor: .white
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .repeatPassword)
    .modifier(
      FieldErrorModifier(
        title: viewModel.repeatPasswordErrorMessage,
        isHidden: viewModel.isValidRepeatPassword
      )
    )
    .id(Field.repeatPassword.rawValue)
    .onTapGesture {
      viewModel.isRepeatPasswordFocused = true
    }
  }
  
  private var doneButton: some View {
    RoundedButton(
      name: String.Birthday.done,
      isLoading: viewModel.isLoading,
      isSecondary: true
    ) {
        viewModel.changePassword {
          router.pop()
        }
      }
  }
  
  private func goUp() {
    guard let rawValue = focusedField?.rawValue,
          let status = Field(rawValue: rawValue - 1)
    else { return }
    focusedField = status
  }
  
  private func goDown() {
    guard let rawValue = focusedField?.rawValue,
          let status = Field(rawValue: rawValue + 1)
    else { return }
    focusedField = status
  }
  
}

#Preview {
  ChangePasswordScreen(
    viewModel: ChangePasswordViewModel(
      changePasswordRepository: ChangePasswordDefaultRepository()
    )
  )
}
