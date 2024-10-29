//
//  CircularImage.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct CircularImage<Placeholder: View>: View {
  
  var image: Image?
  let imagePath: String
  var placeholderView: Placeholder?
  var placeholderImage: Image = .init(systemName: "gift.circle")
  var borderColor: Color = .spanishGray
  var borderWidth: CGFloat = 1
  var backgroundColor: Color = .clear
  var size: CGSize = .init(width: 70, height: 70)

  init(
    image: Image? = nil,
    imagePath: String,
    @ViewBuilder placeholderView: () -> Placeholder? = { EmptyView() },
    placeholderImage: Image = Image(systemName: "gift.circle"),
    borderColor: Color = .spanishGray,
    borderWidth: CGFloat = 1,
    backgroundColor: Color = .clear,
    size: CGSize = .init(width: 70, height: 70)
  ) {
    self.image = image
    self.imagePath = imagePath
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
        AsyncImage(url: URL(string: imagePath)) { phase in
          if let image = phase.image {
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .clipShape(Circle())
            
          } else if phase.error != nil {
            if placeholderView is EmptyView {
              placeholderImage
                .resizable()
                .foregroundStyle(.piggyPink)
                .clipShape(Circle())
                .padding(borderWidth)
            } else {
              placeholderView
            }
          } else {
            SkeletonView()
          }
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
