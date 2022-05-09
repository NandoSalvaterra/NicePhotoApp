//
//  Photo.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 02/05/22.
//

import UIKit
import Photos

class Photo: Identifiable, Hashable {

    var id: String
    var fileName: String?
    var googlePhotoURL: String?
    var galleryPhoto: UIImage?
    var creationDate: Date?
    var type: PhotoType

    init(id: String, fileName: String?, googlePhotoURL: String?, galleryPhoto: UIImage?, creationDate: Date?, type: PhotoType) {
        self.id = id
        self.fileName = fileName
        self.googlePhotoURL = googlePhotoURL
        self.galleryPhoto = galleryPhoto
        self.creationDate = creationDate
        self.type = type
    }

    convenience init(googlePhoto: GooglePhoto) {
        self.init(id: googlePhoto.id ?? "", fileName: googlePhoto.fileName,
                  googlePhotoURL: googlePhoto.baseUrl, galleryPhoto: nil,
                  creationDate: googlePhoto.mediaMetadata?.creationTime, type: .google)
    }

    convenience init(phAsset: PHAsset) {
        self.init(id: phAsset.localIdentifier, fileName: PHAssetResource.assetResources(for: phAsset).first!.originalFilename,
                  googlePhotoURL: nil, galleryPhoto: phAsset.getUIImage(),
                  creationDate: phAsset.creationDate, type: .gallery)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Photo {

    static var mock: Photo {
        return Photo(id: UUID().uuidString, fileName: "file_name.jpg", googlePhotoURL: "", galleryPhoto: UIImage(), creationDate: Date(), type: .google)
    }
}


