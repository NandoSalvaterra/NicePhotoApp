//
//  PhotosRemoteDataProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import UIKit
import Combine

protocol PhotosRemoteDataProtocol {

    func getGooglePhotos(token: String) -> AnyPublisher<[GooglePhoto], Error>
    func downloadPhoto(url: URL) -> AnyPublisher<UIImage, Error>

}
