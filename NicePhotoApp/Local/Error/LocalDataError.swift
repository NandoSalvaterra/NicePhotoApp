//
//  LocalDataError.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation

enum LocalDataError: Error {

    case invalidData
    case wrongImage
    case favoriteError(Error)
}
