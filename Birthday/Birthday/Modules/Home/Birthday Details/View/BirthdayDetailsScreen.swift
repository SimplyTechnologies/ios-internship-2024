//
//  BirthdayDetailsScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import SwiftUI
import PhotosUI

struct BirthdayDetailsScreen<T: BirthDayDetailsViewModeling>: View {
  
  @StateObject var viewModel: T
  
  @EnvironmentObject var router: NavigationRouter
  
  var body: some View {
    content
      .background(Color.lightPink)
      .navigationBarBackButtonHidden(true)
      .customAlert(isPresented: $viewModel.isGeneratingMessage)
  }
  
}

extension BirthdayDetailsScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      header
      ScrollView {
        if viewModel.isEditing {
          selectedImage
            .padding(.bottom, 12)
        } else {
          image
            .padding(.bottom, 12)
        }
        if viewModel.isEditing {
          BirthDayEditCommonView(
            birthdayData: $viewModel.birthdayData,
            isContentvalid: .constant(true),
            isCreating: false
          ) { newBirthday in
            doneAction(birthday: newBirthday)
          }
        } else {
          name
            .padding(.bottom, 24)
          date
            .padding(.bottom, 10)
          relationship
            .padding(.bottom, 10)
          zodiacSign
          Spacer()
            .frame(minHeight: 200)
          HStack(spacing: 10) {
            generateMessageButton
            findGiftButton
          }
        }
      }
      .padding(.horizontal, 24)
      .scrollIndicators(.hidden)
    }
    .padding(.top, 20)
  }
  
  private var header: some View {
    VStack(spacing: 10) {
      NavigationBar() {
        router.pop()
      }
      HStack {
        Spacer()
        if viewModel.isEditing {
          deleteButton
        } else {
          editButton
        }
      }
      .padding(.horizontal, 20)
    }
  }
  
  private var image: some View {
    ZStack {
      if let image = viewModel.birthdayData.image {
        AsyncImage(url:URL(string: image) ) { phase in
          if let image = phase.image {
            image
              .resizable()
          } else if phase.error != nil {
            Image(systemName: "person")
              .resizable()
              .foregroundStyle(Color.darkRed)
              .padding(12)
          } else {
            ProgressView()
              .progressViewStyle(.circular)
          }
        }
      }  else {
        Image(systemName: "person")
          .resizable()
          .foregroundStyle(Color.darkRed)
          .padding(8)
      }
    }
    .frame(width: 100, height: 100)
    .cornerRadius(50)
  }
  
  private var selectedImage: some View {
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
        if let image = viewModel.birthdayData.image {
          AsyncImage(url:URL(string: image)) { phase in
            if let image = phase.image {
              image
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(50)
            } else if phase.error != nil {
              Image(.addPicture)
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            } else {
              ProgressView()
                .progressViewStyle(.circular)
            }
          }
        }
      }
    }
    .onChange(of: viewModel.selectedItem) { newItem in
      Task {
        await viewModel.convertImage(image: newItem)
      }
    }
  }
  
  private var name: some View {
    Text(viewModel.birthdayData.name ?? "")
      .foregroundStyle(Color.black)
      .karmaFont(style: .semiBold20)
  }
  
  private var date: some View {
    Text(viewModel.birthdayData.date?.toFormattedDate() ?? "")
      .foregroundStyle(Color.black)
      .karmaFont(style: .semiBold14)
  }
  
  private var relationship: some View {
    HStack {
      Text(String.Birthday.relationship)
        .foregroundStyle(Color.black)
        .karmaFont(style: .bold14)
      Text(viewModel.birthdayData.relation?.rawValue ?? "")
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .foregroundStyle(Color.black)
        .background(Color.white)
        .karmaFont(style: .semiBold14)
        .cornerRadius(8)
    }
  }
  
  private var zodiacSign: some View {
    HStack {
      Text(String.Birthday.zodiac)
        .foregroundStyle(Color.black)
        .karmaFont(style: .semiBold14)
      Text(ZodiacSign.from(
        dateString: viewModel.birthdayData.date?.toFormattedDate() ?? "")?.rawValue ?? ""
      )
      .foregroundStyle(Color.darkRed)
      .karmaFont(style: .semiBold14)
    }
  }
  
  private var editButton: some View {
    Button {
      withAnimation {
        viewModel.isEditing = true
      }
    } label: {
      Image(.edit)
    }
  }
  
  private var deleteButton: some View {
    Button {
      guard let id = viewModel.birthdayData.id else { return }
      viewModel.deleteBirthDay(id: id) {
        DispatchQueue.main.async {
          router.pop()
        }
      }
    } label: {
      Image(.delete)
    }
  }
  
  private var generateMessageButton: some View {
    Button {
      withAnimation {
        viewModel.isGeneratingMessage = true
      }
    } label: {
      Text(String.Birthday.generate)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .foregroundStyle(Color.darkRed)
        .background(Color.bubblegumPink)
        .karmaFont(style: .semiBold18)
        .cornerRadius(16)
    }
  }
  
  private var findGiftButton: some View {
    Button {
      router.push(
        TabBarView.HomeScreens.shops(
          viewModel: ShopViewModel(
            shopRepository: ShopDefaultRepository()
          )
        )
      )
    } label: {
      Text(String.Birthday.gift)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .foregroundStyle(Color.bubblegumPink)
        .background(Color.darkRed)
        .karmaFont(style: .semiBold18)
        .cornerRadius(16)
    }
  }
  
  private func doneAction(birthday: BirthdayModel) {
    viewModel.birthdayData = birthday
    withAnimation {
      viewModel.isEditing = false
    }
    viewModel.updateBirthday()
  }
  
}

#Preview {
  BirthdayDetailsScreen(
    viewModel: BirthdayDetailsViewModel(
      homeRepository: HomeDefaultRepository(),
      birthdayData: BirthdayModel(
        createdAt: "",
        date: "2021-03-10T00:00:00.000Z",
        id: 1,
        image: "https://randomuser.me/api/portraits/med/women/3.jpg",
        message: "Be happy",
        name: "John",
        relation: .brother,
        upcomingAge: 10,
        upcomingBirthday: "",
        updatedAt: "",
        userId: 1
      ),
      deleteAction: {
        print()
      },
      updateAction: { _ in
        print()
      }
    )
  )
}
