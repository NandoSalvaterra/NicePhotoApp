//
//  DownloadPhotoUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

class DownloadPhotoUseCase: DownloadPhotoUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(url: URL) -> AnyPublisher<UIImage, PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return downloadPhoto(url: url)
    }

    // MARK: - Private API

    private func downloadPhoto(url: URL) -> AnyPublisher<UIImage, PhotosError> {
        return repository.downloadPhoto(url: url)
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
