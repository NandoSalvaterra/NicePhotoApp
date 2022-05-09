//
//  SavePhotoInGalleryUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine


class SavePhotoInGalleryUseCase: SavePhotoInGalleryUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(image: UIImage) -> AnyPublisher<Bool, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return savePhotoInGallery(image: image)
    }

    // MARK: - Private API

    private func savePhotoInGallery(image: UIImage) -> AnyPublisher<Bool, PhotosError> {
        return repository.savePhotoInGallery(image: image)
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
