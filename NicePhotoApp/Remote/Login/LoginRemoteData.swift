//
//  LoginRemoteData.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Combine
import Firebase
import GoogleSignIn

class LoginRemoteData: LoginRemoteDataProtocol {

    func signIn() -> AnyPublisher<GIDGoogleUser, RemoteDataError> {
        return Future { promise in
            guard let clientID = FirebaseApp.app()?.options.clientID,
                  let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                promise(.failure(.invalidData))
                return
            }

            GIDSignIn.sharedInstance.signIn(with: GIDConfiguration(clientID: clientID), presenting: rootViewController) { user, error in
                if let googleUser = user {
                    promise(.success(googleUser))
                } else {
                    promise(.failure(.authError(error!)))
                }
            }
        }.eraseToAnyPublisher()
    }

    func authenticate(user: GIDGoogleUser) -> AnyPublisher<GIDGoogleUser, RemoteDataError> {
        return Future { promise in
            let credential = GoogleAuthProvider.credential(withIDToken: user.authentication.idToken!, accessToken: user.authentication.accessToken)
            Auth.auth().signIn(with: credential) { (data, error) in
                if let error = error {
                    promise(.failure(.authError(error)))
                } else {
                    promise(.success(user))
                }
            }

        }.eraseToAnyPublisher()
    }

    func addPhotoScope(user: GIDGoogleUser) -> AnyPublisher<GIDGoogleUser, RemoteDataError> {
        return Future { promise in
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                promise(.failure(.invalidData))
                return
            }

            let additionalScopes = ["https://www.googleapis.com/auth/photoslibrary.readonly"]
            GIDSignIn.sharedInstance.addScopes(additionalScopes, presenting: rootViewController) { googleUser, error in
                promise(.success(user))
            }
        }.eraseToAnyPublisher()

    }
    
}
