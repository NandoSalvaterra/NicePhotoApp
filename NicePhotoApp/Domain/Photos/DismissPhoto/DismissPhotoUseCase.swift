//
//  DismissPhotoUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import Foundation
import Combine

class DismissPhotoUseCase: DismissPhotoUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(photo: Photo) -> AnyPublisher<Bool, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return dismissPhoto(photo)
    }

    // MARK: - Private API

    private func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, PhotosError> {
        return repository.dismissPhoto(photo)
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
