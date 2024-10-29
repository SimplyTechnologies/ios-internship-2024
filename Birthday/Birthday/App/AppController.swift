//
//  AppController.swift
//  Birthday
//
//  Created by Narek on 28.10.24.
//

import Combine
import Foundation

enum LogoutType {
  
  case `default`
  case unauthenticated
  case blocked
  
}

final class AppController: ObservableObject {
  
  enum Status {
    
    case authenticated
    case unauthenticated
    
  }

  private init() {
    self.status = UserDefaults.accessToken.isNil ? .unauthenticated : .authenticated
  }

  static var shared = AppController()

  @Published var status: Status
  @Published var logoutType: LogoutType = .default

  var environment: AppEnvironment {
    #if DEBUG
    return .development
    #else
    return .production
    #endif
  }

  func logOut(_ logoutType: LogoutType = .default) {
    UserDefaults.accessToken = nil
    status = .unauthenticated
    self.logoutType = logoutType
  }

  func setLogedIn(_ token: String) {
    UserDefaults.accessToken = token
    AppController.shared.status = .authenticated
  }
  
}
