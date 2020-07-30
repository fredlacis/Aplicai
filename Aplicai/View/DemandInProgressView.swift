//
//  DemandInProgress.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandInProgressView: View {
    
    var demand: Demand
    
    @State private var newToDo: String = ""

    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Container {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .center) {
                        Image(self.demand.image)
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
                    VStack(alignment: .trailing, spacing: 5) {
                        Text("Faltam 13 dias")
                        ProgressBar(value: 0.6)
                            .frame(height: 10)
                        HStack {
                            Spacer()
                            VStack(alignment: .trailing) {
                                Text("Entrega do projeto")
                                    .fontWeight(.thin)
                                Text("23/11/2020")
                            }
                            Image(systemName: "calendar")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                        }
                    }
                    VStack(alignment: .leading){
                        Text("Tarefas")
                            .font(.title)
                        HStack {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .aspectRatio(contentMode: .fit)
                            VStack(alignment: .leading) {
                                Text("10/10/2000")
                                    .font(.subheadline)
                                    .fontWeight(.thin)
                                Text("Preparar materiais de aula")
                            }
                            Spacer()
                        }
                        HStack {
                            Image(systemName: "square")
                                .resizable()
                                .frame(width: 35, height: 35)
                                .aspectRatio(contentMode: .fit)
                            VStack(alignment: .leading) {
                                Text("10/10/2000")
                                    .font(.subheadline)
                                    .fontWeight(.thin)
                                Text("Testar em diferentes simuladores, incluindo thinkercad.")
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            Spacer()
                        }
                        VStack {
                            TextField("Nova tarefa", text: self.$newToDo, onCommit: {
                                print("Nova tarefa adicionada!")
                            })
                                .padding(.horizontal)
                                .padding(.top)
                            Divider()
                                .padding(.horizontal)
                                .padding(.bottom)
                            
                        }
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(15)
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DemandInProgress_Previews: PreviewProvider {
    static var previews: some View {
        DemandInProgressView(demand: testData[0])
    }
}
