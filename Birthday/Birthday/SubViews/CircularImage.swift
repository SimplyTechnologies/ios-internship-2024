//
//  CircularImage.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct CircularImage<Placeholder: View>: View {
  
  let imagePath: String
  
  private let image: Image?
  private let placeholderView: Placeholder?
  private let placeholderImage: Image
  private let borderColor: Color
  private let borderWidth: CGFloat
  private let backgroundColor: Color
  private let size: CGSize

  init(
    imagePath: String,
    image: Image? = nil,
    @ViewBuilder placeholderView: () -> Placeholder? = { EmptyView() },
    placeholderImage: Image = Image(systemName: "gift.circle"),
    borderColor: Color = .spanishGray,
    borderWidth: CGFloat = 1,
    backgroundColor: Color = .clear,
    size: CGSize = .init(width: 70, height: 70)
  ) {
    self.imagePath = imagePath
    self.image = image
    self.placeholderView = placeholderView()
    self.placeholderImage = placeholderImage
    self.borderColor = borderColor
    self.borderWidth = borderWidth
    self.backgroundColor = backgroundColor
    self.size = size
  }

  var body: some View {
    ZStack {
      backgroundColor
      if let image {
        image
          .resizable()
          .aspectRatio(contentMode: .fill)
          .clipShape(Circle())
      } else {
        if let url = URL(string: imagePath) {
          AsyncImage(url: url) { phase in
            if let image = phase.image {
              image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(Circle())

            } else if phase.error != nil {
              placeholder
            } else {
              SkeletonView()
            }
          }
        } else {
          placeholder
        }
      }
    }
    .clipShape(Circle())
    .background(
      Circle()
        .stroke(borderColor, lineWidth: borderWidth)
    )
    .frame(width: size.width, height: size.height)
  }

  @ViewBuilder
  private var placeholder: some View {
    if placeholderView is EmptyView {
      placeholderImage
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: size.width * 0.7, height: size.height * 0.7)
        .foregroundStyle(Color.piggyPink)
        .padding(borderWidth)
    } else {
      placeholderView
    }
  }
  
}

#Preview {
  CircularImage(
    imagePath: "https://birthday-app-assets.s3.eu-central-1.amazonaws.com/uploads/4dbc2daa-5dfe-4dfe-90b8-d0968e704127.jpg",
    placeholderImage: Image(systemName: "person"),
    borderColor: .rouge,
    borderWidth: 3,
    size: .init(width: 160, height: 160)
  )
}
