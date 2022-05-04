//
//  OnboardItem.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import Foundation

enum OnboardingItem: CaseIterable, Hashable {

    case howAppWorks
    case favoritePhotos
    case deletePhotos

    func getImageName() -> String {
        switch self {
        case .howAppWorks:
            return "photos_image"
        case .favoritePhotos:
            return "favorite_image"
        case .deletePhotos:
            return "delete_image"
        }
    }

    func getTextMessage() -> String {
        switch self {
        case .howAppWorks:
            return "how_app_works".localized
        case .favoritePhotos:
            return "favorite_photos".localized
        case .deletePhotos:
            return "delete_photos".localized
        }
    }
}
