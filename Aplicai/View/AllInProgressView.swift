//
//  InProgressView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct AllInProgressView: View {
    
    var demandsInProgress: [Demand]
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        //        NavigationView{
        Container {
            ZStack {
                ScrollView {
                    ForEach(self.demandsInProgress, id: \.id){ demand in
                        NavigationLink(destination: DemandInProgressView(demand: demand)){
                            VStack {
                                HStack(alignment: .center) {
                                    Image(demand.image)
                                        .resizable()
                                        .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                                        .frame(width: 120)
                                        .cornerRadius(20)
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(demand.title)
                                            .font(.headline)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Divider()
                                        HStack {
                                            Image(systemName: "briefcase.fill")
                                                .scaleEffect(0.7)
                                                .foregroundColor(Color.gray)
                                            Text(demand.businessName)
                                                .font(.subheadline)
                                        }
                                        HStack {
                                            Image(systemName: "folder.fill")
                                                .scaleEffect(0.7)
                                                .foregroundColor(Color.gray)
                                            Text(demand.categorys.joined(separator: ", "))
                                                .font(.subheadline)
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        HStack {
                                            Image(systemName: "location.fill")
                                                .scaleEffect(0.7)
                                                .foregroundColor(Color.gray)
                                            Text(demand.location)
                                                .font(.subheadline)
                                        }
                                    }
                                    //                                    Spacer()
                                }
                                ProgressBar(value: 0.4)
                                    .padding(.top, 5)
                                Spacer()
                            }
                            .padding()
                            .background(Color("cardBackgroundColor"))
                            .cornerRadius(20)
                            .shadow(radius: 6, y: 6)
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.vertical)
                }
                if self.viewRouter.loggedUser!.accountType == "business" {
                    VStack() {
                        Spacer()
                        NavigationLink(destination: NewDemandView()){
                            HStack {
                                Image(systemName: "plus")
                                    .scaleEffect(0.9)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical)
                                    .padding(.leading)
                                Text("Nova demanda")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                                    .padding(.vertical)
                                    .padding(.trailing)
                            }
                            .background(Color.blue)
                            .cornerRadius(15)
                            .padding()
                            .shadow(radius: 6, y: 6)
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                }
            }
        }
        .onAppear(perform: {
            self.sharedNavigation.type = .large
            self.sharedNavigation.title = "Em andamento"
        })
        //            .navigationBarTitle("Em andamento")
        //        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AllInProgressView(demandsInProgress: testData)
    }
}
