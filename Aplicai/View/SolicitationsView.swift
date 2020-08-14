//
//  SolicitationsView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 10/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct AllSolicitationsView: View {
    
    @State var showingSolicitation = false
    
    var body: some View {
        Container {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Suas solicitações")
                        .font(.title)
                    Divider()
                    VStack {
                        HStack {
                            Image(testData[0].image)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(10)
                                .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                            VStack(alignment: .leading) {
                                HStack {
                                    Image(systemName: "person.fill")
                                        .scaleEffect(0.7)
                                    Text(testData[0].businessName)
                                        .font(.subheadline)
                                    Spacer()
                                }
                                Button(action: {self.showingSolicitation.toggle()}){
                                    Text("Detalhes da solicitação")
                                        .foregroundColor(Color.white)
                                        .padding(5)
                                        .padding(.horizontal)
                                }.sheet(isPresented: self.$showingSolicitation) {
                                    AllSolicitationsView()
                                }
                                .background(Color.blue)
                                .buttonStyle(PlainButtonStyle())
                                .cornerRadius(15)
                            }
                        }
                        Divider()
                    }
                }
                .padding()
            }
        }
    }
}

struct SolicitationsView_Previews: PreviewProvider {
    static var previews: some View {
        AllSolicitationsView()
    }
}
