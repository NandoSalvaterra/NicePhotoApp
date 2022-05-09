//
//  FavoritePhotoUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import Foundation
import Combine

class FavoritePhotoUseCase: FavoritePhotoUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(photo: Photo) -> AnyPublisher<Bool, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return favoritePhoto(photo: photo)
    }

    // MARK: - Private API

    private func favoritePhoto(photo: Photo) -> AnyPublisher<Bool, PhotosError> {
        return repository.favoritePhoto(photo)
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
