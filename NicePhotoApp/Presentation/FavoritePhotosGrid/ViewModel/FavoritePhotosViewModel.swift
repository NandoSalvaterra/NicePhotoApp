//
//  FavoritePhotosViewModel.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import UIKit
import Combine

class FavoritePhotosViewModel: ObservableObject {

    @Published var photos: [Photo] = []
    @Published var showErrorView: Bool = false

    var errorMessage: String?

    let getFavoritePhotosUseCase: GetFavoritePhotosUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.getFavoritePhotosUseCase = GetFavoritePhotosUseCase()
    }

    func getPhotos() {
        getFavoritePhotosUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    self?.showErrorView = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] photos in
                self?.photos = photos
            }.store(in: &cancellables)
    }
}
