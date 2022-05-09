//
//  GetFavoritePhotosUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 09/05/22.
//

import Foundation
import Combine

class GetFavoritePhotosUseCase: GetFavoritePhotosUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute() -> AnyPublisher<[Photo], PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return getFavoritePhotos()
    }

    // MARK: - Private API

    private func getFavoritePhotos() -> AnyPublisher<[Photo], PhotosError> {
        return repository.getFavoritePhotos().mapError { error in return .emptyToken}.eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
