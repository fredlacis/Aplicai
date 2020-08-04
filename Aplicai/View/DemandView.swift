//
//  DemandView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandView: View {
    
    var demand: Demand = testData[0]
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        NavigationView {
            Container {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .center) {
                            Image(self.demand.image)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .cornerRadius(20)
                            VStack(alignment: .leading, spacing: 5) {
                                Text(self.demand.title)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                Divider()
                                HStack {
                                    Image(systemName: "briefcase.fill")
                                        .scaleEffect(0.7)
                                    Text(self.demand.businessName)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.subheadline)
                                }
                                HStack {
                                    Image(systemName: "folder.fill")
                                        .scaleEffect(0.7)
                                    Text(self.demand.categorys.joined(separator: ", "))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.subheadline)
                                }
                                HStack {
                                    Image(systemName: "location.fill")
                                        .scaleEffect(0.7)
                                    Text(self.demand.location)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.subheadline)
                                }
                            }
                        }
                        Text("Descrição:")
                            .font(.headline)
                        LongText(self.demand.description)
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
                                Text(self.demand.categorys.joined(separator: ", "))
                                    .fixedSize(horizontal: false, vertical: true)
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
                    }
                    .padding()
                    .padding(.bottom, 300)
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                Button(action: { self.viewRouter.currentPage = Page.ContentView }){
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 26))
                        Text("Explorar")
                    }
            })
        }
    }
}

struct DemandView_Previews: PreviewProvider {
    static var previews: some View {
        DemandView(demand: testData[0])
    }
}
