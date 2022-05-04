//
//  NicePhotoApp.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 28/04/22.
//

import SwiftUI
import Bagel
import Firebase

@main
struct NicePhotoApp: App {

    @StateObject var userViewModel = UserViewModel()

    init() {
        setupAuthentication()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
                .environmentObject(userViewModel)
            }.accentColor(.black)
        }
    }

    private func setupAuthentication() {
       FirebaseApp.configure()
        Bagel.start()
     }
}
