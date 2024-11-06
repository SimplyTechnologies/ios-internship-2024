//
//  FireworksViewModel.swift
//  Birthday
//
//  Created by Narek on 06.11.24.
//

import AVFoundation
import Speech

final class FireworksViewModel: FireworksViewModeling {
  
  @Published var isRecording = false
  @Published var isAnimating = false
  @Published var recognizedText = ""

  private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
  private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  private var recognitionTask: SFSpeechRecognitionTask?
  private let audioEngine = AVAudioEngine()
  
  var canAnimateCongratulations: Bool {
    recognizedText.lowercased().contains("congratulations")
  }
  
  var smiles: [String] {
    ["🎉", "🎊", "🍾", "🙌", "🥳", "😎", "🎂"]
  }
  
  var text: String {
    let defaultText = String.Firework.congratulations
    return recognizedText.isEmpty ? defaultText : recognizedText
  }

  func startRecording() {
    guard let speechRecognizer = speechRecognizer, speechRecognizer.isAvailable else {
      return
    }

    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

    guard let recognitionRequest = recognitionRequest else {
      Console.log("❌ Unable to create a recognition request")
      return
    }

    recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, _ in
      if let result = result {
        DispatchQueue.main.async {
          self.recognizedText = result.bestTranscription.formattedString
        }
      }
    }

    let recordingFormat = audioEngine.inputNode.inputFormat(forBus: 0)
    audioEngine.inputNode.removeTap(onBus: 0)
    audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
      recognitionRequest.append(buffer)
    }

    audioEngine.prepare()

    do {
      try audioEngine.start()
      isRecording = true
    } catch {
      print("Audio engine failed to start: \(error.localizedDescription)")
    }
  }

  func stopRecording() {
    audioEngine.stop()
    audioEngine.inputNode.removeTap(onBus: 0)
    recognitionRequest?.endAudio()
    recognitionTask?.cancel()
    isRecording = false
  }
  
}
