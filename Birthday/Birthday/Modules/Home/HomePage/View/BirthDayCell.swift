//
//  BirthDayCell.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct BirthDayCell: View {
  
  let model: BirthdayModel
  
  var body: some View {
    content
  }
}

extension BirthDayCell {
  
  private var content: some View {
    HStack(alignment: .center) {
      image
      VStack(alignment: .leading) {
        name
        date
      }
      Spacer()
    }
    .background(Color.white)
    .cornerRadius(24)
  }
  
  private var image: some View {
    AsyncImage(url:URL(string: model.image ?? "") ) { phase in
      if let image = phase.image {
        image
          .resizable()
      } else if phase.error != nil {
        Image(systemName: "person")
          .resizable()
          .foregroundStyle(.lightPink)
          .padding(8)
      } else {
        ProgressView()
          .progressViewStyle(.circular)
      }
    }
    .frame(width: 70, height: 70)
    .cornerRadius(50)
    .padding(.leading, 16)
    .padding(.trailing, 44)
    .padding(.vertical, 20)
  }
  
  private var name: some View {
    Text(model.name ?? "")
      .foregroundStyle(.black)
  }
  
  private var date: some View {
    Text(model.date?.toFormattedDate() ?? "")
      .foregroundStyle(.black)
  }
  
}

#Preview {
  BirthDayCell(
    model: BirthdayModel(
      createdAt: "",
      date: "1999-11-03T09:54:33.000Z",
      id: 1,
      image: "https://randomuser.me/api/portraits/med/women/19.jpg",
      message: "Be Happy",
      name: "John", 
      relation: .friend,
      upcomingAge: 12,
      upcomingBirthday: nil,
      updatedAt: nil, userId: 2)
  )
}
