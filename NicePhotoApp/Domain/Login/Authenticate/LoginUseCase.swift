//
//  LoginUseCase.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 04/05/22.
//

import Foundation
import Combine
import GoogleSignIn

class LoginUseCase: LoginUseCaseProtocol {

    private let repository: LoginRepositoryProtocol

    init() { self.repository = LoginRepository() }

    func execute() -> AnyPublisher<GIDGoogleUser, LoginError> {
        let errors = validateInput()
        if !errors.isEmpty {
            return Future { promise in promise(.failure(errors.first!))}.eraseToAnyPublisher()
        }
        return authenticate()
    }

    // MARK: - Private API

    private func authenticate() -> AnyPublisher<GIDGoogleUser, LoginError> {
        return repository.authenticateUser().mapError { LoginError.internalError($0) }.eraseToAnyPublisher()
    }

    private func validateInput() -> [LoginError] {
        return []
    }
}


