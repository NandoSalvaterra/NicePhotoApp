//
//  PhotosLocalData.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 05/05/22.
//

import UIKit
import Combine
import Photos
import CocoaImageHashing

class PhotosLocalData: PhotosLocalDataProtocol {

    private let userDefaults = UserDefaultsService.shared
    private var cancellables = Set<AnyCancellable>()

    func getGalleryPhotos() -> AnyPublisher<[PHAsset], LocalDataError> {
        return getAllGalleryPhotos().map { $0.filter {
            !$0.isFavorite && !self.userDefaults.getDismissedGalleryPhotoIds().contains($0.localIdentifier) }
        }.eraseToAnyPublisher()
    }

    func getFavoritePhotos() -> AnyPublisher<[PHAsset], LocalDataError> {
        return getAllGalleryPhotos().map { $0.filter { $0.isFavorite } }.eraseToAnyPublisher()
    }

    func favoritePhoto(_ photo: Photo) -> AnyPublisher<Bool, LocalDataError> {
        return Future { promise in
            self.getGalleryPhotos().sink { completion in } receiveValue: { assets in
                for asset in assets {
                    if asset.localIdentifier == photo.id {
                        PHPhotoLibrary.shared().performChanges {
                            let request = PHAssetChangeRequest(for: asset)
                            request.isFavorite = true
                        } completionHandler: { success, error in
                            if let error = error {
                                promise(.failure(.favoriteError(error)))
                            } else {
                                promise(.success(success))
                            }
                        }
                    }
                }
            }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }

    func dismissPhoto(_ photo: Photo) -> AnyPublisher<Bool, LocalDataError> {
        return Future { promise in
            UserDefaultsService.shared.saveDismissedGalleryPhotoId(photo.id)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func checkDuplicatedPhoto(image: UIImage, fileName: String) -> AnyPublisher<(Bool, UIImage), LocalDataError> {
        return Future { promise in
            self.getGalleryPhotos().sink { completion in } receiveValue: { assets in
                var imagesData: [(UIImage, String)] = []
                imagesData.append((image, fileName))
                for asset in assets {
                    imagesData.append((asset.getUIImage(), PHAssetResource.assetResources(for: asset).first!.originalFilename))
                }
                let result = OSImageHashing.sharedInstance().similarImages(withProvider: .pHash) {
                    if imagesData.count > 0 {
                        let imageData = imagesData.removeFirst()
                        let data = imageData.0.jpegData(compressionQuality: 1.0)!
                        let fileName = imageData.1
                        return OSTuple<NSString, NSData>(first: fileName as NSString,
                                                         andSecond: data as NSData)
                    } else {
                        return nil
                    }
                }
                let duplicatedPhoto = result.contains { tuple in
                    return (tuple.first! as String) == fileName || (tuple.second! as String) == fileName
                }
                promise(.success((duplicatedPhoto, image)))
            }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }

    func savePhotoInGallery(image: UIImage) -> AnyPublisher<Bool, LocalDataError> {
        return Future { promise in
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            promise(.success(true))
        }.eraseToAnyPublisher()
    }

    func getLastSavedPhotoInGallery() -> AnyPublisher<PHAsset, LocalDataError> {
        return getAllGalleryPhotos().map { $0.first! }.eraseToAnyPublisher()
    }

    // MARK: - Private API

    func getAllGalleryPhotos() -> AnyPublisher<[PHAsset], LocalDataError> {
        return Future { promise in
            PHPhotoLibrary.requestAuthorization { status in
                switch status {
                case .authorized:
                    var images: [PHAsset] = []
                    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    assets.enumerateObjects({ (object, count, stop) in
                        images.append(object)
                    })
                    images.reverse()
                    promise(.success(images))
                default:
                    promise(.failure(.invalidData))
                }
            }
        }.eraseToAnyPublisher()
    }
}

