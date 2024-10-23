//
//  BirthdayDetailsScreen.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import SwiftUI

struct BirthdayDetailsScreen<T: BirthDayDetailsViewModeling>: View {
  
  @ObservedObject var viewModel: T
  
  @State var birthdayData: BirthdayModel
  @State var isEditing: Bool = false
  @State var isAddingRelation: Bool = false
  @State var newRelation: String = ""
  @State var relationshipData: [Relationship] = [.bestFriend,.mother,.father,.sister,.brother,.grandfather,.grandmother,.uncle,.friend]
  
  var columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
  
  var body: some View {
    if isEditing {
      editingContnent
        .background(Color.lightPink)
    } else {
      content
        .background(Color.lightPink)
        .onLoad {
          guard let relationData = birthdayData.relation  else { return }
          guard let relation = Relationship(rawValue: relationData) else { return }
          if !relationshipData.contains(relation) {
            relationshipData.append(relation)
          }
        }
    }
  }
  
}

extension BirthdayDetailsScreen {
  
  private var content: some View {
   
      VStack(spacing: 0) {
//        ScrollView {
        HStack {
          Spacer()
          editButton
        }
        .padding(.bottom, 20)
        image
          .padding(.bottom, 12)
        name
          .padding(.bottom, 24)
        date
          .padding(.bottom, 10)
        relationship
          .padding(.bottom, 10)
        zodiacSign
        Spacer()
        HStack(spacing: 10) {
          generateMessageButton
          findGiftButton
        }
      }
      .padding(.top, 20)
      .padding(.bottom, 60)
      .padding(.horizontal, 24)

  }
  
  private var image: some View {
    AsyncImage(url:URL(string: birthdayData.image ?? "") ) { phase in
      if let image = phase.image {
        image
          .resizable()
      } else if phase.error != nil {
        Image(systemName: "person")
          .resizable()
          .foregroundStyle(.blue)
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
      Text(birthdayData.relation ?? "")
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(8)
    }
  }
  
  private var zodiacSign: some View {
    HStack {
      Text("Zodiac Sign: ")
      Text(birthdayData.date?.toFormattedDate()?.zodiacSign() ?? "Unknown")
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
  
  private var generateMessageButton: some View {
    Button {
      
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
  
}

//MARK: - for edit
extension BirthdayDetailsScreen {
  
  private var editingContnent: some View {
    ScrollView {
      VStack(spacing: 0) {
        HStack {
          Spacer()
          deleteButton
        }
        .padding(.bottom, 20)
        image
          .padding(.bottom, 34)
        editingName
          .padding(.bottom, 20)
        relationshipEdit
          .padding(.bottom, 10)
        addButton
          .padding(.bottom, 34)
        if isAddingRelation {
          addRelationField
            .padding(.bottom, 34)
        }
        calendar
          .padding(.bottom, 50)
        doneButton
      }
      .padding(.horizontal, 24)
      .padding(.vertical, 20)
    }.scrollIndicators(.hidden)
  }
  
  private var editingName: some View {
    VStack(alignment: .leading,spacing: 0) {
      Text("Name")
        .foregroundStyle(Color.darkRed)
        .padding(.bottom, 8)
      ZStack {
        TextField("", text: $birthdayData.name.toUnwrapped(defaultValue: ""))
          .frame(height: 40)
          .padding(.horizontal,8)
      }
      .background(Color.white)
      .cornerRadius(16)
    }
    .padding(.horizontal, 26)
  }
  
  private var deleteButton: some View {
    Button {
      guard let id = birthdayData.id else { return }
      viewModel.deleteBirthDay(id: id)
      //MARK: - pop to previous page after delete
    } label: {
      Image(.delete)
    }
  }
  
  private var relationshipEdit: some View {
    VStack (alignment: .leading){
      Text("Relationship")
        .padding(.leading, 26)
        .foregroundStyle(Color.darkRed)
      LazyVGrid(columns: columns, content: {
        ForEach(relationshipData, id: \.self) { relation in
          Button {
            birthdayData.relation = relation.rawValue
          } label: {
            relationshipChip(relationship: relation.rawValue)
          }
        }
      })
    }
  }
  
  private func relationshipChip(relationship: String) -> some View {
    ZStack {
      Text(relationship)
        .lineLimit(1)
        .foregroundStyle(birthdayData.relation == relationship ? .white : .black)
    }
    .frame(width: 106,height: 40)
    .background(birthdayData.relation == relationship ? Color.darkRed : Color.white)
    .cornerRadius(16)
  }
  
  private var doneButton: some View {
    Button {
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
            relation: birthdayData.relation
          )
      )
    } label: {
      Text("Done")
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
        .background(Color.darkRed)
        .cornerRadius(8)
    }
  }
  
  private var calendar: some View {
    DatePicker(
      "",
      selection: Binding<Date>(
        get: { birthdayData.date?.toDate() ?? Date() },
        set: { newDate in
          birthdayData.date = newDate.toISO8601String()
        }
      ),
      displayedComponents: [.date]
    )
    .datePickerStyle(GraphicalDatePickerStyle())
    .colorInvert()
    .colorMultiply(Color.darkRed)
    .background(Color.white)
    .cornerRadius(16)
  }
  
  private var addButton: some View {
    Button {
      withAnimation {
        isAddingRelation.toggle()
        newRelation = ""
      }
    } label: {
      Image(systemName: "plus.circle.fill")
        .resizable()
        .foregroundStyle(Color.darkRed)
        .frame(width: 30, height: 30)
        .rotationEffect(.degrees(isAddingRelation ? 45.0 :  0.0))
    }
  }
  
  private var addRelationField: some View {
    HStack {
      TextField("New relationship", text: $newRelation)
        .padding(.horizontal, 10)
      Button {
        withAnimation {
          isAddingRelation = false
          if !newRelation.isEmpty {
            guard let relation = Relationship(rawValue: newRelation) else { return }
            relationshipData.append(relation)
            newRelation = ""
          }
        }
      } label: {
        Image(systemName: "checkmark.circle.fill")
          .resizable()
          .foregroundStyle(Color.darkRed)
          .frame(width: 24, height: 24)
          .padding(16)
      }
    }
    .background(Color.white)
    .cornerRadius(16)
  }
  
}

#Preview {
  BirthdayDetailsScreen(
    viewModel: BirthdayDetailsViewModel(
      homeRepository: HomeDefaultRepository()),
    birthdayData:
      BirthdayModel(
        createdAt: "",
        date: "2021-03-10T00:00:00.000Z",
        id: 1,
        image: "https://randomuser.me/api/portraits/med/women/3.jpg",
        message: "Be happy",
        name: "John",
        relation: "Brother",
        upcomingAge: 10,
        upcomingBirthday: "",
        updatedAt: "",
        userId: 1)
  )
}
