//
//  BirthdayDetailsScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import SwiftUI

struct BirthdayDetailsScreen<T: BirthDayDetailsViewModeling>: View {
  
  @StateObject var viewModel: T
  
  @State var birthdayData: BirthdayModel
  @State private var isEditing: Bool = false
  
  @EnvironmentObject var router: NavigationRouter
  
  var body: some View {
    content
      .background(Color.lightPink)
      .navigationBarBackButtonHidden(true)
  }
  
}

extension BirthdayDetailsScreen {
  
  private var content: some View {
    VStack(spacing: 0) {
      header
      ScrollView {
        image
          .padding(.bottom, 12)
        if isEditing {
          BirthDayEditCommonView(birthdayData: birthdayData) { newBirthday in
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
        if isEditing {
          deleteButton
        } else {
          editButton
        }
      }
      .padding(.horizontal, 20)
    }
  }
  
  private var image: some View {
    AsyncImage(url:URL(string: birthdayData.image ?? "") ) { phase in
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
    .frame(width: 100, height: 100)
    .cornerRadius(50)
  }
  
  private var name: some View {
    Text(birthdayData.name ?? "")
  }
  
  private var date: some View {
    Text(birthdayData.date?.toFormattedDate() ?? "")
  }
  
  private var relationship: some View {
    HStack {
      Text("Relationship:")
      Text(birthdayData.relation?.rawValue ?? "")
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(8)
    }
  }
  
  private var zodiacSign: some View {
    HStack {
      Text("Zodiac Sign: ")
      Text(ZodiacSign.from(dateString: birthdayData.date?.toFormattedDate() ?? "")?.rawValue ?? "")
        .foregroundStyle(Color.darkRed)
    }
  }
  
  private var editButton: some View {
    Button {
      withAnimation {
        isEditing = true
      }
    } label: {
      Image(.edit)
    }
  }
  
  private var deleteButton: some View {
    Button {
      guard let id = birthdayData.id else { return }
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
      //MARK: - implement generate Message
    } label: {
      Text("Generate Message")
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .foregroundStyle(Color.darkRed)
        .background(Color.mainPink)
        .cornerRadius(16)
    }
  }
  
  private var findGiftButton: some View {
    Button {
      //MARK: - implement find gift
    } label: {
      Text("Find Gift")
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .foregroundStyle(Color.mainPink)
        .background(Color.darkRed)
        .cornerRadius(16)
    }
  }
  
  private func doneAction(birthday: BirthdayModel) {
    self.birthdayData = birthday
    withAnimation {
      isEditing = false
    }
    guard let id = birthdayData.id else { return }
    viewModel.updateBirthday(
      payload:
        BirthdayUpdatePayload(
          id: id,
          image: birthdayData.image,
          name: birthdayData.name,
          date: birthdayData.date,
          message: birthdayData.message,
          relation: birthdayData.relation?.rawValue
        ),
      birthday: birthdayData
    )
  }
  
}

#Preview {
  BirthdayDetailsScreen(
    viewModel: BirthdayDetailsViewModel(
      homeRepository: HomeDefaultRepository(),
      deleteAction: {
        print()
      },
      updateAction: { _ in
        print()
      }
    ),
    birthdayData:
      BirthdayModel(
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
      )
  )
}
