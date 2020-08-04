//
//  ProfileView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 30/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    var body: some View {
        Container {
            Text("Tela do perfil do usuário")
        }
        .onAppear(perform: {
            self.sharedNavigation.title = "Perfil"
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
