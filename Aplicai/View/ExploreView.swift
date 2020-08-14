//
//  Explore.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    
    // Enviroment controllers
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    // Demands to be displayed
    @Binding var exploreDemands: [Demand]
    
    // Loading states
    @State var isReloading = false
    var isReloadingProxy: Binding<Bool> {
        Binding<Bool>(
            get: { self.isReloading },
            set: {
                if $0 == true {
                    self.loadAllDemands()
                }
                self.isReloading = $0
        }
        )
    }
    
    // Used for filtering and searching
    //@State var showingFilter = false
    //@State private var searchText: String = ""
    
    var body: some View {
        Container {
            RefreshableScrollView(refreshing: self.isReloadingProxy) {
                ForEach((0..<self.exploreDemands.count), id: \.self){ i in
                    ExploreCard(demand: self.exploreDemands[i])
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .onTapGesture {
                            self.viewRouter.selectedDemand = self.exploreDemands[i]
                            self.viewRouter.currentPage = Page.DemandView
                    }
                    
                }
                .padding(.vertical)
            }
        }
        .onAppear(perform: {
            self.sharedNavigation.type = .large
            self.sharedNavigation.title = "Explorar"
            if self.exploreDemands.isEmpty {
                self.loadAllDemands()
            }
        })
    }
    
    func loadAllDemands() {
        print("------> Loading All Demands")
        self.isReloading = true
        Demand.ckLoadAllDemands(then: { (result)->Void in
            switch result {
                case .success(let records):
                    self.exploreDemands = records
                    print("------> Finished Loading All Demands")
                    self.isReloading = false
                case .failure(let error):
                    debugPrint(error)
                
            }
        })
        
    }
    
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(exploreDemands: .constant(testData)).environmentObject(SharedNavigation())
    }
}
