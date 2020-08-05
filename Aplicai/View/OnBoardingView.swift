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
    
    var userType = UserDefaults.standard.string(forKey: "Type")
    
    var body: some View {
        Container {
            VStack {
                if self.userType == "student" {
                    OnBoardingSlider( viewControllers: OnBoardingPage.getStudentOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) ) })){
                        self.goToSignUp()
                    }
                } else if self.userType == "business" {
                    OnBoardingSlider( viewControllers: OnBoardingPage.getBusinessOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) ) })){
                        self.goToSignUp()
                    }
                }
            }
        }
    }
    
    func goToSignUp() {
        self.viewRouter.currentPage = Page.SignUpView
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
