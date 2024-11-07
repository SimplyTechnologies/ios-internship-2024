//
//  NavigationBar.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct NavigationBar: View {
  
  var backButtonAction: (() -> Void)?

  var body: some View {
    HStack(spacing: 0) {
      if backButtonAction.isNotNil {
        backButton
          .padding(.leading, 38)
      }
      Spacer()
      Image(.birth)
        .padding(.trailing, backButtonAction.isNotNil ? 54 : 0)
      Spacer()
    }
  }

  var backButton: some View {
    Button {
      backButtonAction?()
    } label: {
      Image(.back)
        .resizable()
        .frame(width: 16, height: 24)
    }
  }
  
}

#Preview {
  NavigationBar {}
}
