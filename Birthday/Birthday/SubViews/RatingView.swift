//
//  RatingView.swift
//  Birthday
//
//  Created by Narek on 25.10.24.
//

import SwiftUI

struct RatingView: View {
  
  @State private var rating: Double
  
  init(rating: Double) {
    self.rating = rating
  }

  var body: some View {
    HStack(spacing: 4) {
      ForEach(1 ... 5, id: \.self) { index in
        Button(action: {
          rating = Double(index)
        }) {
          Image(systemName: "star.fill")
            .renderingMode(.template)
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundStyle(Double(index) <= rating ? .orangePeel : .spanishGray)
        }
      }
    }
  }
  
}

#Preview {
  RatingView(rating: 4)
}
