//
//  AppState.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Foundation
import Pulse
import PulseProxy

final class AppState: ObservableObject {
  
  @Published var isShowMessage: Bool = false
  @Published var message: String = ""
  @Published var isSuccessMessage: Bool = false
  @Published var isUserLogedIn: Bool = AppController.shared.status == .authenticated
  @Published var isShowLogger: Bool = false
  
  @MainActor
  func setupNetworkLogger() {
    #if DEBUG
    URLSessionProxyDelegate.enableAutomaticRegistration()
    RemoteLogger.shared.isAutomaticConnectionEnabled = true
    #endif
  }
  
}
