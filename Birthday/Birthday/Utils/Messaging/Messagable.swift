//
//  Messagable.swift
//  Birthday
//
//  Created by Narek on 31.10.24.
//

import Foundation

protocol Toastable: ObservableObject {
  
  var toastMessage: String { get set }
  var isSuccessMessage: Bool { get set }
  var isShowMessage: Bool { get set }
  
  func showToast(message: String, isSuccess: Bool)
  
}

extension Toastable {
  
  func showToast(message: String, isSuccess: Bool) {
    toastMessage = message
    isSuccessMessage = isSuccess
    isShowMessage = true
  }
  
}
