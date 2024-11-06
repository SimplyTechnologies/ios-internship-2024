//
//  ToastView.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import SwiftUI

extension ToastView {
  
  enum ToastType {
    
    case error
    case success

    var image: Image {
      switch self {
      case .error: Image(.error)
      case .success: Image(.success)
      }
    }
    
  }
  
}

struct ToastView: View {
  
  @Binding var isShow: Bool
  var title: String
  var toastType: ToastType = .error

  var body: some View {
    HStack(spacing: 0) {
      toastType.image
        .resizable()
        .frame(width: 20, height: 20)

      Text(title)
        .foregroundStyle(Color.rouge)
        .karmaFont(style: .regular16)
        .lineLimit(4)
        .padding(.leading, 12)

      Spacer()
    }
    .padding(16)
    .background(Color.piggyPink)
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .padding(.horizontal, 16)
    .compositingGroup()
    .shadow(color: .black.opacity(0.25), radius: 12, x: -8, y: 8)
  }
  
}

#Preview {
  ToastView(
    isShow: .constant(true),
    title: "title"
  )
}
