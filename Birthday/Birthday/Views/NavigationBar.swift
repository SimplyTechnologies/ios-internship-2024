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
        Spacer().frame(width: 38)
        backButton
      }
      Spacer()
      Image(.birth)
      Spacer().frame(width: 24)
    }
  }

  var backButton: some View {
    Button {
      backButtonAction?()
    } label: {
      Image(.arrowBack)
        .resizable()
        .frame(width: 16, height: 24)
    }
  }
  
}

#Preview {
  NavigationBar()
}
