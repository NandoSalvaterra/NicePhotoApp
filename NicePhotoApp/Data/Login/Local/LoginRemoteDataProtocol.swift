//
//  LoginRemoteDataProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation
import Combine
import Firebase
import GoogleSignIn

protocol LoginRemoteDataProtocol {

    func signIn() -> AnyPublisher<GIDGoogleUser, RemoteDataError>
    func authenticate(user: GIDGoogleUser) -> AnyPublisher<GIDGoogleUser, RemoteDataError>
    
}
