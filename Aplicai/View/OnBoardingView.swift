//
//  OnBoardingView.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct OnBoardingView: View {
    var body: some View {
            VStack {
                OnBoardingController( viewControllers: OnBoardingPage.getStudentOnBoarding.map({  UIHostingController(rootView: OnBoardingPageView(page: $0) ) }))
            }.frame(maxHeight: .infinity).background(Color.green).edgesIgnoringSafeArea(.all)
    }
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
