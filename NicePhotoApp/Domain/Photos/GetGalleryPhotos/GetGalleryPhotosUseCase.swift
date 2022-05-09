//
//  GetGalleryPhotosUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Combine

class GetGalleryPhotosUseCase: GetGalleryPhotosUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute() -> AnyPublisher<[Photo], PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return getGalleryPhotos()
    }

    // MARK: - Private API

    private func getGalleryPhotos() -> AnyPublisher<[Photo], PhotosError> {
        return repository.getGalleryPhotos().mapError { error in return .emptyToken}.eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
