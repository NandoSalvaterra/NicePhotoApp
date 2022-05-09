//
//  NicePhotoApp.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 28/04/22.
//

import SwiftUI
import Firebase

@main
struct NicePhotoApp: App {

    init() { setupAuthentication() }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UserDefaultsService.shared.onboardingViewAlreadySeen {
                    LoginView()
                } else {
                    OnboardingView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .accentColor(.black)
        }
    }

    private func setupAuthentication() {
        FirebaseApp.configure()
    }
}
