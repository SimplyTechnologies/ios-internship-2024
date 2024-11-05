//
//  SkeletonImage.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI
import NukeUI

struct SkeletonImage<Placeholder: View>: View {
  
  let imagePath: String
  private let isCircular: Bool
  private let image: Image?
  private let placeholderView: Placeholder?
  private let placeholderImage: Image
  private let borderColor: Color
  private let borderWidth: CGFloat
  private let backgroundColor: Color
  private let size: CGSize

  init(
    isCircular: Bool = true,
    imagePath: String,
    image: Image? = nil,
    @ViewBuilder placeholderView: () -> Placeholder? = { EmptyView() },
    placeholderImage: Image = Image(systemName: "gift.circle"),
    borderColor: Color = .spanishGray,
    borderWidth: CGFloat = 1,
    backgroundColor: Color = .clear,
    size: CGSize = .init(width: 70, height: 70)
  ) {
    self.isCircular = isCircular
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
      } else {
        if let url = URL(string: imagePath) {
          LazyImage(url: url) { state in
              if let image = state.image {
                image
                  .resizable()
                  .aspectRatio(contentMode: .fill)
              } else if state.error != nil {
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
    .if(isCircular) { view in
      view
        .clipShape(Circle())
        .background(
          Circle()
            .stroke(borderColor, lineWidth: borderWidth)
        )
        .frame(width: size.width, height: size.height)
    }
    .if(!isCircular) { view in
      view
        .frame(
          minWidth: size.width,
          maxWidth: size.width,
          maxHeight: size.height
        )
    }
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
  SkeletonImage(
    isCircular: false,
    imagePath: "https://birthday-app-assets.s3.eu-central-1.amazonaws.com/uploads/grand-candi.jpg",
    placeholderImage: Image(systemName: "person"),
    borderColor: .rouge,
    borderWidth: 3,
    size: .init(width: 160, height: 160)
  )
}
