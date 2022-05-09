//
//  FavoritePhotoUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import Foundation
import Combine

protocol FavoritePhotoUseCaseProtocol {

    func execute(photo: Photo) -> AnyPublisher<Bool, PhotosError>
}
