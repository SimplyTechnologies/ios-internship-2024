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
  }
  
  private var image: some View {
    SkeletonImage(
      imagePath: model.image ?? "",
      placeholderImage: Image(systemName: "person"),
      borderColor: .clear,
      size: .init(width: 70, height: 70)
    )
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
