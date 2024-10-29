//
//  EditAccountScreen.swift
//  Birthday
//
//  Created by Anna Hakobyan on 24.10.24.
//
import SwiftUI
import Combine
import PhotosUI

struct EditAccountScreen<T: EditAccountViewModeling>: View {
  
  private enum Field: Int, CaseIterable {
    case name, surname
  }
  
  @EnvironmentObject var router: NavigationRouter
  @StateObject var viewModel: T
  @FocusState private var focusedField: Field?
  @State private var scrollProxy: ScrollViewProxy? = nil
  
  var model: ProfileModel
  var doneAction: (EditAccountModel) -> ()
  
  @State private var selectedPickerItem: PhotosPickerItem?
  @State private var selectedImage: UIImage? = nil
  
  init(
    viewModel: any EditAccountViewModeling,
    model: ProfileModel,
    doneAction: @escaping (EditAccountModel) -> ()) {
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
    }
    .background(Color.lightPink)
    .navigationBarBackButtonHidden(true)
    .onChange(of: selectedPickerItem) { _ in
      loadSelectedImage()
    }
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
      Circle()
        .stroke(.darkRed, lineWidth: 3)
        .frame(width: 160, height: 160)
        .background(.profilePlaceholderPink)
      if let selectedImage = selectedImage {
        Image(uiImage: selectedImage)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .clipShape(Circle())
          .frame(width: 150, height: 150)
      } else {
        PhotosPicker(selection: $selectedPickerItem, matching: .images) {
          AsyncImage(url: URL(string: viewModel.editAccountModel.image)) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fit)
              .clipShape(Circle())
              .frame(width: 150, height: 150)
          } placeholder: {
            Image(.imagePlus)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 50, height: 50)
          }
        }
      }
    }
    .clipShape(Circle())
  }
  
  private func loadSelectedImage() {
    guard let item = selectedPickerItem else { return }
    
    item.loadTransferable(type: Data.self) { result in
      switch result {
      case .success(let data):
        if let data = data, let image = UIImage(data: data) {
          DispatchQueue.main.async {
            self.selectedImage = image
            
          }
        }
      case .failure(let error):
        print("Failed to load image data: \(error)")
      }
    }
  }
  
  private var buttonDone: some View {
    Button {
      viewModel.updateProfileData(
        model: EditAccountModel(
          firstName: viewModel.profileModel.firstName,
          image: viewModel.profileModel.image ?? "",
          lastName: viewModel.profileModel.lastName)
      ) {
        doneAction(.init(
          firstName: viewModel.profileModel.firstName,
          image: selectedImage?.convertImageToBase64String() ?? "",
          lastName: viewModel.profileModel.lastName)
        )
        // TODO: - dismiss
        
      }
    } label: {
      Text(String.Button.done)
        .foregroundColor(.white)
        .padding()
        .background(
          model.firstName != viewModel.profileModel.firstName ||
          model.lastName != viewModel.profileModel.lastName ||
          selectedImage.isNotNil
          ? Color.rouge
          : Color.piggyPink
        )
        .cornerRadius(8)
    }
    .disabled(
      model.firstName != viewModel.profileModel.firstName ||
      model.lastName != viewModel.profileModel.lastName ||
      selectedImage.isNotNil
      ? false
      : true
    )
    .padding()
  }

}
