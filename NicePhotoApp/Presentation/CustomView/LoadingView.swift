//
//  LoadingView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 08/05/22.
//

import SwiftUI

struct LoadingView: View {

    @State private var isLoading = false

    var body: some View {
        VStack {
            Spacer()
            ZStack {

                Circle()
                    .stroke(Color(.systemGray5), lineWidth: 14)
                    .frame(width: 100, height: 100)

                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.gray, lineWidth: 7)
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: isLoading)
                    .onAppear() {
                        self.isLoading = true
                    }
            }
            Spacer()
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
