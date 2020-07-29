//
//  ContentView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ExploreView(demands: testData)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Explorar")
            }
            AllInProgressView(demandsInProgress: testData)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Em andamento")
            }
            NotificationsView()
                .tabItem {
                    Image(systemName: "bell")
                    Text("Notificações")
            }
            ExploreView(demands: testData)
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Perfil")
            }
                    
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
