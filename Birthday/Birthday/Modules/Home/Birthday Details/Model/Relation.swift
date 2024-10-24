//
//  Relation.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation

enum Relationship: CaseIterable, Hashable {
    
  case bestFriend
  case mother
  case father
  case sister
  case brother
  case grandmother
  case grandfather
  case uncle
  case friend
  case custom(name: String)
  
  static var allCases: [Relationship] = [.bestFriend,.mother,.father,.sister,.brother,.grandfather,.grandmother,.uncle,.friend]
  
  var rawValue: String {
    switch self {
    case .bestFriend:
      return "Best Friend"
    case .mother:
      return "Mother"
    case .father:
      return "Father"
    case .sister:
      return "Sister"
    case .brother:
      return "Brother"
    case .grandmother:
      return "Grandmother"
    case .grandfather:
      return "Grandfather"
    case .uncle:
      return "Uncle"
    case .friend:
      return "Friend"
    case .custom(let name):
      return name
    }
  }
  
  init?(rawValue: String) {
    switch rawValue {
    case "Best Friend":
      self = .bestFriend
    case "Mother":
      self = .mother
    case "Father":
      self = .father
    case "Sister":
      self = .sister
    case "Brother":
      self = .brother
    case "Grandmother":
      self = .grandmother
    case "Grandfather":
      self = .grandfather
    case "Uncle":
      self = .uncle
    case "Friend":
      self = .friend
    default:
      self = .custom(name: rawValue)
    }
  }
  
  static func getAllCases() -> [Relationship] {
    return Self.allCases
  }
  
}
