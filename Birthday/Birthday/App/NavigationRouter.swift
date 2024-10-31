//
//  NavigationRouter.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

enum RouterType: String, Hashable {
  
  case auth = "Auth"
  case home = "Home"
  case shop = "Shop"
  case profile = "Profile"
  
}

protocol Routable: ObservableObject {
  
  var path: NavigationPath { get set }
  var type: RouterType { get }
  
  func push(_ screen: any Hashable)
  func pop()
  func popToRoot()
  func resetNavigation(with destinations: [any Hashable])
  
}

class NavigationRouter: Routable {
  
  init(_ type: RouterType) {
    self.type = type
  }
  
  var type: RouterType
  
  @Published var path = NavigationPath() {
    didSet {
      Console.log("\(type.rawValue)Router navigationPath size \(path.count)")
    }
  }
    
  func resetNavigation(with destinations: [any Hashable]) {
    path = NavigationPath()
    destinations.forEach { destination in
      path.append(destination)
    }
  }

  func push(_ screen: any Hashable) {
    path.append(screen)
  }

  func pop() {
    path.removeLast()
  }

  func popToRoot() {
    path.removeLast(path.count)
  }
  
}
