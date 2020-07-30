//
//  Container.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 30/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct Container<Content: View>: View {
    
    let content: () -> Content
    
    var body: some View {
         ZStack {
            Color("backgroundColor").edgesIgnoringSafeArea(.all)
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
