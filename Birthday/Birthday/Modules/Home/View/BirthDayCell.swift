//
//  BirthDayCell.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

struct BirthDayCell: View {
  
  var model: BirthdayModel
  
  var body: some View {
      content
  }
}

extension BirthDayCell {
  
  private var content: some View {
    HStack(alignment: .center) {
      image
      VStack {
        name
        date
      }
      Spacer()
    }
    .background(Color.white)
    .cornerRadius(24)
  }
  
  private var image: some View {
    AsyncImage(url: URL(string: model.image ?? "")) { image in
      image
        .resizable()
        .cornerRadius(50)
        .frame(width: 70, height: 70)
      
    } placeholder: {
      Circle()
        .frame(width: 70, height: 70)
        .foregroundColor(Color.gray)
        .cornerRadius(50)
    }
    .padding(.leading, 16)
    .padding(.trailing, 44)
    .padding(.vertical, 20)
  }
  
  private var name: some View {
    Text(model.name ?? "")
  }
  
  private var date: some View {
    Text(model.date?.toFormattedDate() ?? "")
  }
  
}

#Preview {
  BirthDayCell(model: BirthdayModel(createdAt: "", date: "1999-11-03T09:54:33.000Z", id: 1, image: "https://randomuser.me/api/portraits/med/women/19.jpg", message: "Be Happy", name: "John", relation: "Friend", upcomingAge: 12, upcomingBirthday: nil, updatedAt: nil, userId: 2))
}
