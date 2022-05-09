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
    private let dismissedGalleryPhotoIdsKey = "dismissedGalleryPhotoIdsKey"
    private let dismissedGooglePhotoIdsKey = "dismissedGooglePhotoIdsKey"

    private init() {}

    var onboardingViewAlreadySeen: Bool {
        get { return userDefaults.bool(forKey: onboardingViewAlreadySeenKey) }
        set { userDefaults.set(newValue, forKey: onboardingViewAlreadySeenKey) }
    }

    func saveDismissedGalleryPhotoId(_ id: String) {
        var photoIds = getDismissedGalleryPhotoIds()
        photoIds.append(id)
        saveGalleryPhotoIds(photoIds)
    }

    func saveDismissedGooglePhotoId(_ id: String) {
        var photoIds = getDismissedGooglePhotoIds()
        photoIds.append(id)
        saveGooglePhotoIds(photoIds)
    }

    func getDismissedGalleryPhotoIds() -> [String] {
        if let ids = userDefaults.object(forKey: dismissedGalleryPhotoIdsKey) as? [String] {
            return ids
        } else {
            return []
        }
    }

    func getDismissedGooglePhotoIds() -> [String] {
        if let ids = userDefaults.object(forKey: dismissedGooglePhotoIdsKey) as? [String] {
            return ids
        } else {
            return []
        }
    }

    // MARK: - Private API

    private func saveGalleryPhotoIds(_ ids: [String]) {
        userDefaults.set(ids, forKey: dismissedGalleryPhotoIdsKey)
    }

    private func saveGooglePhotoIds(_ ids: [String]) {
        userDefaults.set(ids, forKey: dismissedGooglePhotoIdsKey)
    }
}
