//
//  Explore.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    
    var demands: [Demand]
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    @State var showingFilter = false
    
    @State private var searchText: String = ""
    
    @State private var isNavigationBarHidden = true
    
    var body: some View {
        Container {
            ScrollView {
                ForEach((0..<self.demands.count), id: \.self){ i in
                    ExploreCard(demand: self.demands[i])
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .onTapGesture {
                            print("tapped")
                            self.viewRouter.selectedDemand = self.demands[i]
                            self.viewRouter.currentPage = Page.DemandView
                        }
                    
                }
                .padding(.vertical)
            }
        }
        .onAppear(perform: {
            self.sharedNavigation.title = "Explorar"
        })
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(demands: testData)
    }
}
