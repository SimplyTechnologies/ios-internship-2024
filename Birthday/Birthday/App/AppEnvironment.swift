//
//  AppEnvironment.swift
//  Birthday
//
//  Created by Narek on 29.10.24.
//

import Foundation

enum AppEnvironment: String {
  
  case production
  case development

  var baseURL: String {
    switch self {
    case .production: "https://birthdayapp.store/graphql"
    case .development: "https://birthdayapp.store/graphql"
    }
  }
  
}
