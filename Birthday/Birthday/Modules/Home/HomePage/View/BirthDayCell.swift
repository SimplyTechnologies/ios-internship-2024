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
      VStack(alignment: .leading, spacing: 0) {
        name
        date
      }
      Spacer()
    }
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }
  
  private var image: some View {
    ZStack {
      if let image = model.image  {
        AsyncImage(url:URL(string: image) ) { phase in
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
      } else {
        Image(systemName: "person")
          .resizable()
          .foregroundStyle(.lightPink)
          .padding(8)
      }
    }
    .frame(width: 70, height: 70)
    .clipShape(RoundedRectangle(cornerRadius: 50))
    .padding(.leading, 16)
    .padding(.trailing, 44)
    .padding(.vertical, 20)
  }
  
  private var name: some View {
    Text(model.name ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold20)
      .lineLimit(2)
      .multilineTextAlignment(.leading)
  }
  
  private var date: some View {
    Text(model.date?.toFormattedDate() ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold14)
  }
  
}

#Preview {
  BirthDayCell(model: BirthdayModel.mock)
}
