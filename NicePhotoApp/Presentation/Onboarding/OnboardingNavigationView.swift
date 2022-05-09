//
//  OnboardingNavigationView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import SwiftUI

struct OnboardingNavigationView: View {

    @Binding var selectedTab: OnboardingItem

    @State private var showLoginView = false
    @State private var showGetStartedView = false

    var body: some View {
        Group {
            if showGetStartedView {
                getStartedView
            } else {
                navigationView
            }
            NavigationLink(
                destination: LoginView(),
                isActive: $showLoginView) { EmptyView() }
            
        }.onChange(of: selectedTab) { selectedTabValue in
            showGetStartedView = selectedTabValue == .deletePhotos
         }
    }

    var navigationView: some View {
        HStack {
            Button {
                showLoginView.toggle()
                UserDefaultsService.shared.onboardingViewAlreadySeen = true
            } label: {
                Text("skip".localized)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
            }

            Spacer()

            Button {
                if let newSelectedTab = OnboardingItem.allCases.element(after: selectedTab) {
                    selectedTab = newSelectedTab
                } else {
                    showGetStartedView.toggle()
                }
            } label: {
                Text("next".localized)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(width: 100, height: 40)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.black, lineWidth: 1))
            }
        }
    }

    var getStartedView: some View {
        Button {
            showLoginView.toggle()
            UserDefaultsService.shared.onboardingViewAlreadySeen = true
        } label: {
            Text("get_started".localized)
                .foregroundColor(.black)
                .fontWeight(.semibold)
                .padding()
                .frame(maxWidth: .infinity)
                .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1))
        }
    }
}

struct OnboardingNavigationView_Previews: PreviewProvider {

    static var previews: some View {
        OnboardingNavigationView(selectedTab: .constant(.howAppWorks))
    }
}
