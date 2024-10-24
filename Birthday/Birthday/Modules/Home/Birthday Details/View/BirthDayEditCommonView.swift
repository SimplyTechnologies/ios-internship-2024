//
//  BirthDayEditCommonView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 24.10.24.
//

import SwiftUI

struct BirthDayEditCommonView: View {
  
  @State var birthdayData: BirthdayModel
  @State private var isAddingRelation: Bool = false
  @State private var relationshipData: [Relationship] = Relationship.allCases
  @State private var newRelation: String = ""
  
  var doneAction: (BirthdayModel) -> ()
  var columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
  
  var body: some View {
    content
      .background(Color.lightPink)
  }
  
}

extension BirthDayEditCommonView {
  
  private var content: some View {
    VStack {
      VStack(spacing: 0) {
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
      .padding(.bottom, 10)
    }
    .onLoad {
      guard let relationData = birthdayData.relation  else { return }
      if !relationshipData.contains(relationData) {
        relationshipData.append(relationData)
      }
    }
  }
  
  private var editingName: some View {
    VStack(alignment: .leading,spacing: 0) {
      Text("Name")
        .foregroundStyle(Color.darkRed)
        .karmaFont(style: .semiBold18)
        .padding(.bottom, 8)
      ZStack {
        TextField("", text: $birthdayData.name.toUnwrapped(defaultValue: ""))
          .karmaFont(style: .semiBold18)
          .frame(height: 40)
          .padding(.horizontal,8)
      }
      .background(Color.white)
      .cornerRadius(16)
    }
    .padding(.horizontal, 26)
  }
  
  private var relationshipEdit: some View {
    VStack (alignment: .leading){
      Text("Relationship")
        .padding(.leading, 26)
        .foregroundStyle(Color.darkRed)
        .karmaFont(style: .semiBold18)
      LazyVGrid(
        columns: columns,
        content: {
          ForEach(relationshipData, id: \.self) { relation in
            Button {
              birthdayData.relation = relation
            } label: {
              relationshipChip(relationship: relation)
            }
          }
        }
      )
    }
  }
  
  private func relationshipChip(relationship: Relationship) -> some View {
    ZStack {
      Text(relationship.rawValue)
        .lineLimit(1)
        .foregroundStyle(birthdayData.relation == relationship ? .white : .black)
        .karmaFont(style: .semiBold14)
    }
    .frame(width: 106,height: 40)
    .background(birthdayData.relation == relationship ? Color.darkRed : Color.white)
    .cornerRadius(16)
  }
  
  private var doneButton: some View {
    Button {
      doneAction(birthdayData)
    } label: {
      Text("Done")
        .foregroundStyle(.white)
        .karmaFont(style: .semiBold18)
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
        get: { birthdayData.date?.toDate ?? Date() },
        set: { newDate in
          birthdayData.date = newDate.toISO8601String
        }
      ),
      displayedComponents: [.date]
    )
    .datePickerStyle(GraphicalDatePickerStyle())
    .colorInvert()
    .colorMultiply(Color.darkRed)
    .background(Color.white)
    .karmaFont(style: .semiBold20)
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
        .karmaFont(style: .semiBold18)
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
  BirthDayEditCommonView(
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
      ),
    doneAction: { _ in
      print()
    }
  )
}
