//
//  RatingView.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import BirthDayAPI
import SwiftUI

struct RatingView: View {
  
  @State private var isAnimating = false
  @State private var isRotating = false
  @Binding var rating: Double?
  
  var action: () -> ()
  let model: Shop
  var maxRating: Int = 5
  var isLoading: Bool = false

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
    .onChange(of: isLoading) { isLoading in
      if isLoading {
        withAnimation(.easeInOut(duration: 0.3)) {
          isAnimating = true
        }
        withTransaction(Transaction(animation: .linear(duration: 2).repeatForever(autoreverses: false))) {
          isRotating = true
        }
      } else {
        withAnimation(.linear(duration: 0.3)) {
          isRotating = false
        }
        withTransaction(Transaction(animation: .easeInOut(duration: 0.3).delay(0.4))) {
          isAnimating = false
        }
      }
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
      ForEach(1 ... maxRating, id: \.self) { index in
        starImage
          .offset(isAnimating ? calculateOffset(for: index) : .zero)
      }
    }
    .rotationEffect(.degrees(self.isRotating ? 360 : -360))
  }

  private var starButtons: some View {
    HStack(spacing: 4) {
      ForEach(1 ... maxRating, id: \.self) { index in
        Button {
          rating = Double(index)
          action()
        } label: {
          starImage
            .foregroundStyle(.clear)
        }
      }
    }
  }

  func calculateOffset(for index: Int) -> CGSize {
    guard index > 0 && index < 6 else { return .zero }
    if index == 1 || index == 5 {
      return .init(width: index == 1 ? 28 : -28, height: -4)
    } else if index == 2 || index == 4 {
      return .init(width: index == 2 ? 10 : -10, height: 20)
    } else {
      return .init(width: 0, height: -20)
    }
  }
  
}

#Preview {
  RatingView(
    rating: .constant(3.5),
    action: {},
    model: Shop.mockShop,
    maxRating: 5,
    isLoading: true
  )
}
