//
//  GetFavoritePhotosUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 09/05/22.
//

import Foundation
import Combine

protocol GetFavoritePhotosUseCaseProtocol {

    func execute() -> AnyPublisher<[Photo], PhotosError>
}
