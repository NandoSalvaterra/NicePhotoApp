//
//  NicePhotoUser.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import GoogleSignIn

struct NicePhotoUser {

    let name: String?
    let photoURL: URL?
    let accessToken: String?

    init(name: String?, photoURL: URL?, accessToken: String?) {
        self.name = name
        self.photoURL = photoURL
        self.accessToken = accessToken
    }

    init(user: GIDGoogleUser) {
        self.name = user.profile?.name
        self.photoURL = user.profile?.imageURL(withDimension: 60)
        self.accessToken = user.authentication.accessToken
    }
}

extension NicePhotoUser {

    static var mock: NicePhotoUser {
        return  NicePhotoUser(name: "mock_name", photoURL: URL(string: "photo_url"), accessToken: "access_token")
    }
}
