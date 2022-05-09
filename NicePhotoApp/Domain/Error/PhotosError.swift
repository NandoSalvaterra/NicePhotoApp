//
//  PhotosError.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import Foundation

enum PhotosError: Error {

    case emptyToken
    case custom(Error)
}
