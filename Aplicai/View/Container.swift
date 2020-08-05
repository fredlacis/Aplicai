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

    let content: () -> Content
    
    internal init(background: Color? = nil, content: @escaping () -> Content){
        self.content = content
        if let background = background {
            self.background = background
        } else {
            self.background = Color("backgroundColor")
        }
    }

    var body: some View {
         ZStack {
            self.background.edgesIgnoringSafeArea(.all)
            content()
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
