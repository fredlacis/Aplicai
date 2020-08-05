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
            OnBoardingPage(id: UUID(), image: "crie", heading: "Crie seu perfil!", subSubheading: "Faça parte da rede APLICAÍ!"),
            OnBoardingPage(id: UUID(), image: "ache", heading: "Encontre demandas!", subSubheading: "E veja onde suas habilidades podem ser colocadas em prática!"),
            OnBoardingPage(id: UUID(), image: "aplique", heading: "Aplique seu conhecimento!", subSubheading: "E tenha ativamente uma experiência no mundo real!"),
            
        ]
    }

    static var getBusinessOnBoarding: [OnBoardingPage] {
           [
               OnBoardingPage(id: UUID(), image: "crie2", heading: "Crie seu perfil!", subSubheading: "E seja parte da rede APLICAÍ!"),
               OnBoardingPage(id: UUID(), image: "encontre", heading: "Faça conexões!", subSubheading: "Entre em contato com estudantes que queiram pôr seus conhecimentos em prática!"),
               OnBoardingPage(id: UUID(), image: "aplique", heading: "Melhore seu empreendimento!", subSubheading: "Oferecendo oportunidade de experimentação ativa no mundo real!"),
               
           ]
       }


}
