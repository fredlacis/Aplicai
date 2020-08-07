//
//  ProfileView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 30/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    @State var index = 0
    
    var body: some View {
        Container {
            ScrollView {
                VStack{
                    HStack(){
                        Image("Perfil")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding(.top,6)
                            .padding(.bottom,4)
                            .padding(.horizontal,4)
                            .background(Color("cardBackgroundColor"))
                            .cornerRadius(10)
                            .shadow(radius: 6, y: 6)
//                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)
                    VStack(alignment: .leading, spacing: 12){
                            Text("Nome")
                                .font(.title)
                                //.foregroundColor(Color.black.opacity(0.8))
                            Text("Curso de Graduação | PUC-Rio")
                                //.foregroundColor(Color.black.opacity(0.7))
                                .padding(.top,4)
                            Text("Período")
                                //.foregroundColor(Color.black.opacity(0.7))
                            Text("Email para contato")
                                //.foregroundColor(Color.black.opacity(0.7))
                            Text("Telefone para contato")
                                //.foregroundColor(Color.black.opacity(0.7))
                        }
                        .padding(.leading,20)
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    HStack(spacing: 0){
                        VStack(spacing: 12){
                            Text("Linkedin: xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                                //.foregroundColor(Color.black.opacity(0.7))
                            Text("Portfólio: xxxxxxxxxxxxxxxxxxxxxxxxxxxx")
                                //.foregroundColor(Color.black.opacity(0.7))
                        }
                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    HStack{
                        Button(action: {
                            withAnimation(){
                                self.index = 0
                            }
                        }) {
                            Text("Habilidades")
                                //.foregroundColor(self.index == 0 ? Color.white : .gray)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(self.index == 0 ? Color("backgroundColor") : Color.clear)
                                .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())
                        Button(action: {
                            withAnimation(){
                                self.index = 1
                            }
                        }) {
                            Text("Demandas Concluídas")
                                //.foregroundColor(self.index == 1 ? Color.white : .gray)
                                .padding(.vertical,10)
                                .padding(.horizontal)
                                .background(self.index == 1 ? Color("backgroundColor") : Color.clear)
                                .cornerRadius(10)
                        }.buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(Color("cardBackgroundColor"))
                    .cornerRadius(8)
                        .shadow(radius: 6, y: 6)
//                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                    .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                    .padding(.horizontal)
                    .padding(.top,20)
                    if self.index == 0 {
                        VStack {
                            HStack(spacing: 20){
                                VStack(spacing: 12) {
                                    Image("excel")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Excel")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Hashtag Treinamentos")
                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("40 Horas")
                                        .font(.caption)
                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                                VStack(spacing: 12) {
                                    Image("python")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Python")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Prog 1 e 2 - PUC-Rio")
                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("2 Períodos")
                                        .font(.caption)
                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                            }
                            .padding(.top,20)
                            HStack(spacing: 20){
                            VStack(spacing: 12) {
                                Image("figma")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Text("Figma")
                                    .font(.headline)
                                    .padding(.top,10)
                                Text("Apple Developer Academy PUC-Rio")
                                    //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                Text("6 Meses")
                                    .font(.caption)
                                    //.foregroundColor(.gray)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                            .background(Color("cardBackgroundColor"))
                            .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                            .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                            VStack(spacing: 12) {
                                Image("power bi")
                                    .resizable()
                                    .frame(width: 80, height: 80)
                                Text("Power Bi")
                                    .font(.headline)
                                    .padding(.top,10)
                                Text("Hashtag Treinamentos")
                                    //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                Text("40 Horas")
                                    .font(.caption)
                                    //.foregroundColor(.gray)
                            }
                            .padding(.vertical)
                            .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                            .background(Color("cardBackgroundColor"))
                            .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                            .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                        }
                        }.transition(.opacity)
                    } else {
                        VStack {
                            HStack(spacing: 20){
                                VStack(spacing: 12) {
                                    Image("livros")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Organização da Biblioteca Comunitária")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Ler+")
                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("1 Mês")
                                        .font(.caption)
                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                                VStack(spacing: 12) {
                                    Image("padaria2")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Controle de fluxo de caixa")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Confeitaria Maria")
                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("2 Meses")
                                        .font(.caption)
                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                            }
                            .padding(.top,20)
                            HStack(spacing: 20){
                                VStack(spacing: 12) {
                                    Image("tarefa")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Revisão de Livro")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Editora Zahar")
                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("1 Mês")
                                        .font(.caption)
                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                                VStack(spacing: 12) {
                                    Image("site")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                    Text("Desenvolvimento de site")
                                        .font(.headline)
                                        .padding(.top,10)
                                    Text("Chocotose")
//                                        //.foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    Text("2 Semanas")
                                        .font(.caption)
//                                        //.foregroundColor(.gray)
                                }
                                .padding(.vertical)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                .background(Color("cardBackgroundColor"))
                                .cornerRadius(15)
                                .shadow(radius: 6, y: 6)
//                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
//                                .shadow(color: Color.white.opacity(0.2), radius: 5, x: -8, y: -8)
                            }
                        }.transition(.opacity)
                    }
                    Spacer(minLength: 0)
                }
            }
        }
        .onAppear(perform: {
            self.sharedNavigation.title = "Perfil"
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
