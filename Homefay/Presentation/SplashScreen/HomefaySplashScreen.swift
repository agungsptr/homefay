//
//  HomefaySplashScreen.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import SwiftUI

struct HomefaySplashScreen: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.1

    
    var body: some View {
        
        if isActive == true {
            OnboardingView()
        } else {
            VStack {
                Image("logoHomefay")
                    .resizable()
                    .frame(width: 100,height: 100)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.2)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.isActive = true
                }
            }
        }
        
        
    }
    
}

struct HomefaySplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomefaySplashScreen()
    }
}
