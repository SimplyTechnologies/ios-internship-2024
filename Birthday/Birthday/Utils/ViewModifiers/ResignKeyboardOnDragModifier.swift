//
//  ResignKeyboardOnDragModifier.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

struct ResignKeyboardOnDragModifier: ViewModifier {
  
  var gesture = DragGesture().onChanged { _ in
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }

  func body(content: Content) -> some View {
    content.gesture(gesture)
  }
  
}
