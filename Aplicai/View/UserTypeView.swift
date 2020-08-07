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
                    self.viewRouter.loggedUser = User.emptyStudent
                    self.viewRouter.currentPage = Page.OnBoardingView
                }) {
                    VStack {
                        Image("lapis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 150)
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
                    self.viewRouter.loggedUser = User.emptyBusiness
                    self.viewRouter.currentPage = Page.OnBoardingView
                }) {
                    VStack {
                        Image("maleta")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 150)
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
