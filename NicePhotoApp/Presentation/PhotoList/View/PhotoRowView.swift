//
//  PhotoRowView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 02/05/22.
//

import SwiftUI

struct PhotoRowView: View {

    @Binding var photo: Photo

    var body: some View {
        HStack {

            DynamicImageView(photo: photo)
                .frame(width: 100, height: 100)
                .padding(.trailing, 16)

            VStack(alignment: .leading) {
                Text(photo.fileName ?? "")
                .font(.system(size: 18, weight: .semibold, design: .default))

                HStack(spacing: 4) {
                    Image("icon_clock")
                        .resizable()
                        .frame(width: 18, height: 18)
                Text("Created at \(photo.creationDate?.readableText ?? "")")
                    .font(.system(size: 14, weight: .medium, design: .default))
                }
            }.padding(.bottom, 26)
            Spacer()
        }
    }
}

struct PhotoRowView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoRowView(photo: .constant(Photo.mock))
    }
}
