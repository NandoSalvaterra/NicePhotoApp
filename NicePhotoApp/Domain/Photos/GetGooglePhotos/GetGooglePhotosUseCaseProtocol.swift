//
//  GetGooglePhotosUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import Combine

protocol GetGooglePhotosUseCaseProtocol {

    func execute(token: String) -> AnyPublisher<[Photo], PhotosError>
}
