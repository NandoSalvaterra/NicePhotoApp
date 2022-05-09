//
//  LoginViewModel.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 04/05/22.
//

import Firebase
import Combine
import GoogleSignIn

class LoginViewModel: ObservableObject {

    @Published var showPhotoListView = false
    @Published var showErrorView = false

    var user: NicePhotoUser?
    var errorMessage: String?

    private let loginUseCase: LoginUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.loginUseCase = LoginUseCase()
    }

    func authenticateUser() {
        loginUseCase.execute().sink { [weak self] completion in
            switch completion {
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
                self?.showErrorView = true
            case .finished:
                break
            }
        } receiveValue: { [weak self] user in
            self?.user = NicePhotoUser(user: user)
            self?.showPhotoListView = true
        }.store(in: &cancellables)
    }
}
