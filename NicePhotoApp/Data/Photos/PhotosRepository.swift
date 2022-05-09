//
//  PhotosRepository.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import UIKit
import Combine

class PhotosRepository: PhotosRepositoryProtocol {
    
    let remoteData: PhotosRemoteDataProtocol
    let localData: PhotosLocalDataProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.remoteData = PhotosRemoteData()
        self.localData = PhotosLocalData()
    }
    
    func getGalleryPhotos() -> AnyPublisher<[Photo], RepositoryError> {
        return localData.getGalleryPhotos()
            .map { $0.map { .init(phAsset: $0) } }
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
    
    func getGooglePhotos(token: String) -> AnyPublisher<[Photo], RepositoryError> {
        return remoteData.getGooglePhotos(token: token)
            .map { $0.map { .init(googlePhoto: $0) } }
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
    
    func getFavoritePhotos() -> AnyPublisher<[Photo], RepositoryError> {
        return localData.getFavoritePhotos()
            .map { $0.map { .init(phAsset: $0) } }
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
    
    func favoritePhoto(_ photo: Photo) -> AnyPublisher<Bool, RepositoryError> {
        return localData.favoritePhoto(photo)
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }

    func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, RepositoryError> {
        if photo.googlePhotoURL != nil {
            return remoteData.dismissPhoto(photo)
                .mapError { .customError($0) }
                .eraseToAnyPublisher()
        } else  {
            return localData.dismissPhoto(photo)
                .mapError { .customError($0) }
                .eraseToAnyPublisher()
        }
    }

    func downloadPhoto(url: URL) -> AnyPublisher<UIImage, RepositoryError> {
        return remoteData.downloadPhoto(url: url)
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
    
    func checkDuplicatedPhoto(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), RepositoryError> {
        return localData.checkDuplicatedPhoto(image: image, fileName: fileName)
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
    
    func savePhotoInGallery(image: UIImage) -> AnyPublisher<Bool, RepositoryError> {
        return localData.savePhotoInGallery(image: image)
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }

    func getLastSavedPhotoInGallery() -> AnyPublisher<Photo, RepositoryError> {
        return localData.getLastSavedPhotoInGallery()
            .map { .init(phAsset: $0) }
            .mapError { .customError($0) }
            .eraseToAnyPublisher()
    }
}
