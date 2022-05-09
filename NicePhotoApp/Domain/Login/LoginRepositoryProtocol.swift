//
//  LoginRepositoryProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation
import Combine
import Firebase
import GoogleSignIn

protocol LoginRepositoryProtocol {

    func authenticateUser() -> AnyPublisher<GIDGoogleUser, LocalDataError>
}
