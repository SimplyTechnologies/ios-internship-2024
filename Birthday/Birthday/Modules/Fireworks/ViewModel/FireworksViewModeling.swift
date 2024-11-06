//
//  FireworksViewModeling.swift
//  Birthday
//
//  Created by Narek on 06.11.24.
//

import Foundation

protocol FireworksViewModeling: ObservableObject {
  
  var isRecording: Bool { get set }
  var isAnimating: Bool { get set }
  var recognizedText: String { get set }
  var canAnimateCongratulations: Bool { get }
  var smiles: [String] { get }
  var text: String { get }
  
  func startRecording()
  func stopRecording()
  
}
