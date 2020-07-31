//
//  UserTypeView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct UserTypeView: View {
    
//    @ObservedObject var viewRouter: ViewRouter
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        Container {
            VStack {
                Text("Olá!")
                    .font(.largeTitle)
                Text("Como gostaria de se cadastrar?")
                    .font(.body)
                Spacer()
                Button(action:{
                    UserDefaults.standard.set("student", forKey: "Type")
                    self.viewRouter.currentPage = Page.SignUpView
                }) {
                    VStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 120))
                        Text("Aluno")
                            .font(.largeTitle)
                        Text("procurando mais prática na sua formação.")
                            .font(.title)
                            .fontWeight(.thin)
                            .frame(maxWidth: 300)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                }.buttonStyle(PlainButtonStyle())
                Divider()
                    .padding()
                Button(action: {
                    UserDefaults.standard.set("business", forKey: "Type")
                    self.viewRouter.currentPage = Page.SignUpView
                }) {
                    VStack {
                        Image(systemName: "briefcase")
                            .font(.system(size: 120, weight: .ultraLight))
                        Text("Empreendimento")
                            .font(.largeTitle)
                        Text("Projetos Sociais,\nMicroempreendimentos,\nEmpresas\netc.")
                            .font(.title)
                            .fontWeight(.thin)
                            .frame(maxWidth: 300)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding(.leading)
                            .padding(.trailing)
                    }
                }.buttonStyle(PlainButtonStyle())
                Spacer()
            }
        }
    }
}

struct UserTypeView_Previews: PreviewProvider {
    static var previews: some View {
//        UserTypeView(viewRouter: ViewRouter())
        UserTypeView().environmentObject(ViewRouter())
    }
}
