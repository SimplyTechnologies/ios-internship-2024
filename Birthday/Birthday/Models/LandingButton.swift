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
  var cornerRadius: [CGFloat]

  var body: some View {
    Button(action: action) {
      HStack {
        Spacer()
        Text(title)
          .font(.system(size: 20))
          .padding()
          .foregroundStyle(textColor)
        Spacer()
      }
      .background(backgroundColor)
      .clipShape(
        .rect(
          topLeadingRadius: cornerRadius[0],
          bottomLeadingRadius: cornerRadius[1],
          bottomTrailingRadius: cornerRadius[2],
          topTrailingRadius: cornerRadius[3]
        )
      )
    }
  }

}

#Preview {
  LandingButton(
    title: String.Button.register,
    textColor: .lightPink,
    backgroundColor: .rouge,
    action: { },
    cornerRadius: [42, 0, 42, 42]
  )
}
