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
    
    @State private var characterCounter: Int = 0
    
    var body: some View {
        Container {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Image(uiImage: (UIImage(data: self.demand.image  ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
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
                    

                    VStack(alignment: .trailing) {
                        MultilineTextField(placeholder: "Escreva um pequeno texto dizendo suas motivações para participar deste projeto.", text: self.$motivationText, textCounter: self.$characterCounter, onCommit: { print(self.motivationText) })
                            .multilineTextAlignment(.leading)
                            .padding()
                        Spacer()
                        Text("\(self.characterCounter)/400")
                            .padding()
                    }
                    .frame(minHeight: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    )

                    
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
