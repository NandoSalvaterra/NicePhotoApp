//
//  RemoteDataError.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import Foundation

enum RemoteDataError: Error {

    case authError(Error)
    case invalidData
    case customError(Error)
}
