//
//  SavePhotoInGalleryUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

protocol SavePhotoInGalleryUseCaseProtocol {

    func execute(image: UIImage) -> AnyPublisher<Bool, PhotosError>
}
