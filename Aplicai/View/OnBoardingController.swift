//
//  OnBoardingController.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI


struct OnBoardingController<T: View>  : View {
    
    var viewControllers: [UIHostingController<T>]
    @State var currentPage = 0
    
    var body: some View {
        
        VStack {
            PageViewController(controllers: viewControllers, currentPage: self.$currentPage)
            
            PageIndicator(currentIndex: self.currentPage)
            
            LCButton(text: currentPage == viewControllers.count - 1 ? "Get started" : "Next") {
                if self.currentPage < self.viewControllers.count - 1{
                    self.currentPage += 1
                }
            }.padding()
            
        }.background(Color.pink)
    }
}

struct OnBoardingController_Previews: PreviewProvider {
    static var previews: some View {
       OnBoardingController(viewControllers: OnBoardingPage.getStudentOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) )  }))
    }
}
