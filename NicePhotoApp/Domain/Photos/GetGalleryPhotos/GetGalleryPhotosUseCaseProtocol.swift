//
//  GetGalleryPhotosUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Combine

protocol GetGalleryPhotosUseCaseProtocol {

    func execute() -> AnyPublisher<[Photo], PhotosError>
}
