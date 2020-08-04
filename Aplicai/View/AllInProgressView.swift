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
    
    var body: some View {
//        NavigationView{
            Container {
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
            }
            .onAppear(perform: {
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
