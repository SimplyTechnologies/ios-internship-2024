//
//  HomeViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 22.10.24.
//

import Foundation

protocol HomeViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  var error: Error? { get set }
  var birthDays: [BirthdayModel] { get set }
  
  func getBirthDays()
  
}
