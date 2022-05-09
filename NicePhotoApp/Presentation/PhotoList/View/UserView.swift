//
//  UserView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import SwiftUI

struct UserView: View {

    let user: NicePhotoUser?
    
    var body: some View {
        HStack {
            AsyncImage(url: user?.photoURL ?? URL(string: "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Image("user_placeholder_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }.frame(width: 60, height: 60)

            VStack(alignment: .leading) {
                Text("hello".localized)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                Text(user?.name ?? "visitor".localized)
                    .font(.system(size: 22, weight: .semibold, design: .default))
            }
            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: NicePhotoUser.mock)
    }
}
