//
//  BirthDayDetailsViewModeling.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 23.10.24.
//

import Foundation

protocol  BirthDayDetailsViewModeling: ObservableObject {
  
  var isLoading: Bool { get set }
  var deleteAction: () -> () { get set }
  var updateAction: (BirthdayModel) -> () { get set}

  
  func updateBirthday(payload: BirthdayUpdatePayload, birthday: BirthdayModel)
  func deleteBirthDay(id: Int, complition: @escaping () -> ())
  
}
