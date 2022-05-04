//
//  OnboardingContentView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import SwiftUI

struct OnboardingContentView: View {

    var item: OnboardingItem

    var body: some View {
        VStack {
            Image(item.getImageName())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)

            Text(item.getTextMessage())
                .multilineTextAlignment(.center)
                .font(Font.title2.weight(.bold))
                .padding(.top, 32)
                .padding(.horizontal, 36)
        }
    }
}

struct OnboardingContentView_Previews: PreviewProvider {

    static var previews: some View {
        OnboardingContentView(item: .deletePhotos)
    }
}
