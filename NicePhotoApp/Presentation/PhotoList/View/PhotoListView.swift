//
//  PhotoListView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import SwiftUI
import Firebase

struct PhotoListView: View {

    let user: NicePhotoUser?

    @StateObject var viewModel = PhotoListViewModel()

    var body: some View {
        VStack {

            UserView(user: user)
                .padding()
                .padding(.top, 24)

            if !viewModel.photos.isEmpty {
                List($viewModel.photos) { photo in
                    PhotoRowView(photo: photo)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            deleteButton(photo: photo.wrappedValue)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            favoriteButton(photo: photo.wrappedValue)
                        }
                }.animation(.spring(), value: viewModel.photos)
                    .padding(.bottom, 16)
                    .listStyle(.plain)
            } else if viewModel.isLoading {
                LoadingView()
            } else {
                BoxEmptyView()
            }
        }
        .navigationBarHidden(true)
        .alert(isPresented: $viewModel.showErrorView, content: {
            Alert(title: Text("error".localized), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("ok".localized)))
        })
        .onAppear { viewModel.getPhotos(user: user) }
    }

    func deleteButton(photo: Photo) -> some View {
        return Button(role: .destructive) {
            viewModel.dismissPhoto(photo)
        } label: {
            Label("delete".localized, systemImage: "trash.circle.fill")
        }
    }

    func favoriteButton(photo: Photo) -> some View {
        return Button {
            if user != nil {
                viewModel.saveGooglePhoto(photo)
            } else {
                viewModel.favoritePhoto(photo)
            }
        } label: {
            Label("favorite".localized, systemImage: "star.circle.fill")
        }.tint(.green)
    }
}

struct PhotoListView_Previews: PreviewProvider {

    static var previews: some View {
        PhotoListView(user: NicePhotoUser.mock)
    }
}
