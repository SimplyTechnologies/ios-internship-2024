//
//  SkeletonView.swift
//  Birthday
//
//  Created by Narek on 24.10.24.
//

import SwiftUI

struct SkeletonView: View {

  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .fill(Color.piggyPink)
      .redacted(reason: .placeholder)
      .skeletonEffect(
        isLoading: .constant(true),
        gradient: Gradient(colors: [
          Color.piggyPink,
          Color.bubblegumPink,
          Color.piggyPink,
        ])
      )
  }
  
}

#Preview {
    SkeletonView()
}
