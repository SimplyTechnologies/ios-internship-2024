//
//  DeviceShakeViewModifier.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import SwiftUI

struct DeviceShakeViewModifier: ViewModifier {
  
  let action: () -> Void

  func body(content: Content) -> some View {
    content
      .onAppear()
      .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
        action()
      }
  }
  
}
