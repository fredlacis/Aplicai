//
//  MotherView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Screens data
    @State var exploreDemands: [Demand] = []
    @State var userSolicitations: [Solicitation] = []
    @State var ownedDemands: [Demand] = []
    
    // Error
    @State var errorMessage: String = ""
    
    var body: some View {
        VStack {
            ZStack {
                if self.viewRouter.currentPage == Page.LoadingView {
                    LoadingView()
                        .transition(.opacity)
                } else if self.viewRouter.currentPage == Page.UserTypeView {
                    UserTypeView()
                        .transition(.opacity)
                } else if self.viewRouter.currentPage == Page.SignUpView {
                    SignUpView()
                        .transition(.opacity)
                } else if self.viewRouter.currentPage == Page.ContentView {
                    ContentView(exploreDemands: self.$exploreDemands, userSolicitations: self.$userSolicitations, ownedDemands: self.$ownedDemands).environmentObject(SharedNavigation())
                        .transition(.opacity)
                } else if self.viewRouter.currentPage == Page.DemandView {
                    DemandView(demand: viewRouter.selectedDemand)
                        .transition(.move(edge: .trailing))
                } else if self.viewRouter.currentPage == Page.OnBoardingView {
                    OnBoardingView()
                        .transition(.opacity)
                } else {
                    EmptyView()
                }
                
                if !self.errorMessage.isEmpty {
                    Text(self.errorMessage)
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }.onAppear(perform: {
            self.checkCKConnect()
        })
    }
    
    func publishTestDemand(){
        var testDemand = Demand.empty
        
        testDemand.ownerUser = self.viewRouter.loggedUser!
        
        //testing image
        testDemand.image = UIImage(named: "aplicaiLogo")!.jpegData(compressionQuality: 0.5)
        
        print("Saving a demand")
        testDemand.ckSaveDemand(then: { (result)->Void in
            switch result {
            case .success(let demand):
                testDemand = demand
                print("Sucesso ao salvar demanda")
            case .failure(let error):
                print(error)
                if let errorType = error as? CRUDError,
                    errorType == .invalidRecord {
                    print("Campos inválidos")
                }
            }
        })
    }
    
    func checkCKConnect() {
        CKDefault.container.accountStatus { status, error in
            if let error = error {
              // some error occurred (probably a failed connection, try again)
                print("Connection error: ", error)
            } else {
                switch status {
                    case .available:
                      // the user is logged in
                        self.loadCurrentUser()
                    case .noAccount:
                      // the user is NOT logged in
                        self.errorMessage = "Você deve estar conectado a uma conta iCloud para utilizar o app."
                        print("User not logged in iCloud")
                    case .couldNotDetermine:
                      // for some reason, the status could not be determined (try again)
                        self.errorMessage = "Falha a conectar ao servidor. Tente novamente."
                        print("Failed on checking user status")
                    case .restricted:
                      // iCloud settings are restricted by parental controls or a configuration profile
                        self.errorMessage = "Suas configurações não permitem a conexão aos servidores. Verifique o controle parental e os perfis de configuração."
                        print("User configs block icloud access")
                @unknown default:
                    self.errorMessage = "Erro desconhecido. Tente novamente."
                    print("Unknown error on checking user status")
                }
            }
        }
    }
    
    func loadCurrentUser() {
        DispatchQueue.main.async {
            User.ckLoadByCurrentUserID(then: { (result) -> Void in
                switch result {
                case .success(let records):
                    let userRecords = records as? [User] ?? []
                    if userRecords.count == 1 {
                        print("Usuário com este userID existe:", userRecords[0])
                        self.viewRouter.loggedUser = userRecords[0]
                        self.viewRouter.currentPage = Page.ContentView
                    } else if userRecords.count > 1 {
                        print("Mais de um usuário com o mesmo userID.")
                    } else {
                        print("Nenhum usuário com o userID, criaremos um.")
                        self.viewRouter.currentPage = Page.UserTypeView
                    }
                case .failure(let error):
                    debugPrint("Erro ao buscar usuário pelo userID.", error)
                }
            })
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
//        MotherView(viewRouter: ViewRouter())
        MotherView().environmentObject(ViewRouter())
    }
}
