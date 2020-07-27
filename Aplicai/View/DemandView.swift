//
//  DemandView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandView: View {
    
    var demand: Demand
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.1803921569, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        Image(demand.image)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(demand.title)
                                .font(.headline)
                            Divider()
                            HStack {
                                Image(systemName: "briefcase.fill")
                                    .scaleEffect(0.7)
                                Text(demand.businessName)
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "folder.fill")
                                    .scaleEffect(0.7)
                                Text(demand.categorys.joined(separator: ", "))
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "location.fill")
                                    .scaleEffect(0.7)
                                Text(demand.location)
                                    .font(.subheadline)
                            }
                        }
                    }
                    Text("Descrição:")
                        .font(.headline)
                    Text(demand.description)
                        .lineSpacing(4)
                    Divider().padding(.top).padding(.bottom)
                    HStack {
                        Image(systemName: "calendar")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text("Fim das inscrições")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text("99/99/9999")
                        }
                    }
                    HStack {
                        Image(systemName: "clock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text("Duração")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text("99 semanas")
                        }
                    }
                    HStack {
                        Image(systemName: "person.3.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(Color.gray)
                        VStack(alignment: .leading) {
                            Text("Grupo")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text("99 participantes")
                        }
                    }
                    HStack {
                        Image(systemName: "folder.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40)
                            .foregroundColor(.gray)
                        VStack(alignment: .leading) {
                            Text("Categorias")
                                .font(.subheadline)
                                .fontWeight(.thin)
                            Text(demand.categorys.joined(separator: ", "))
                        }
                    }
                    NavigationLink(destination: SubscriptionView(demand: self.demand)) {
                        HStack {
                            Text("Quero me inscrever!")
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
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DemandView_Previews: PreviewProvider {
    static var previews: some View {
        DemandView(demand: testData[0])
    }
}
