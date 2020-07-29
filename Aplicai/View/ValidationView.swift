//
//  ValidationView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 27/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ValidationView: View {
    
    var demand: Demand
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.1803921569, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack {
                Text("Sucesso!")
                    .font(.title)
                Text("Sua solicitação foi enviada.")
                
                Spacer()
                
                Image(demand.image)
                    .resizable()
                    .frame(width: 170, height: 170)
                    .cornerRadius(20)
                Text(demand.title)
                    .font(.headline)
                HStack {
                   Image(systemName: "briefcase.fill")
                       .scaleEffect(0.7)
                   Text(demand.businessName)
                       .font(.subheadline)
                }
               
                Spacer()
                
                Text("Você pode acompanhar o status da solicitação na aba de projetos em andamento.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                
//                NavigationLink(destination: ExploreView(demands: testData)) {
//                    HStack {
//                        Text("Voltar a navegação!")
//                        .font(.title)
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(15)
//
//                }
//                .isDetailLink(false)
                
            }
            .padding()
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ValidationView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationView(demand: testData[0])
    }
}
