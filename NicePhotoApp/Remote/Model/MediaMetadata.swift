//
//  MediaMetadata.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Foundation

class MediaMetadata: Decodable {

    var creationTime: Date?
    var width: String?
    var height: String?

    private enum CodingKeys: String, CodingKey {
        case creationTime = "creationTime"
        case width = "width"
        case height = "height"
    }
}
