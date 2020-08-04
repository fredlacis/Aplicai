//
//  MotherView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
//    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            if self.viewRouter.currentPage == Page.UserTypeView {
                UserTypeView()
            } else if self.viewRouter.currentPage == Page.SignUpView {
                SignUpView()
                    .transition(.opacity)
            } else if self.viewRouter.currentPage == Page.ContentView {
                ContentView().environmentObject(SharedNavigation())
                    .transition(.opacity)
            } else if self.viewRouter.currentPage == Page.DemandView {
                DemandView(demand: viewRouter.selectedDemand)
                    .transition(.move(edge: .trailing))
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
//        MotherView(viewRouter: ViewRouter())
        MotherView().environmentObject(ViewRouter())
    }
}
