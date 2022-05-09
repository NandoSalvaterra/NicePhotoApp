//
//  DynamicImageView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import SwiftUI

struct DynamicImageView: View {

    let photo: Photo

    var body: some View {
        if photo.type == .gallery {
            Image(uiImage: photo.galleryPhoto ?? UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(6)
                .frame(width: 100, height: 100)
        } else {
            AsyncImage(url: URL(string: photo.googlePhotoURL ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(6)
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(6)
            .padding()
        }
    }
}

struct DynamicImageView_Previews: PreviewProvider {
    static var previews: some View {
        DynamicImageView(photo: Photo.mock)
    }
}
