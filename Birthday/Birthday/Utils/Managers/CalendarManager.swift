//
//  CalendarManager.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 28.10.24.
//

import EventKit
import EventKitUI
import Foundation
import SwiftUI

struct EventEditViewController: UIViewControllerRepresentable {
  
  @Environment( \.dismiss) var dismiss
  @Binding var birthday: BirthdayModel
  
  let eventStore: EKEventStore
  
  func makeUIViewController(context: Context) -> EKEventEditViewController {
    let controller = EKEventEditViewController()
    controller.eventStore = eventStore
    var event = EKEvent(eventStore: eventStore)
    event.startDate = birthday.date?.toDate?.getNextOccurrence()
    event.endDate = birthday.date?.toDate?.getNextOccurrence()?.addingTimeInterval(TimeInterval(integerLiteral: 3600*24))
    event.title = "\(birthday.name ?? "")'s Birthday"
    controller.event = event
    
    controller.editViewDelegate = context.coordinator
    return controller
  }
  
  func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) { }
  
  func makeCoordinator() -> Coordinator {
    return Coordinator(self)
  }
  
  class Coordinator: NSObject, EKEventEditViewDelegate {
    
    var parent: EventEditViewController
    
    init(_ controller: EventEditViewController) {
      self.parent = controller
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
      parent.dismiss ()
    }
    
  }
  
}
