//
//  ContentView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import SwiftUI
import Apollo
import BirthDayAPI

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
        .onAppear {
          GraphQLRepository(apollo: Network.shared.apollo).performQuery(query: GetBirthDayListQuery()) { res in
            print(res)
          }
        }
    }
}

#Preview {
    ContentView()
}
