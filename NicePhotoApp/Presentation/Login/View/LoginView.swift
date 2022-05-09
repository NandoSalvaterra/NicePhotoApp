//
//  LoginView.swift
//  NicePhotoApp
//
//  Created by Luiz Fernando Salvaterra on 03/05/22.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {

    @StateObject var viewModel: LoginViewModel = LoginViewModel()

    var body: some View {
        VStack {
            Spacer()

            loginTextView()

            loginMessageView()

            Image("login_image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
                .padding(.bottom, 98)
                .padding(.top, 28)

            loadFromGalleryButton()

            HStack {
                Color.gray.frame(height:CGFloat(1) / UIScreen.main.scale)
                Text("or".localized)
                Color.gray.frame(height:CGFloat(1) / UIScreen.main.scale)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)


            GoogleSignInButton(scheme: .dark, style: .wide, state: .normal) {
                viewModel.authenticateUser()
            }.padding(.horizontal)

            Spacer()

            NavigationLink(
                destination: ContentView(user: viewModel.user).navigationBarHidden(true),
                isActive: $viewModel.showPhotoListView) { EmptyView() }
        }
        .background(Color(#colorLiteral(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)))
        .navigationBarHidden(true)
        .alert(isPresented: $viewModel.showErrorView, content: {
            Alert(title: Text("error".localized), message: Text(viewModel.errorMessage ?? ""), dismissButton: .default(Text("ok".localized)))
        })
    }

    func loginTextView() -> some View {
        HStack {
            Text("login".localized)
                .font(.system(size: 28, weight: .bold, design: .default))
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.leading, 32)
    }

    func loginMessageView() -> some View {
        HStack {
            Text("login_message".localized)
                .font(.system(size: 16, weight: .medium, design: .default))
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding(.leading, 32)
        .padding(.top, 8)
    }

    func loadFromGalleryButton() -> some View {
        Button {
            viewModel.showPhotoListView.toggle()
        } label: {
            Text("load_images_from_gallery".localized)
                .foregroundColor(.black)
                .font(.system(size: 14, weight: .medium, design: .default))
                .fontWeight(.medium)

                .frame(maxWidth: .infinity)
                .frame(height: 36)
                .overlay(RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.black, lineWidth: 1))
                .padding(.horizontal)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
        }
    }
}
