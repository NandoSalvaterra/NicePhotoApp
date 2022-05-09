//
//  PhotoListViewModel.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 07/05/22.
//

import UIKit
import Combine

class PhotoListViewModel: ObservableObject {

    @Published var photos: [Photo] = []
    @Published var isLoading: Bool = true
    @Published var showErrorView: Bool = false

    var errorMessage: String?

    private let getGooglePhotosUseCase: GetGooglePhotosUseCaseProtocol
    private let getGalleryPhotosUseCase: GetGalleryPhotosUseCaseProtocol
    private let favoritePhotoUseCase: FavoritePhotoUseCaseProtocol
    private let dismissPhotoUseCase: DismissPhotoUseCaseProtocol
    private let downloadPhotoUseCase: DownloadPhotoUseCaseProtocol
    private let checkDuplicatedPhotoUseCase: CheckDuplicatedPhotoUseCaseProtocol
    private let savePhotoInGalleryUseCase: SavePhotoInGalleryUseCaseProtocol
    private let getLastSavedPhotoInGalleryUseCase: GetLastSavedPhotoInGalleryUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.getGooglePhotosUseCase = GetGooglePhotosUseCase()
        self.getGalleryPhotosUseCase = GetGalleryPhotosUseCase()
        self.favoritePhotoUseCase = FavoritePhotoUseCase()
        self.dismissPhotoUseCase = DismissPhotoUseCase()
        self.downloadPhotoUseCase = DownloadPhotoUseCase()
        self.checkDuplicatedPhotoUseCase = CheckDuplicatedPhotoUseCase()
        self.savePhotoInGalleryUseCase = SavePhotoInGalleryUseCase()
        self.getLastSavedPhotoInGalleryUseCase = GetLastSavedPhotoInGalleryUseCase()
    }

    func getPhotos(user: NicePhotoUser?) {
        isLoading = true
        if let user = user {
            getGooglePhotosUseCase.execute(token: user.accessToken!)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showErrorView = true
                    case .finished:
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] photos in
                    self?.photos = photos
                }.store(in: &cancellables)

        } else {
            getGalleryPhotosUseCase.execute()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                        self?.showErrorView = true
                    case .finished:
                        self?.isLoading = false
                    }
                } receiveValue: { [weak self] photos in
                    self?.photos = photos
                }.store(in: &cancellables)
        }
    }

    func favoritePhoto(_ photo: Photo) {
        favoritePhotoUseCase.execute(photo: photo)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorView = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] success in
                if success, let index = self?.photos.firstIndex(of: photo) {
                    self?.photos.remove(at: index)
                }
            }.store(in: &cancellables)
    }

    func dismissPhoto(_ photo: Photo) {
        dismissPhotoUseCase.execute(photo: photo)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorView = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] success in
                if success, let index = self?.photos.firstIndex(of: photo) {
                    self?.photos.remove(at: index)
                }
            }.store(in: &cancellables)
    }

    func saveGooglePhoto(_ photo: Photo) {
        guard let url = URL(string: photo.googlePhotoURL ?? "") else { return }
        downloadPhotoUseCase.execute(url: url)
            .flatMap { self.checkDuplicatedPhotoUseCase.execute(image: $0, fileName: photo.fileName ?? "") }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorView = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] (isDuplicated, image) in
                if isDuplicated {
                    self?.errorMessage = "photo_duplicated_message".localized
                    self?.showErrorView = true
                } else {
                    self?.savePhotoInGallery(image: image)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self?.favoriteGooglePhoto(photo)
                    }
                }
            }.store(in: &cancellables)
    }

    func savePhotoInGallery(image: UIImage) {
        savePhotoInGalleryUseCase.execute(image: image)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorView = true
            case .finished:
                break
            }
        } receiveValue: { success in
            print(success)
        }.store(in: &cancellables)
    }

    func favoriteGooglePhoto(_ photo: Photo) {
        getLastSavedPhotoInGalleryUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorView = true
            case .finished:
                break
            }
        } receiveValue: { lastSavedphoto in
            self.favoritePhoto(photo)
        }.store(in: &cancellables)
    }
}
