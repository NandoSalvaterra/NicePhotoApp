//
//  PhotosRepositoryProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import UIKit
import Combine

protocol PhotosRepositoryProtocol {

    func getGalleryPhotos() -> AnyPublisher<[Photo], RepositoryError>
    func getGooglePhotos(token: String) -> AnyPublisher<[Photo], RepositoryError>
    func getFavoritePhotos() -> AnyPublisher<[Photo], RepositoryError>
    func favoritePhoto(_ photo: Photo) -> AnyPublisher<Bool, RepositoryError>
    func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, RepositoryError>
    func downloadPhoto(url: URL) -> AnyPublisher<UIImage, RepositoryError>
    func checkDuplicatedPhoto(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), RepositoryError>
    func savePhotoInGallery(image: UIImage) -> AnyPublisher<Bool, RepositoryError>
    func getLastSavedPhotoInGallery() -> AnyPublisher<Photo, RepositoryError>
}
