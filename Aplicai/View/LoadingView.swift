//
//  LoadingView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 07/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isAnimating = false
    @State private var showProgress = false
    var foreverAnimation: Animation {
        Animation.linear(duration: 2.0)
            .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        Container {
            VStack {
                Image(systemName: "rays")
                    .font(.system(size: 35))
                    .rotationEffect(.degrees(self.isAnimating ? 360 : 0))
                    .animation(self.isAnimating ? self.foreverAnimation : .default)
                    .onAppear { self.isAnimating = true }
                    .onDisappear { self.isAnimating = false }
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
