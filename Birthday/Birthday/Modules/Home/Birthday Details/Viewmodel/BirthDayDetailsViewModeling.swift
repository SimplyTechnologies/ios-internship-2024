//
//  BirthDayDetailsViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation

protocol BirthDayDetailsViewModeling: ObservableObject {
  
  var id: UUID { get }
  var isLoading: Bool { get set }
  var deleteAction: () -> () { get set }
  var updateAction: (BirthdayModel) -> () { get set}
  var birthdayData: BirthdayModel { get set }
  var isEditing: Bool { get set }
  var isGeneratingMessage: Bool { get set }
  
  func updateBirthday()
  func deleteBirthDay(id: Int, complition: @escaping () -> ())
  
}
