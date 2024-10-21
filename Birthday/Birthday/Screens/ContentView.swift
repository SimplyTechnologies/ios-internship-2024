//
//  ContentView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(String.Button.login)
                .foregroundStyle(.black)
                .padding()
                .background(Color.lightGreen)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
