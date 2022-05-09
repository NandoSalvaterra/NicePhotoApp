//
//  ContentView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import SwiftUI

struct ContentView: View {

    let user: NicePhotoUser?

    var body: some View {
        TabView {
            PhotoListView(user: user)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("my_photos".localized)
                }
            FavoritePhotosGridView()
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .tabItem {
                    Image(systemName: "star.circle")
                    Text("favorite_photos".localized)
                }
        }.navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(user: NicePhotoUser.mock)
    }
}
