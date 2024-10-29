//
//  AppState.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Foundation

final class AppState: ObservableObject {
  
  @Published var isShowMessage: Bool = false
  @Published var message: String = ""
  @Published var isSuccessMessage: Bool = false
  @Published var isUserLogedIn: Bool = AppController.shared.status == .authenticated
  
}
