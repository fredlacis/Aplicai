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
    
    var body: some View {
        VStack {
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
                ContentView().environmentObject(SharedNavigation())
                    .transition(.opacity)
            } else if self.viewRouter.currentPage == Page.DemandView {
                DemandView(demand: viewRouter.selectedDemand)
                    .transition(.move(edge: .trailing))
            } else if self.viewRouter.currentPage == Page.OnBoardingView {
                OnBoardingView()
                    .transition(.opacity)
            } else {
                Text("")
            }
        }.onAppear(perform: {
            self.loadCurrentUser()
        })
    }
    
    func publishTestDemand(){
        var testDemand = Demand.empty
        
        testDemand.ownerUser = self.viewRouter.loggedUser!
        
        //testing image
        testDemand.image = UIImage(named: "aplicaiLogo")!.jpegData(compressionQuality: 0.5)
        
        print("Saving a demand")
        testDemand.ckSave(then: { (result)->Void in
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
    
    func getAllDemands() {
        
        var allDemands: [Demand] = []
        
        Demand.ckLoadAllDemands(then: { (result)->Void in
            switch result {
                case .success(let records):
                    allDemands = records
                    print("Sucesso ao pegar demandas--------")
                    dump(allDemands)
                    testData.append(contentsOf: allDemands)
//                    self.bottomMessage = "\(self.demands.count) registros"
                case .failure(let error):
                    debugPrint(error)
//                    self.bottomMessage = "Erro ao atualizar"
                
            }
        })
        
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
//                        self.publishTestDemand()
                        self.getAllDemands()
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
