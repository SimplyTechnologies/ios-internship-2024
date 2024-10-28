//
//  BirthdayApp.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Pulse
import PulseProxy
import PulseUI
import SwiftUI

@main
struct BirthdayApp: App {
  
  @Environment(\.scenePhase) var scenePhase
  @State private var isShowLogger: Bool = false

  var body: some Scene {
    WindowGroup {
      ContentView()
        .onChange(of: scenePhase) { newPhase in
          if newPhase == .active {
            setupNetworkLogger()
          }
        }
        .sheet(isPresented: $isShowLogger) {
          NavigationStack { ConsoleView() }
        }
        .onShake {
          #if DEBUG
          isShowLogger = true
          #endif
        }
    }
  }

  private func setupNetworkLogger() {
    #if DEBUG
    URLSessionProxyDelegate.enableAutomaticRegistration()
    NetworkLogger.enableProxy()
    RemoteLogger.shared.isAutomaticConnectionEnabled = true
    #endif
  }
  
}
