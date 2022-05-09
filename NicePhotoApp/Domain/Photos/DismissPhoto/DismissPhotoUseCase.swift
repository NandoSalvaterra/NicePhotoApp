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

    func execute() -> AnyPublisher<String, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return dismissPhoto()
    }

    // MARK: - Private API

    private func dismissPhoto() -> AnyPublisher<String, PhotosError> {
        return repository.dismissPhoto()
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
