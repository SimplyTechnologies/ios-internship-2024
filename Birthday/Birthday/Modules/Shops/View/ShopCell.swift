//
//  ShopCell.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import SwiftUI

struct ShopCell: View {
  
  @Binding var model: Shop
  
  var body: some View {
    content
  }
  
}

extension ShopCell {
  
  private var content: some View {
    HStack(spacing: 0) {
      Spacer().frame(width: 16)
      image
      Spacer().frame(width: 14)
      name
      Spacer()
      favoriteButton
      Spacer().frame(width: 16)
    }
    .padding(.vertical, 20)
    .background(Color.white)
    .clipShape(RoundedRectangle(cornerRadius: 24))
  }
  
  private var image: some View {
    AsyncImage(url: URL(string: model.image ?? "")) { phase in
      if let image = phase.image {
        image
          .resizable()
      } else if phase.error != nil {
        Image(systemName: "gift.circle")
          .resizable()
          .foregroundStyle(.lightPink)
      } else {
        SkeletonView()
      }
    }
    .frame(width: 70, height: 70)
    .clipShape(Circle())
    .background(
      Circle()
        .stroke(.spanishGray, lineWidth: 1)
    )
  }
  
  private var name: some View {
    Text(model.name ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold20)
      .lineLimit(nil)
  }
  
  private var favoriteButton: some View {
    Button {
      model.isFavorite?.toggle()
    } label: {
      Image(systemName: model.isFavorite ?? false ? "heart.fill" : "heart")
        .resizable()
        .foregroundStyle(.bubblegumPink)
        .frame(width: 24, height: 24)
    }
  }
  
}

#Preview {
  ShopCell(
    model: .constant(Shop(
      id: 1,
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh2iqPBVW415Fm46oaLkdPKSp21VFDpm3Aug&s",
      address: "8 Vahram Papazyan St, Yerevan 0012",
      isFavorite: false,
      name: "Rio Mall",
      phone: "(011) 281888",
      rate: 12,
      url: "https://riomall.am/public/"
    ))
  )
}
