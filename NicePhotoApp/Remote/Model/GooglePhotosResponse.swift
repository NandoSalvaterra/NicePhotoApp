//
//  GooglePhotosResponse.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Foundation

class GooglePhotosResponse: Decodable {

    var mediaItems: [GooglePhoto]?
    var nextPageToken: String?

    private enum CodingKeys: String, CodingKey {
        case mediaItems = "mediaItems"
        case nextPageToken = "nextPageToken"
    }
}
