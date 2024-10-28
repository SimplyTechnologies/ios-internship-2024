//
//  BirthdayApp.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import SwiftUI

@main
struct BirthdayApp: App {
  
  @StateObject private var appState = AppState()

  var body: some Scene {
    WindowGroup {
      ZStack {
        if appState.isUserLogedIn {
          TabBarView()
        } else {
          LandingScreen()
        }
      }
      .environmentObject(appState)
    }
  }
  
}
