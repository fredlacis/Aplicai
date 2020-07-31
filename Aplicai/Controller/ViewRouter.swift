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
    case UserTypeView
    case SignUpView
    case ContentView
}

class ViewRouter: ObservableObject {
 
    let objectWillChange = PassthroughSubject<ViewRouter,Never>()
    
    var currentPage: Page = Page.UserTypeView {
        didSet {
            withAnimation() {
                objectWillChange.send(self)
            }
        }
    }
    
}


//https://blckbirds.com/post/how-to-navigate-between-views-in-swiftui-by-using-an-bindableobject/#
