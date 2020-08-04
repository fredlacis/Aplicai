//
//  OnBoardingView.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Container {
            OnBoardingSlider( viewControllers: OnBoardingPage.getStudentOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) ) })){
                self.viewRouter.currentPage = Page.SignUpView
            }
        }
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
