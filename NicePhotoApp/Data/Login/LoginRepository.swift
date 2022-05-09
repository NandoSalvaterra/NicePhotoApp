//
//  LoginRepository.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation
import Combine
import Firebase
import GoogleSignIn

class LoginRepository: LoginRepositoryProtocol {

    let remoteData: LoginRemoteDataProtocol
    let localData: LoginLocalDataProtocol

    init() {
        self.remoteData = LoginRemoteData()
        self.localData = LoginLocalData()
    }

    func authenticateUser() -> AnyPublisher<GIDGoogleUser, LocalDataError> {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
           return localData.getCachedUser().flatMap { user in
                self.remoteData.authenticate(user: user).mapError { _ in .invalidData }
           }.eraseToAnyPublisher()
        } else {
            return remoteData.signIn().flatMap { user in
                self.remoteData.authenticate(user: user)
            }
            .mapError { _ in .invalidData }
            .eraseToAnyPublisher()
        }
    }
}
