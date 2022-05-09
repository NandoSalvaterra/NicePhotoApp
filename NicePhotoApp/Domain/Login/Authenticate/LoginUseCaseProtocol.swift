//
//  LoginUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 04/05/22.
//

import Foundation
import Combine
import GoogleSignIn

protocol LoginUseCaseProtocol {

    func execute() -> AnyPublisher<GIDGoogleUser, LoginError>
}
