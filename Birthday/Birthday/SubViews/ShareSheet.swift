//
//  ShareSheet.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 28.10.24.
//

import UIKit
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
  
  @Binding var message: String
  var completion: ((Bool) -> Void)?
  
  func makeUIViewController(context: Context) -> UIActivityViewController {
    let controller = UIActivityViewController(
      activityItems: [message],
      applicationActivities: nil
    )
    controller.completionWithItemsHandler = { _, completed, _, _ in
      completion?(completed)
    }
    return controller
  }
  
  func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) { }
  
}
