//
//  OnBoardingController.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI


struct OnBoardingSlider<T: View>  : View {
    
    var viewControllers: [UIHostingController<T>]
    
    @State var currentPage = 0
    
    var action: (()->()) = {}
    
    var body: some View {
        VStack {
            OnBoardingViewController(controllers: viewControllers, currentPage: self.$currentPage)
            
            PageIndicator(currentIndex: self.currentPage)
            
            LCButton(text: currentPage == viewControllers.count - 1 ? "Começar" : "Próximo") {
                if self.currentPage < self.viewControllers.count - 1 {
                    print("LCButton", self.currentPage, "<" ,self.viewControllers.count - 1)
                    self.currentPage += 1
                } else {
                    print("LCButton", self.currentPage, ">=" ,self.viewControllers.count - 1)
                    self.action()
                }
            }.padding()
        }
    }
}

struct OnBoarding_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingSlider(viewControllers: OnBoardingPage.getStudentOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) )  }))
    }
}
