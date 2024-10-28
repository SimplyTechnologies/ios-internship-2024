//
//  CircularImage.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct CircularImage: View {
  
  let imagePath: String
  var placeholderImage: Image = Image(systemName: "gift.circle")
  var size: CGSize = .init(width: 70, height: 70)
  
  var body: some View {
    AsyncImage(url: URL(string: imagePath)) { phase in
      if let image = phase.image {
        image
          .resizable()
      } else if phase.error != nil {
        placeholderImage
          .resizable()
          .foregroundStyle(.lightPink)
      } else {
        SkeletonView()
      }
    }
    .clipShape(Circle())
    .background(
      Circle()
        .stroke(.spanishGray, lineWidth: 1)
    )
    .frame(width: size.width, height: size.height)
  }
  
}

#Preview {
  CircularImage(imagePath: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQh2iqPBVW415Fm46oaLkdPKSp21VFDpm3Aug&s")
}
