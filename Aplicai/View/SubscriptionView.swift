//
//  SubscriptionView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct SubscriptionView: View {
    
    var demand: Demand
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var motivationText: String = ""
    
    var body: some View {
        Container {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        Image(self.demand.image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(self.demand.title)
                                .font(.headline)
                            Divider()
                            HStack {
                                Image(systemName: "briefcase.fill")
                                    .scaleEffect(0.7)
                                Text(self.demand.businessName)
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "folder.fill")
                                    .scaleEffect(0.7)
                                Text(self.demand.categorys.joined(separator: ", "))
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "location.fill")
                                    .scaleEffect(0.7)
                                Text(self.demand.location)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Text("Interessado nesse projeto?")
                        .font(.title)
                    Text("O que te faz querer ingressar nesse projeto?")
                        .font(.subheadline)
                    Text("Conte um pouco sobre suas ambições para seu parceiro!")
                        .font(.subheadline)
                    
                    RoundedRectangle(cornerRadius: 15).strokeBorder(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                        .overlay(
                            VStack {
                                MultilineTextField("Escreva um pequeno texto dizendo suas motivações para participar deste projeto.", text: self.$motivationText, onCommit: { print(self.motivationText) })
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                Spacer()
                            }
                        )
                        .frame(minHeight: 250)
                    
                    NavigationLink(destination: ValidationView(demand: self.demand)) {
                        HStack {
                            Text("Enviar")
                            .font(.title)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(15)
                            
                    }
                    .isDetailLink(true)
                    .padding(.top)
                    
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(demand: testData[0])
    }
}
