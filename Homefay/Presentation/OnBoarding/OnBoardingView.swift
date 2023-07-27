//
//  OnBoardingView.swift
//  Homefay
//
//  Created by bernardus kanayari on 27/07/23.
//

import SwiftUI

struct OnBoardingStep {
    let image: String
    let description : String
}

private let onBoardingSteps = [
    OnBoardingStep(image: "onboarding1", description: "Get things done together! Collaborate effortlessly with our innovative task management feature, allowing you and your family to coordinate tasks seamlessly, strengthening the bond in your household."),
    OnBoardingStep(image: "onboarding2", description: "Stay on track with Dependency task management! Visualize task relationships and ensure smooth execution as one task leads to another, creating a streamlined and efficient family task journey."),
    OnBoardingStep(image: "onboarding3", description: "Your preferences, your schedule, your way! Experience the power of Preference and availability mapping, where tasks are tailored to match individual interests and availability, making household responsibilities a breeze.")]


struct OnboardingView: View {
    
    @State private var currentStep = 0
    @AppStorage("sign_in") var wasSigned: Bool = false
    let transition: AnyTransition = .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    
    var body: some View {
        NavigationView{
            VStack {
                if currentStep != onBoardingSteps.count - 1 {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.currentStep = onBoardingSteps.count - 1
                        }) {
                            Text("Skip")
                                .padding(.horizontal, 28)
                                .foregroundColor(.gray)
                        }
                    }
                }
                else{
                    HStack {
                        Spacer()
                        Button(action: {
                        }) {
                            Text("Skip")
                                .padding(.horizontal, 28)
                                .foregroundColor(.white)
                        }
                    }
                }
//                Text("Homefay")
//                    .font(.system(size: 34))
//                    .bold()
//                    .foregroundColor(Color("PrimaryColor"))
//                    .offset(y: 50)
                
                TabView(selection: $currentStep) {
                    ForEach(0..<onBoardingSteps.count, id: \.self) { step in
                        VStack {
                            Image(onBoardingSteps[step].image)
                                .resizable()
                                .frame(width: 358, height: 358)
                            
                            Text(onBoardingSteps[step].description)
                                .bold()
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .padding(.top, 16)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                        .tag(step)
                        .transition(transition)
                    }
                }
                .animation(.easeInOut, value: currentStep)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    ForEach(0..<onBoardingSteps.count, id: \.self) { step in
                        if step == currentStep {
                            Rectangle()
                                .frame(width: 20, height: 10)
                                .cornerRadius(10)
                                .foregroundColor(Color("PrimaryColor"))
                        } else {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding(.bottom, 24)
                
                if currentStep < onBoardingSteps.count - 1 {
                    Button(action: {
                        self.currentStep += 1
                    }) {
                        Text("Next")
                            .bold()
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(Color("PrimaryColor"))
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                            .foregroundColor(.white)
                    }
                    .buttonStyle(.plain)
                } else {
                    NavigationLink(
                        destination: Text("test"),
                        label: {
                            Text("Get Started!")
                                .bold()
                                .padding(16)
                                .frame(maxWidth: .infinity)
                                .background(Color("PrimaryColor"))
                                .cornerRadius(16)
                                .padding(.horizontal, 16)
                                .foregroundColor(.white)
                                .onTapGesture {
                                    wasSigned = true
                                }
                        })
                }
            }
            .background(Color.white)
        }
        
    }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
