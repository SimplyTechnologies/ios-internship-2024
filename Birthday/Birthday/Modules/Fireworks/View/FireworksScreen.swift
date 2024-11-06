//
//  FireworksScreen.swift
//  Birthday
//
//  Created by Narek on 06.11.24.
//

import SwiftUI

struct FireworksScreen<T: FireworksViewModeling>: View {
  
  @StateObject var viewModel: T
  @EnvironmentObject var appState: AppState
  @Environment(\.dismiss) var dismiss

  var body: some View {
    ZStack {
      Color.lightPink.ignoresSafeArea()
        ZStack {
          if viewModel.canAnimateCongratulations {
            animatedView
          } else {
            speechView
              .padding(.horizontal, 24)
          }
          
          VStack(spacing: 0) {
            HStack(spacing: 0) {
              Spacer()
              closeButton
            }
            .padding()
            Spacer()
          }
        }
    }
    .onAppear {
      appState.profileTapCount = 0
    }
  }
  
  private var animatedView: some View {
    ZStack {
      ForEach(0 ..< 200) { i in
        Text(viewModel.smiles.randomElement() ?? "🎉")
          .rotationEffect(.degrees(Double(i) * 3.6))
          .opacity(viewModel.isAnimating ? 0 : 1)
          .scaleEffect(viewModel.isAnimating ? 0.1 : 1)
          .offset(x: viewModel.isAnimating ? .random(in: -300...300) : 0,
                  y: viewModel.isAnimating ? .random(in: -700...700) : 0)
          .animation(.easeOut(duration: 2)
            .repeatForever(autoreverses: false)
            .delay(Double(i) * 0.004), value: viewModel.isAnimating)
      }
    }
    .onAppear {
      viewModel.isAnimating = true
    }
  }
  
  private var speechView: some View {
    VStack(spacing: 24) {
      Image(systemName: "rainbow")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .symbolEffect(.variableColor.reversing)
        .symbolRenderingMode(.multicolor)
        .frame(width: 150)
        .foregroundStyle(.rouge)
      
      Text(viewModel.text)
        .foregroundStyle(.rouge)
        .karmaFont(style: .regular16)
        .lineLimit(nil)
        .multilineTextAlignment(.center)

      recordingButton
    }
    .animation(.default, value: viewModel.isRecording)
  }
  
  private var recordingButton: some View {
    Button {
      if viewModel.isRecording {
        viewModel.stopRecording()
      } else {
        viewModel.startRecording()
      }
    } label: {
      Image(systemName: viewModel.isRecording ? "waveform.slash" : "waveform")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundStyle(.white)
        .padding()
        .background(Color.rouge)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
  }
  
  private var closeButton: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "xmark")
        .resizable()
        .frame(width: 24, height: 24)
        .foregroundStyle(.rouge)
    }
  }
  
}

#Preview {
  FireworksScreen(viewModel: FireworksViewModel())
    .environmentObject(AppState())
}
