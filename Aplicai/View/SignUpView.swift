//
//  SignUpView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    
//    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var viewRouter: ViewRouter
    
    var userType = UserDefaults.standard.string(forKey: "Type")
    
    @State private var name: String = ""
    @State private var email: String = ""
    
    //For student
    @State private var cpf: String = ""
    @State private var course: String = ""
    @State private var registrationNumber: String = ""
    
    //For business
    @State private var cnpj: String = ""
    @State private var companyName: String = ""
    @State private var functionDescription: String = ""
    
    var body: some View {
        Container {
            VStack(alignment: .leading, spacing: 0) {
                Form {
                    Section(header: Text(self.userType == "student" ? "Aluno" : "Empreendimento")
                        .font(.largeTitle)) {
                            TextField(self.userType == "student" ? "Nome Completo" : "Nome da Empresa", text: self.$name)
                            TextField("E-mail", text: self.$email)
                            if self.userType == "student" {
                                TextField("CPF", text: self.$cpf)
                                TextField("Curso", text: self.$course)
                                TextField("Matrícula", text: self.$registrationNumber)
                            } else if self.userType == "business" {
                                TextField("CNPJ", text: self.$cnpj)
                                TextField("Razão Social", text: self.$companyName)
                                TextField("Classificação", text: self.$functionDescription)
                            }
                    }
                }
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = .clear
                })
                Button(action: {
                    self.viewRouter.currentPage = Page.ContentView
                }){
                    Text("Criar conta")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
                .backgroundColor(Color.blue)
                .cornerRadius(15)
                .padding()
            }
            .padding(.top)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
//        SignUpView(viewRouter: ViewRouter())
        SignUpView().environmentObject(ViewRouter())
    }
}
