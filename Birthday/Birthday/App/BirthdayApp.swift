//
//  BirthdayApp.swift
//  Birthday
//
//  Created by MEKHAK GHAPANTSYAN on 21.10.24.
//

import SwiftUI

@main
struct BirthdayApp: App {
    var body: some Scene {
        WindowGroup {
          BirthdayDetailsScreen(viewModel:BirthdayDetailsViewModel(homeRepository: HomeDefaultRepository()), birthdayData: BirthdayModel(createdAt: "", date: "2024-10-22T09:23:54.000Z", id: 15, image: "https://randomuser.me/api/portraits/med/women/3.jpg", message: "Be happy", name: "John", relation: "Friend", upcomingAge: 10, upcomingBirthday: "", updatedAt: "", userId: 1))
//            ContentView()
        }
    }
}
