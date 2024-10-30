//
//  EditAccountScreen.swift
//  Birthday
//
//  Created by Anna Hakobyan on 24.10.24.
//
import Combine
import PhotosUI
import SwiftUI

struct EditAccountScreen<T: EditAccountViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case name, surname
  }
  
  @EnvironmentObject var router: NavigationRouter
  @StateObject var viewModel: T
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil
  
  var model: ProfileModel
  var doneAction: () -> ()
  
  init(
    viewModel: any EditAccountViewModeling,
    model: ProfileModel,
    doneAction: @escaping () -> ()
  ) {
    self._viewModel = StateObject(wrappedValue: viewModel as! T)
    self.model = model
    self.doneAction = doneAction
  }
  
  var body: some View {
    VStack(spacing: 42) {
      NavigationBar {
        router.pop()
      }
      profileImage
      VStack(spacing: 8) {
        nameField
        surnameField
      }
      .padding(.horizontal, 60)
      Spacer()
      buttonDone
      Spacer()
        .frame(height: 40)
    }
    .background(Color.lightPink)
    .navigationBarBackButtonHidden(true)
    .onLoad {
      viewModel.profileModel = model
    }
  }
  
  private var nameField: some View {
    InputField(
      text: $viewModel.profileModel.firstName,
      isFocused: $viewModel.isNameFocused,
      placeholderText: viewModel.editAccountModel.firstName,
      backgroundColor: .white
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .name)
    .id(Field.name.rawValue)
    .onTapGesture {
      viewModel.isNameFocused = true
    }
  }
  
  private var surnameField: some View {
    InputField(
      text: $viewModel.profileModel.lastName,
      isFocused: $viewModel.isSurnameFocused,
      placeholderText: viewModel.editAccountModel.lastName,
      backgroundColor: .white
    )
    .keyboardType(.default)
    .textInputAutocapitalization(.never)
    .focused($focusedField, equals: .surname)
    .id(Field.surname.rawValue)
    .onTapGesture {
      viewModel.isSurnameFocused = true
    }
  }
  
}

extension EditAccountScreen {
  
  private var profileImage: some View {
    ZStack {
      PhotosPicker(selection: $viewModel.selectedPickerItem, matching: .images) {
        if let selectedImage = viewModel.selectedImage {
          CircularImage(
            imagePath: "",
            image: Image(uiImage: selectedImage),
            borderColor: .rouge,
            borderWidth: 3,
            size: .init(width: 160, height: 160)
          )
        } else if let image = viewModel.profileModel.image, !image.isEmpty, let _ = URL(string: image) {
          CircularImage(
            imagePath: image,
            placeholderImage: Image(systemName: "person"),
            borderColor: .rouge,
            borderWidth: 3,
            size: .init(width: 160, height: 160)
          )
        } else {
          CircularImage(
            imagePath: viewModel.editAccountModel.image,
            placeholderView: {
              Image(.imagePlus)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            },
            borderColor: .rouge,
            borderWidth: 3,
            size: .init(width: 160, height: 160)
          )
        }
      }
    }
    .clipShape(Circle())
  }
  
  private var buttonDone: some View {
    RoundedButton(
      name: String.Button.done,
      isLoading: viewModel.isLoading
    ) {
      viewModel.updateProfileData {
        doneAction()
        router.pop()
      }
    }
    .disabled(!viewModel.isDoneEnabled)
  }
  
}
