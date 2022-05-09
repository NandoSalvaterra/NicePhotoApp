//
//  PhotosLocalDataProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import UIKit
import Combine
import Photos

protocol PhotosLocalDataProtocol {

    func getGalleryPhotos() -> AnyPublisher<[PHAsset], LocalDataError>
    func getFavoritePhotos() -> AnyPublisher<[PHAsset], LocalDataError>
    func favoritePhoto(_ photo: Photo) -> AnyPublisher<Bool, LocalDataError>
    func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, LocalDataError>
    func checkDuplicatedPhoto(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), LocalDataError>
    func savePhotoInGallery(image: UIImage) -> AnyPublisher<Bool, LocalDataError>
    func getLastSavedPhotoInGallery() -> AnyPublisher<PHAsset, LocalDataError>
}
