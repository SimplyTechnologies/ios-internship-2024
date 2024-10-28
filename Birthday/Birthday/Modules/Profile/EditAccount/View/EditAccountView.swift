//
//  EditAccountView.swift
//  Birthday
//
//  Created by Anna Hakobyan on 24.10.24.
//
import SwiftUI
import Combine
import PhotosUI

struct EditAccountView<T: EditAccountViewModeling>: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject var viewModel: T
  var model: ProfileModel
  var doneAction: (EditAccountModel) -> ()
  
  @State private var selectedPickerItem: PhotosPickerItem?
//  @State private var profileModel: ProfileModel
  @State private var selectedImage: UIImage? = nil
  
//  init(model: ProfileModel, doneAction: @escaping (EditAccountModel) -> Void) {
////    self.viewModel = viewModel
//    self.model = model
//    self.profileModel = model
//    self.doneAction = doneAction
//  }
  
  init(
    viewModel: any EditAccountViewModeling,
    model: ProfileModel,
    doneAction: @escaping (EditAccountModel) -> ()) {
    self._viewModel = StateObject(wrappedValue: viewModel as! T)
    self.model = model
//    self.profileModel = model
    self.doneAction = doneAction
  }
  
  var body: some View {
    VStack(spacing: 42) {
      logo
      profileImage
      VStack(spacing: 7) {
        InputField(label: "Name", text: $viewModel.profileModel.firstName, placeholder: viewModel.editAccountModel.firstName)
        InputField(label: "Surname", text: $viewModel.profileModel.lastName, placeholder: viewModel.editAccountModel.lastName)
      }
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
  
}

extension EditAccountView {
  
  private var logo: some View {
    HStack() {
      Image(.back)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 16, height: 24)
        .onTapGesture {
          presentationMode.wrappedValue.dismiss()
        }
      Spacer()
      Image(.birth)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 88, height: 40)
      Spacer()
    }
    .frame(maxWidth: .infinity)
    .padding(32)
  }
  
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
          image: viewModel.profileModel.image ?? "",
          lastName: viewModel.profileModel.lastName)
        )
      }
//      doneAction(EditAccountModel(firstName: model.firstName, image: model.image ?? "", lastName: model.lastName))
//      presentationMode.wrappedValue.dismiss()
    } label: {
      Text("Done")
        .foregroundColor(.white)
        .padding()
        .background(model.firstName.isEmpty || model.lastName.isEmpty ? Color.mainPink : Color.darkRed)
        .cornerRadius(8)
    }
    .disabled(model.firstName.isEmpty || model.lastName.isEmpty)
    .padding()
  }
}

struct InputField: View {
  
  let label: String
  @Binding var text: String
  let placeholder: String
  
  init(label: String, text: Binding<String>, placeholder: String) {
    self.label = label
    self._text = text
    self.placeholder = placeholder
  }
  
  
  var body: some View {
    VStack {
      HStack {
        Text(label)
          .font(.system(size: 18))
          .foregroundStyle(.darkRed70)
          .multilineTextAlignment(.leading)
        Spacer()
      }
      HStack(spacing: 18) {
        Spacer()
        TextField(placeholder, text: $text)
      }
      .frame(height: 41)
      .background(.white)
      .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    .padding(.horizontal, 61)
  }
}
