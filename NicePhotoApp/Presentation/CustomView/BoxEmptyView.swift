//
//  BoxEmptyView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 09/05/22.
//

import SwiftUI

struct BoxEmptyView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Image("empty_box_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)

            Text("empty_message".localized)
                .font(.system(size: 22, weight: .semibold, design: .default))
                .padding(.top, 32)
            Spacer()
        }
    }
}

struct BoxEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
