//
//  OnboardingView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 02/05/22.
//

import SwiftUI

struct OnboardingView: View {

    @State private var selectedTab: OnboardingItem = .howAppWorks

    private var items: [OnboardingItem] = OnboardingItem.allCases

    var body: some View {
        VStack {
            Text("app_name".localized)
                .font(Font.largeTitle.weight(.bold))
                .padding(.top, 32)

            TabView(selection: $selectedTab) {
                ForEach(items, id: \.self) {  item in
                    OnboardingContentView(item: item).tag(item)
                        .padding(.bottom, 48)
                }
            }.tabViewStyle(PageTabViewStyle())

            OnboardingNavigationView(selectedTab: $selectedTab)
                .padding(.vertical, 16)
                .padding(.horizontal, 32)
        }
        .background(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
        .navigationBarHidden(true)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
            .previewDevice("iPhone 13 Pro Max")
    }
}


