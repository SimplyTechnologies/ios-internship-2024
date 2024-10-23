//
//  LandingButton.swift
//  Birthday
//
//  Created by Anna Hakobyan on 22.10.24.
//

import SwiftUI

struct LandingButton: View {

  var title: String
  var textColor: Color
  var backgroundColor: Color
  var action: () -> Void
  var cornerRadii: [CGFloat]

  var body: some View {
    Button(action: action) {
      HStack {
        Spacer()
        Text(title)
          .font(.system(size: 20))
          .padding()
          .foregroundColor(textColor)
        Spacer()
      }
      .background(backgroundColor)
      .clipShape(
        .rect(
          topLeadingRadius: cornerRadii[0],
          bottomLeadingRadius: cornerRadii[1],
          bottomTrailingRadius: cornerRadii[2],
          topTrailingRadius: cornerRadii[3]
        )
      )
    }
  }

}

#Preview {
  LandingButton(
    title: String.Button.register,
    textColor: .lightPink,
    backgroundColor: .darkRed,
    action: { },
    cornerRadii: [42, 0, 42, 42]
  )
}
