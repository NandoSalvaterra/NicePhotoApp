//
//  GooglePhoto.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Foundation

class GooglePhoto: Decodable {

    var id: String?
    var mimeType: String?
    var baseUrl: String?
    var productUrl: String?
    var fileName: String?
    var mediaMetadata: MediaMetadata?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case mimeType = "mimeType"
        case baseUrl = "baseUrl"
        case productUrl = "productUrl"
        case fileName = "filename"
        case mediaMetadata = "mediaMetadata"
    }
}

