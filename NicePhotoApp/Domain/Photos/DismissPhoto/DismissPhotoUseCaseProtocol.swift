//
//  DismissPhotoUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import Foundation
import Combine

protocol DismissPhotoUseCaseProtocol {

    func execute() -> AnyPublisher<String, PhotosError>
}
