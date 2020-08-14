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
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Container {
            VStack {
                Text("Sucesso!")
                    .font(.title)
                Text("Sua solicitação foi enviada.")
                
                Spacer()
                
                Image(uiImage: (UIImage(data: self.demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                    .resizable()
                    .frame(width: 170, height: 170)
                    .cornerRadius(20)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                Text(self.demand.title)
                    .font(.headline)
                HStack {
                   Image(systemName: "briefcase.fill")
                       .scaleEffect(0.7)
                    Text(self.demand.ownerUser.name)
                       .font(.subheadline)
                }
               
                Spacer()
                
                Text("Você pode acompanhar o status da solicitação na aba de projetos em andamento.")
                    .font(.footnote)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button(action: { self.viewRouter.currentPage = Page.ContentView }){
                    HStack {
                        Text("Voltar a navegação!")
                        .font(.title)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(15)

                }
                
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
