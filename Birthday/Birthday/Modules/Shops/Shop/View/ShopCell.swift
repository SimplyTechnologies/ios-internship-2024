//
//  ShopCell.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import SwiftUI

struct ShopCell: View {
  
  @State private var scale: CGFloat = 1.0
  var model: Shop

  var isLoading: Bool
  var favoriteAction: () -> Void
  
  var body: some View {
    content
  }
  
}

extension ShopCell {
  
  private var content: some View {
    HStack(spacing: 0) {
      image
        .padding(.leading, 16)
      name
        .padding(.leading, 14)
      Spacer()
      favoriteButton
        .padding(.trailing, 16)
    }
    .padding(.vertical, 20)
  }
  
  private var image: some View {
    SkeletonImage(
      imagePath: model.image ?? "",
      borderColor: .clear
    )
  }
  
  private var name: some View {
    Text(model.name ?? "")
      .foregroundStyle(.black)
      .karmaFont(style: .bold20)
      .lineLimit(nil)
  }
  
  private var favoriteButtonContent: some View {
    Image(systemName: model.isFavorite ?? false ? "heart.fill" : "heart")
      .resizable()
      .foregroundStyle(.bubblegumPink)
      .frame(width: 24, height: 24)
      .scaleEffect(isLoading ? scale : 1)
      .onAppear {
        let baseAnimation = Animation.easeInOut(duration: 0.7)
        let repeated = baseAnimation.repeatForever(autoreverses: true)
        withAnimation(repeated) {
          scale = 1.5
        }
      }
  }
  
  private var favoriteButton: some View {
    Button {
      favoriteAction()
    } label: {
      favoriteButtonContent
    }
    .disabled(isLoading)
  }
  
}

#Preview {
  ShopCell(
    model: Shop.mockShop,
    isLoading: true,
    favoriteAction: {}
  )
}
