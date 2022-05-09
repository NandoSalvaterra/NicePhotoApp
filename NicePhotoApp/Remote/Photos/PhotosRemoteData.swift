//
//  PhotosRemoteData.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import UIKit
import Combine

class PhotosRemoteData: PhotosRemoteDataProtocol {

    var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
        return jsonDecoder
    }

    func getGooglePhotos(token: String) -> AnyPublisher<[GooglePhoto], Error> {
        let request = NSMutableURLRequest(url: URL(string: "https://photoslibrary.googleapis.com/v1/mediaItems")!)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: GooglePhotosResponse.self, decoder: decoder)
            .map{ $0.mediaItems ?? []}
            .eraseToAnyPublisher()
    }

    func downloadPhoto(url: URL) -> AnyPublisher<UIImage, Error> {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .mapError { $0 as Error }
            .map { UIImage(data: $0.data)! }
            .eraseToAnyPublisher()
    }
}
