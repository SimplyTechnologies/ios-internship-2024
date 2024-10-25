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
    CircularImage(imagePath: model.image ?? "")
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
  ShopCell(model: .constant(Shop.mockShop))
}
