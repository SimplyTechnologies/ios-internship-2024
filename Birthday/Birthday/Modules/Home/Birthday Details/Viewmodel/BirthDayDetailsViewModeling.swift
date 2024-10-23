//
//  BirthDayDetailsViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation

protocol  BirthDayDetailsViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  
  func updateBirthday(payload: BirthdayUpdatePayload)
  func deleteBirthDay(id: Int)
  
}
