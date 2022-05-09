//
//  CheckDuplicatedPhotoUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

class CheckDuplicatedPhotoUseCase: CheckDuplicatedPhotoUseCaseProtocol {

    private let repository: PhotosRepositoryProtocol

    init() { self.repository = PhotosRepository() }

    func execute(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), PhotosError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return checkDuplicatedPhoto(image: image, fileName: fileName)
    }

    // MARK: - Private API

    private func checkDuplicatedPhoto(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), PhotosError> {
        return repository.checkDuplicatedPhoto(image: image, fileName: fileName)
            .mapError { .custom($0) }
            .eraseToAnyPublisher()
    }

    private func validateInput() -> [PhotosError] {
        return []
    }
}
