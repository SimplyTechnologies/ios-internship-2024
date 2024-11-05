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
  
  @StateObject var viewModel: T
  @EnvironmentObject var appState: AppState
  @EnvironmentObject var router: NavigationRouter
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

extension EditAccountScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      NavigationBar {
        router.pop()
      }
      .padding(.top, 20)
      GeometryReader { geo in
        ScrollViewReader { scrollReader in
          ScrollView {
            VStack(spacing: 0) {
              profileImage
                .padding(.vertical, 42)
              VStack(spacing: 8) {
                nameField
                surnameField
              }
              .padding(.horizontal, 60)
              Spacer()
              doneButton
                .padding(.bottom, 40)
            }
            .frame(
              maxWidth: .infinity,
              minHeight: geo.size.height,
              alignment: .bottom
            )
          }
          .scrollIndicators(.hidden)
          .onAppear {
            self.scrollProxy = scrollReader
          }
        }
      }
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
  
  private var profileImage: some View {
    ZStack {
      PhotosPicker(
        selection: $viewModel.selectedPickerItem,
        matching: .images,
        photoLibrary: .shared()
      ) {
        if let selectedImage = viewModel.selectedImage {
          SkeletonImage(
            imagePath: "",
            image: Image(uiImage: selectedImage),
            borderColor: .rouge,
            borderWidth: 3,
            size: .init(width: 160, height: 160)
          )
        } else if let image = viewModel.profileModel.image, !image.isEmpty, let _ = URL(string: image) {
          SkeletonImage(
            imagePath: image,
            placeholderImage: Image(systemName: "person"),
            borderColor: .rouge,
            borderWidth: 3,
            size: .init(width: 160, height: 160)
          )
        } else {
          SkeletonImage(
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
  
  private var doneButton: some View {
    RoundedButton(
      name: String.Button.done,
      isLoading: viewModel.isLoading,
      isSecondary: true
    ) {
      UIApplication.shared.hideKeyboard()
      viewModel.updateProfileData {
        doneAction()
        router.pop()
      }
    }
    .disabled(viewModel.isDisabled || viewModel.isLoading)
  }
  
}

#Preview {
  EditAccountScreen<EditAccountViewModel>(
    viewModel: EditAccountViewModel(
      editAccountRepository: EditAccountDefaultRepository(),
      model: .init(
        firstName: "Name",
        image: "",
        lastName: "Surname"
      )
    ),
    model: .init(),
    doneAction: {}
  )
}
