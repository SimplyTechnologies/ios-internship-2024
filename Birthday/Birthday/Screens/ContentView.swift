//
//  ContentView.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import Apollo
import BirthDayAPI
import SwiftUI

struct ContentView: View {
  
  private enum Screen: Hashable {
    case login
    case registration
  }

  @StateObject var router = NavigationRouter()

  var body: some View {
    NavigationStack(path: $router.path) {
      VStack {
        Button {
          router.push(Screen.login)
        } label: {
          Text("Login")
        }

        Button {
          router.push(Screen.registration)
        } label: {
          Text("Registration")
        }
      }
      .padding()
      .onAppear {
        GraphQLRepository(apollo: Network.shared.apollo).performQuery(query: GetBirthDayListQuery()) { res in
          print(res)
        }
      }
      .navigationDestination(for: Screen.self) { screen in
        switch screen {
        case .login: Text("Login Screen")
        case .registration: RegistrationScreen(viewModel: RegistrationViewModel(router: router))
        }
      }
    }
  }
  
}

#Preview {
  ContentView()
}
