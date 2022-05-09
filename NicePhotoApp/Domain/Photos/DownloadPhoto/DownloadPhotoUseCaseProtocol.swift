//
//  DownloadPhotoUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

protocol DownloadPhotoUseCaseProtocol {

    func execute(url: URL) -> AnyPublisher<UIImage, PhotosError>
}
