//
//  ViewRouter.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

enum Page {
    case LoadingView
    case UserTypeView
    case SignUpView
    case ContentView
    case DemandView
    case OnBoardingView
}

class ViewRouter: ObservableObject {
 
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: Page = Page.LoadingView {
        didSet {
            DispatchQueue.main.async {
                withAnimation() {
                    self.objectWillChange.send(self)
                }
            }
        }
    }
    
    var selectedDemand: Demand = testData[0]
    
    var loggedUser: User?
    
}


//https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-bindableobject/#
