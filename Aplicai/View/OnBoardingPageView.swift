//
//  OnBoardingView.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct OnBoardingPageView: View {
    var page = OnBoardingPage.getStudentOnBoarding.first!
    
    var body: some View {
        VStack{
            
            Image(page.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth:200)
            VStack{
                Text(page.heading).font(.title).bold().layoutPriority(1).multilineTextAlignment(.center)
                Text(page.subSubheading)
                    .multilineTextAlignment(.center)
            }.padding()
        }
        
    }
    
}
struct OnBoardingPageView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingPageView()
    }
}

