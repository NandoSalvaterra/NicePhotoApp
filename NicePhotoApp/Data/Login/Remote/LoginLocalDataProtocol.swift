//
//  LoginLocalDataProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation
import Combine
import GoogleSignIn

protocol LoginLocalDataProtocol {

    func getCachedUser() -> AnyPublisher<GIDGoogleUser, LocalDataError>

}
