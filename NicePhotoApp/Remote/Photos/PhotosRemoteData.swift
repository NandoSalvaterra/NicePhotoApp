//
//  PhotosRemoteData.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import UIKit
import Combine

class PhotosRemoteData: PhotosRemoteDataProtocol {

    private let userDefaults = UserDefaultsService.shared

    var decoder: JSONDecoder {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(Formatter.iso8601)
        return jsonDecoder
    }

    func getGooglePhotos(token: String) -> AnyPublisher<[GooglePhoto], RemoteDataError> {
        return getAllGooglePhotos(token: token).map {
            $0.filter { !self.userDefaults.getDismissedGooglePhotoIds().contains($0.id!) }
        }.eraseToAnyPublisher()
    }

    func downloadPhoto(url: URL) -> AnyPublisher<UIImage, RemoteDataError> {
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        return URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .mapError { error in .customError(error) }
            .map { UIImage(data: $0.data)! }
            .eraseToAnyPublisher()
    }

    func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, RemoteDataError> {
        return Future { promise in
            UserDefaultsService.shared.saveDismissedGooglePhotoId(photo.id)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    // MARK: - Private API

    private func getAllGooglePhotos(token: String) -> AnyPublisher<[GooglePhoto], RemoteDataError> {
        let request = NSMutableURLRequest(url: URL(string: "https://photoslibrary.googleapis.com/v1/mediaItems")!)

        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        return URLSession.shared.dataTaskPublisher(for: request as URLRequest)
            .map { $0.data }
            .decode(type: GooglePhotosResponse.self, decoder: decoder)
            .map { $0.mediaItems ?? [] }
            .mapError { error in .customError(error) }
            .eraseToAnyPublisher()
    }
}
