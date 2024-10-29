//
//  UIDevice+Ext.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import UIKit

extension UIDevice {
  
  static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
  
}

extension UIWindow {
  
  override open func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
    if motion == .motionShake {
      NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
    }
  }
  
}
