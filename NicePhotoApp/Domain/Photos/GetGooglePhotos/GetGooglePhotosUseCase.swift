//
//  GetGooglePhotosUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Combine

class GetGooglePhotosUseCase: GetGooglePhotosUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(token: String) -> AnyPublisher<[Photo], PhotosError> {
        let errors = validateInput(token: token)
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return getGooglePhotos(token: token)
    }

    // MARK: - Private API

    private func getGooglePhotos(token: String) -> AnyPublisher<[Photo], PhotosError> {
        return repository.getGooglePhotos(token: token).mapError { error in return .emptyToken}.eraseToAnyPublisher()
    }

    private func validateInput(token: String) -> [PhotosError] {
        var errors: [PhotosError] = []

        if token.isEmpty {
            errors.append(.emptyToken)
        }
        return errors
    }
}
