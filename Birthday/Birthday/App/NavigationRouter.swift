//
//  NavigationRouter.swift
//  Birthday
//
//  Created by Narek on 22.10.24.
//

import SwiftUI

protocol Routable: ObservableObject {
  
    var path: NavigationPath { get set }
  
    func push(_ screen: any Hashable)
    func pop()
    func popToRoot()
    func resetNavigation(with destinations: [any Hashable])
}

class NavigationRouter: Routable {
  
    @Published var path = NavigationPath() {
        didSet {
            Console.log("Router navigationPath size \(path.count)")
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
