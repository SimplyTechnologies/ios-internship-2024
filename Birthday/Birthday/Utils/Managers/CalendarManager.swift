//
//  CalendarManager.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 28.10.24.
//

import Foundation
import EventKit

class CalendarManager {
  
  static let shared = CalendarManager()
  
  private init() { }
  
  func addEventAction(event: Eventable) {
    let title = "\(event.name ?? "")'s Birthday"
    let date = event.date?.toDate?.getNextOccurrence() ?? Date()
    let duration = TimeInterval(integerLiteral: 3600 * 24)
    requestCalendarAccess { granted in
      if granted {
        self.addEventToCalendar(title: title, date: date, duration: duration)
      } else {
        Console.log("Calendar access denied")
      }
    }
  }
  
  private func requestCalendarAccess(completion: @escaping (Bool) -> Void) {
    let eventStore = EKEventStore()
    eventStore.requestAccess(to: .event) { granted, error in
      DispatchQueue.main.async {
        completion(granted)
      }
    }
  }
  
  private func addEventToCalendar(title: String, date: Date, duration: TimeInterval) {
    let eventStore = EKEventStore()
    let event = EKEvent(eventStore: eventStore)
    event.title = title
    event.startDate = date
    event.endDate = date.addingTimeInterval(duration)
    event.calendar = eventStore.defaultCalendarForNewEvents
    do {
      try eventStore.save(event, span: .thisEvent)
      Console.log("Event added to calendar")
    } catch let error {
      Console.log("Error saving event: \(error)")
    }
  }
  
}
