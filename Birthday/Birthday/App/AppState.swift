//
//  AppState.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Foundation
import Pulse
import PulseProxy
import SwiftUI

final class AppState: ObservableObject {
  
  @Published var isShowMessage: Bool = false
  @Published var message: String = ""
  @Published var isSuccessMessage: Bool = false
  @Published var isUserLogedIn: Bool = AppController.shared.status == .authenticated
  @Published var isShowLogger: Bool = false
  @Published var isShowPopup: Bool = false
  @Published var popupContent: AnyView?
  
  @MainActor
  func setupNetworkLogger() {
    #if DEBUG
    URLSessionProxyDelegate.enableAutomaticRegistration()
    RemoteLogger.shared.isAutomaticConnectionEnabled = true
    #endif
  }
  
  func showPopup(_ popupContent: () -> AnyView) {
    self.popupContent = popupContent()
    isShowPopup = true
  }
  
  func hidePopup() {
    isShowPopup = false
    self.popupContent = nil
  }
  
}
