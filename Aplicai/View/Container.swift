//
//  Container.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 30/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct Container<Content: View>: View {
    
    var background: Color?
    
    var hasNavGradient: Bool?

    let content: () -> Content
    
    internal init(background: Color? = nil, hasNavGradient: Bool? = nil,content: @escaping () -> Content){
        self.content = content
        
        if let background = background {
            self.background = background
        } else {
            self.background = Color("backgroundColor")
        }
        
        if let hasNavGradient = hasNavGradient {
            self.hasNavGradient = hasNavGradient
        } else {
            self.hasNavGradient = true
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            self.background.edgesIgnoringSafeArea(.all)
            content()
            if self.hasNavGradient! {
                HStack {
                    Color("backgroundColor")
                        .opacity(0.5)
                        .blur(radius: 15, opaque: false)
                        .edgesIgnoringSafeArea(.top)
                }.frame(height: 1)
            }
        }
    }
}

struct Container_Previews: PreviewProvider {
    static var previews: some View {
        Container {
            Text("Teste")
        }
    }
}
