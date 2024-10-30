//
//  RatingView.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct RatingView: View {
  
  @Binding var rating: Double?

  var maxRating: Int = 5

  var body: some View {
    ZStack {
      starsView
        .overlay(
          GeometryReader { geometry in
            if let rating {
              let width = rating / CGFloat(maxRating) * geometry.size.width
              ZStack(alignment: .leading) {
                Rectangle()
                  .frame(width: width)
                  .foregroundStyle(.orangePeel)
              }
            }
          }
          .mask(starsView)
        )
        .foregroundStyle(.spanishGray)
      starButtons
    }
  }
  
  private var starImage: some View {
    Image(systemName: "star.fill")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 20, height: 20)
  }

  private var starsView: some View {
    HStack(spacing: 4) {
      ForEach(1 ... maxRating, id: \.self) { _ in
        starImage
      }
    }
  }

  private var starButtons: some View {
    HStack(spacing: 4) {
      ForEach(1 ... maxRating, id: \.self) { index in
        Button {
          rating = Double(index)
        } label: {
          starImage
            .foregroundStyle(.clear)
        }
      }
    }
  }
  
}

#Preview {
  RatingView(rating: .constant(3.6), maxRating: 5)
}
