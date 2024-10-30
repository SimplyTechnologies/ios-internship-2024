//
//  BirthdayApp.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import PopupView
import PulseUI
import SwiftUI

@main
struct BirthdayApp: App {
  
  @StateObject private var appState = AppState()
  @Environment(\.scenePhase) var scenePhase

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
      .onChange(of: scenePhase) { newPhase in
        if newPhase == .active {
          appState.setupNetworkLogger()
        }
      }
      .sheet(isPresented: $appState.isShowLogger) {
        NavigationStack { ConsoleView() }
      }
      .onShake {
        #if DEBUG
        appState.isShowLogger = true
        #endif
      }
      .popup(isPresented: $appState.isShowMessage) {
        toastView
      } customize: {
        $0
          .type(.floater())
          .position(.bottom)
          .animation(.spring())
          .dragToDismiss(true)
          .autohideIn(4)
      }
    }
  }
  
  private var toastView: some View {
    ToastView(
      isShow: $appState.isShowMessage,
      title: appState.message,
      toastType: appState.isSuccessMessage ? .success : .error
    )
  }
  
}
