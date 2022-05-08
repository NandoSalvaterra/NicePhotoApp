//
//  UserDefaultsService.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 04/05/22.
//

import Foundation

class UserDefaultsService {

    static var shared = UserDefaultsService()
    private let userDefaults = UserDefaults.standard
    private let onboardingViewAlreadySeenKey = "onboardingViewAlreadySeenKey"

    private init() {}

    var onboardingViewAlreadySeen: Bool {
        get { return userDefaults.bool(forKey: onboardingViewAlreadySeenKey) }
        set { userDefaults.set(newValue, forKey: onboardingViewAlreadySeenKey) }
    }
}
