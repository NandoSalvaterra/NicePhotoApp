//
//  GetLastSavedPhotoInGalleryUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 09/05/22.
//

import Foundation
import Combine

class GetLastSavedPhotoInGalleryUseCase: GetLastSavedPhotoInGalleryUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute() -> AnyPublisher<Photo, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return getLastSavedPhotoInGallery()
    }

    // MARK: - Private API

    private func getLastSavedPhotoInGallery() -> AnyPublisher<Photo, PhotosError> {
        return repository.getLastSavedPhotoInGallery()
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
