//
//  onBoarding.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct onBoarding: View {
    
    @State private var step = 1
    
    var body: some View {
        ZStack {
            Color("DarkShade")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                Text("Welcome to")
                    .font(.largeTitle)
                    .foregroundColor(Color("LightShade"))
                    .padding(.top)
                Text("SwiftUI")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color("LightShade"))
                
                GeometryReader { gr in
                    HStack {
                        VStack(spacing: 40) {
                            Image("crie")
                            Text("Learn the future of iOS Development.")
                                .padding()
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                        }.frame(width: gr.frame(in: .global).width)
                        VStack(spacing: 40) {
                            Image("ache")
                            Text("The best way to get your UI to how you wanted it to look like when first designed.")
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                        }.frame(width: gr.frame(in: .global).width)
                        VStack(spacing: 40) {
                            Image("aplique")
                            Text("Master SwiftUI Today!.")
                                .padding()
                                .fixedSize(horizontal: false, vertical: true)
                                .animation(Animation.interpolatingSpring(stiffness: 40, damping: 7).delay(0.1))
                        }.frame(width: gr.frame(in: .global).width)
                    }
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("LightShade"))
                    .font(.title)
                    .padding(.vertical, 60)
                    .frame(width: gr.frame(in: .global).width * 3)
                    .frame(maxHeight: .infinity)
                    .offset(x: self.step == 1 ? gr.frame(in: .global).width : self.step == 2 ? 0 : -gr.frame(in: .global).width)
                    .animation(Animation.interpolatingSpring(stiffness: 40, damping: 8))
                }
                HStack(spacing: 20) {
                    Button(action: {self.step = 1}) {
                        Image(systemName: "1.circle")
                            .padding()
                            .scaleEffect(step == 1 ? 1 : 0.65)
                    }
                    Button(action: {self.step = 2}) {
                        Image(systemName: "2.circle")
                            .padding()
                            .scaleEffect(step == 2 ? 1 : 0.65)
                    }
                    Button(action: {self.step = 3}) {
                        Image(systemName: "3.circle")
                            .padding()
                            .scaleEffect(step == 3 ? 1 : 0.65)
                    }
                }
                .animation(.spring(response: 0.4, dampingFraction: 0.5))
                .font(.largeTitle)
                .accentColor(Color("LightAccent"))
                
                Button(action: {}) {
                    HStack {
                        Text("Continue")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.horizontal)
                    .padding()
                    .background(Capsule().fill(Color("Accent2")))
                    .accentColor(Color("LightAccent"))
                    .opacity(step == 3 ? 1 : 0)
                    .animation(.none)
                    .scaleEffect(step == 3 ? 1 : 0.01)
                    .animation(Animation.interpolatingSpring(stiffness: 50, damping: 10, initialVelocity: 10))
                }
            }
        }
    }
}

struct onBoarding_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
