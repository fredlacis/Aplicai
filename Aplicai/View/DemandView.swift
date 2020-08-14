//
//  DemandView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var demand: Demand = Demand.empty
    
    @State var wasSolicited = true
    
    var body: some View {
        NavigationView {
            Container {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack(alignment: .top) {
                            VStack {
                                Image(uiImage: (UIImage(data: self.demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .aspectRatio(contentMode: .fill)
                                    .shadow(radius: 6, y: 6)
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Text(self.demand.title)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                Divider()
                                HStack {
                                    Image(systemName: "briefcase.fill")
                                        .scaleEffect(0.7)
                                    Text(self.demand.ownerUser.name)
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
                        VStack(alignment: .center) {
                            NavigationLink(destination:
                                ProfileView(user: self.demand.ownerUser)
                                    .navigationBarTitle("Perfil do Empreendimento")
                                    .environmentObject(SharedNavigation())
                            ){
                                Text("Ver perfil do empreendimento")
                                    .font(.subheadline)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(5)
                                    .padding(.horizontal)
                            }
                            .fixedSize(horizontal: false, vertical: true)
                        }.frame(minWidth: 0, maxWidth: .infinity)
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
                                Text("10/09/2020")
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
                                Text("Média, até 1 mês")
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
                                Text("2 participantes")
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
                        if self.demand.isFinished == Demand.IsFinished.no.rawValue {
                            if self.viewRouter.loggedUser!.accountType == "student" {
                                if self.wasSolicited {
                                    Text("Você já fez uma solicitação para participar desta demanda, acompanhe o status da solicitação na aba \"Em andamento\".")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .multilineTextAlignment(.center)
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.top)
                                } else {
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
                                    .disabled(self.wasSolicited)
                                }
                            }
                        } else {
                            Text("Esta demanda já foi concluída pelo seu criador.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top)
                        }
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
                .onAppear(perform: self.checkSolicitation)
        }
    }
    
    func checkSolicitation() {
        
        Solicitation.ckLoadByUserAndDemand(userRecordName: self.viewRouter.loggedUser!.recordName!,
                                           demandRecordName: self.demand.recordName!, then: { (result) -> Void in
                switch result {
                    case .success(let solicitation):
                        if solicitation != nil {
                            self.wasSolicited = true
                        } else {
                            self.wasSolicited = false
                        }
                    case .failure(let error):
                        debugPrint("Erro on verifying if there already is a solicitation: ", error)
                }
            })
        
    }
}

struct DemandView_Previews: PreviewProvider {
    static var previews: some View {
        DemandView(demand: testData[0]).environmentObject(ViewRouter())
    }
}
