//
//  SolicitationView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 10/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct SolicitationView: View {
    var body: some View {
        Container {
            VStack {
                HStack(alignment: .center) {
                    Image("cassandra")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)
                        .shadow(radius: 6, y: 6)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Cassandra Jones")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.headline)
                        Button(action: {}){
                            Text("Ver perfil")
                                .foregroundColor(Color.white)
                                .padding(5)
                                .padding(.horizontal)
                        }
                        .background(Color.blue)
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(15)
                    }
                    Spacer()
                }
                .padding(.bottom)
                Text("Estou no terceiro período de computação na PUC-Rio e me interesso muito por criação de sites. Eu mesma já criei um site para vender alguns colares que faço como hobby. Seria uma enorme oportunidade trabalhar com o senhor e aprimorar meu conhecimento.")
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                HStack {
                    Button(action: {}){
                        Text("Aceitar")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(10)
                    }
                    .background(Color.green)
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(15)
                    
                    Button(action: {}){
                        Text("Recusar")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(10)
                    }
                    .background(Color.red)
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(15)
                }
            }
        .padding()
        }
    }
}

struct SolicitationView_Previews: PreviewProvider {
    static var previews: some View {
        SolicitationView()
    }
}
