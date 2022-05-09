//
//  LoginLocalData.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Combine
import GoogleSignIn

class LoginLocalData: LoginLocalDataProtocol {

    func getCachedUser() -> AnyPublisher<GIDGoogleUser, LocalDataError> {
        return Future { promise in
            GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                if let googleUser = user {
                    promise(.success(googleUser))
                } else {
                    promise(.failure(.invalidData))
                }
            }
        }.eraseToAnyPublisher()
    }
}
