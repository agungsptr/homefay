//
//  SignInView.swift
//  Homefay
//
//  Created by Agung Saputra on 25/07/23.
//

import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @Environment(\.colorScheme) private var colorSchema
    
    @StateObject private var vm = SignInViewModel()
    @State private var isLoading = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("signInIlustration")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 350)
                Text("HomeFay")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("Take Part Your Way")
                    .font(.subheadline)
                    .foregroundColor(.black)
                
                SignInWithAppleButton(.continue) { req in
                    req.requestedScopes = [.email, .fullName]
                } onCompletion: { res in
                    switch res {
                    case .success(let auth):
                        switch auth.credential {
                        case let cred as ASAuthorizationAppleIDCredential:
                            let firstName = cred.fullName?.givenName ?? ""
                            let lastName = cred.fullName?.familyName ?? ""
                            
                            vm.user.name = "\(firstName) \(lastName)"
                            vm.user.appleId = cred.user
                            vm.user.email = cred.email ?? ""
                            Task {
                                isLoading.toggle()
                                await vm.create()
                                isLoading.toggle()
                            }
                        default:
                            break
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                .signInWithAppleButtonStyle(
                    colorSchema == .dark ? .white : .black
                )
                .frame(height: 50)
                .cornerRadius(8)
                .padding()
            }
            if isLoading {
                LoadingView()
            }
        }
    }
}

private struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea(.all)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
