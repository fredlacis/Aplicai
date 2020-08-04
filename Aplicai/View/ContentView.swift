//
//  ContentView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI
import Combine

class SharedNavigation: ObservableObject {
 
    let objectWillChange = PassthroughSubject<SharedNavigation,Never>()
    
    var title: String = "" {
        didSet {
            objectWillChange.send(self)
        }
    }
    
}

struct ContentView: View {
        
    @State private var isNavigationBarHidden = true
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    @State var tabIndex: Int = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $tabIndex) {
                ExploreView(demands: testData)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Explorar")
                    }
                    .tag(0)
                AllInProgressView(demandsInProgress: testData)
                    .tabItem {
                        Image(systemName: "square.and.pencil")
                        Text("Em andamento")
                    }
                .tag(1)
                NotificationsView()
                    .tabItem {
                        Image(systemName: "bell")
                        Text("Notificações")
                    }
                .tag(2)
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.square")
                        Text("Perfil")
                    }
                    .tag(3)
            }
            .navigationBarTitle(sharedNavigation.title)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
