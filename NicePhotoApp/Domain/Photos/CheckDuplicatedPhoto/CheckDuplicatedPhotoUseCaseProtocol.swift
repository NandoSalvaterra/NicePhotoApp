//
//  CheckDuplicatedPhotoUseCaseProtocol.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

protocol CheckDuplicatedPhotoUseCaseProtocol {

    func execute(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), PhotosError>
}
