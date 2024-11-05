//
//  BirthDayEditCommonView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 24.10.24.
//

import SwiftUI
import EventKit
import EventKitUI

struct BirthDayEditCommonView: View {
  
  @Binding var birthdayData: BirthdayModel
  @Binding var isContentvalid: Bool
  @State private var isAddingRelation: Bool = false
  @State private var relationshipData: [Relationship] = Relationship.allCases
  @State private var newRelation: String = ""
  @State private var isAddingEvent: Bool = false
  @State private var openCalendar: Bool = false
  
  @EnvironmentObject var appState: AppState
  
  var isCreating: Bool
  var doneAction: (BirthdayModel) -> ()
  var columns = [GridItem(.flexible()),GridItem(.flexible()),GridItem(.flexible())]
  
  var body: some View {
    content
      .background(Color.lightPink)
      .sheet(
        isPresented: $openCalendar,
        content: {
          EventEditViewController(
            birthday: $birthdayData,
            eventStore: EKEventStore()
          )
        }
      )
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
          .padding(.bottom, 24)
        if isCreating {
          addToCalendarCheckBox
            .padding(.bottom, 24)
        }
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
      Text(String.Birthday.name)
        .foregroundStyle(Color.rouge)
        .karmaFont(style: .bold18)
        .padding(.bottom, 8)
      InputField(
        text: $birthdayData.name.toUnwrapped(defaultValue: ""),
        isFocused: .constant(true),
        placeholderText: "John Doe",
        backgroundColor: .white
      )
    }
    .padding(.horizontal, 26)
  }
  
  private var relationshipEdit: some View {
    VStack (alignment: .leading){
      Text(String.Birthday.relationship)
        .padding(.leading, 26)
        .foregroundStyle(Color.rouge)
        .karmaFont(style: .bold18)
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
        .karmaFont(style: .bold14)
    }
    .frame(width: 106, height: 40)
    .background(birthdayData.relation == relationship ? Color.rouge : Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  private var doneButton: some View {
    RoundedButton(
      name: String.Birthday.done,
      isSecondary: true
    ) {
      doneAction(birthdayData)
      UIApplication.shared.hideKeyboard()
      if isAddingEvent {
        openCalendar = true
        isAddingEvent = false
      }
    }
    .disabled(!isContentvalid)
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
      in: ...Date(),
      displayedComponents: [.date]
    )
    .datePickerStyle(GraphicalDatePickerStyle())
    .colorInvert()
    .colorMultiply(Color.rouge)
    .background(Color.white)
    .karmaFont(style: .bold20)
    .clipShape(RoundedRectangle(cornerRadius: 16))
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
        .foregroundStyle(Color.rouge)
        .frame(width: 30, height: 30)
        .rotationEffect(.degrees(isAddingRelation ? 45.0 :  0.0))
    }
  }
  
  private var addRelationField: some View {
    HStack {
      TextField(String.Birthday.newRelationship, text: $newRelation)
        .placeholder(
          when: newRelation.isEmpty,
          placeholder: {
            Text(String.Birthday.newRelationship)
              .foregroundStyle(Color.rouge.opacity(0.7))
          }
        )
        .karmaFont(style: .bold18)
        .foregroundStyle(Color.rouge)
        .tint(Color.rouge)
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
          .foregroundStyle(Color.rouge)
          .frame(width: 24, height: 24)
          .padding(16)
      }
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }
  
  private var addToCalendarCheckBox: some View {
    Button {
      isAddingEvent.toggle()
    } label: {
      HStack {
        RoundedRectangle(cornerRadius: 2.0)
          .overlay {
            Image(systemName: isAddingEvent ? "checkmark" : "")
              .foregroundStyle(Color.white)
          }
          .frame(width: 20, height: 20)
          .foregroundStyle(isAddingEvent ? Color.bubblegumPink : Color.white)
        Text(String.Add.event)
          .karmaFont(style: .bold14)
          .foregroundStyle(Color.rouge)
          .padding(.top, 2)
        Spacer()
      }
    }
  }
  
}

#Preview {
  BirthDayEditCommonView(
    birthdayData:
        .constant(
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
        ),
    isContentvalid: .constant(true),
    isCreating: true,
    doneAction: { _ in
      print()
    }
  )
}
