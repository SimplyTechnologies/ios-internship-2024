//
//  TabModel.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import SwiftUI

enum TabModel {
  
  case home
  case shops
  case addBirthday
  case profile
  
  var image: Image {
    switch self {
      case .home: Image(.homeTab)
      case .shops: Image(.shopTab)
      case .addBirthday: Image(.addTab)
      case .profile: Image(.profileTab)
    }
  }
  
}
