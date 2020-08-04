//
//  onBoardingPage.swift
//  Aplicai
//
//  Created by Rafael Assunção on 04/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation


struct OnBoardingPage: Identifiable {
    
    let id: UUID
    let image: String
    let heading: String
    let subSubheading: String
    
    static var getStudentOnBoarding: [OnBoardingPage] {
        [
            OnBoardingPage(id: UUID(), image: "crie", heading: "Form new habits", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            OnBoardingPage(id: UUID(), image: "ache", heading: "Keep track of your progress", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            OnBoardingPage(id: UUID(), image: "aplique", heading: "Setup your goals", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
            
        ]
    }

    static var getBusinessOnBoarding: [OnBoardingPage] {
           [
               OnBoardingPage(id: UUID(), image: "crie", heading: "Form new habits", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
               OnBoardingPage(id: UUID(), image: "ache", heading: "Keep track of your progress", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
               OnBoardingPage(id: UUID(), image: "aplique", heading: "Setup your goals", subSubheading: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."),
               
           ]
       }


}
