//
//  FavoritePhotosGridView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import SwiftUI

struct FavoritePhotosGridView: View {

    @StateObject var viewModel = FavoritePhotosViewModel()

    let columns = [
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100))
    ]

    var body: some View {
        VStack {

            Text("Favorite Photos")
                .font(.system(size: 22, weight: .semibold, design: .default))
                .padding(.top, 32)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(viewModel.photos, id: \.self) { photo in
                        Image(uiImage: photo.galleryPhoto ?? UIImage())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(6)
                            .frame(width: 100, height: 100)
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.getPhotos()
        }
    }
}

struct FavoritePhotosGridView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritePhotosGridView()
    }
}
