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
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var finishedDemands: [Demand] = []
        
    @State var courseSemester: String = "X"
    
    @State var user: User?
    
    // Loading states
    @State var isReloading = false
    var isReloadingProxy: Binding<Bool> {
        Binding<Bool>(
            get: { self.isReloading },
            set: {
                if $0 == true {
                    self.loadFinishedDemands()
                }
                self.isReloading = $0
        }
        )
    }
    
    var body: some View {
        Container {
            RefreshableScrollView(refreshing: self.isReloadingProxy) {
                if !self.isReloading {
                    VStack() {
                        self.generateProfileHeader(user: self.user ?? self.viewRouter.loggedUser!)
                        HStack {
                            Text("Demandas concluídas")
                                .font(.headline)
                            Spacer()
                        }
                        if self.finishedDemands.isEmpty {
                            Text("Nenhuma demanda concluída...")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding()
                        } else {
                            ForEach(0..<self.finishedDemands.count, id: \.self){ i in
                                ExploreCard(demand: self.finishedDemands[i])
                                        .padding(.bottom, 8)
                                        .onTapGesture {
                                                self.viewRouter.selectedDemand = self.finishedDemands[i]
                                                self.viewRouter.currentPage = Page.DemandView
                                        }
                            }
                        }
                        Spacer(minLength: 0)
                    }
                        .padding()
                }
            }
        }
        .onAppear(perform: {
            
            if self.finishedDemands.isEmpty {
                self.loadFinishedDemands()
            }
            
            self.sharedNavigation.type = .inline
            
            let currentUser = self.user ?? self.viewRouter.loggedUser!
            
            if currentUser.accountType == "student" {
                self.calculateCourseSemester(user: currentUser)
                self.sharedNavigation.title = "Perfil do Estudante"
            } else {
                self.sharedNavigation.title = "Perfil do Empreendimento"
            }
        })
    }
    
    func generateProfileHeader(user: User) -> some View {
        return VStack {
            HStack(alignment: .center) {
                Image(uiImage: UIImage(data: user.avatarImage ?? Data()) ?? UIImage(named: "avatarPlaceholder")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .cornerRadius(15)
                    .shadow(radius: 6, y: 6)
                VStack(alignment: .leading, spacing: 5) {
                    Text(user.name)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.headline)
                    Divider()
                    if(user.accountType == "student"){
                        HStack {
                            Image(systemName: "studentdesk")
                                .scaleEffect(0.7)
                            Text(user.course)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.subheadline)
                        }
                        HStack {
                            Image(systemName: "number")
                                .scaleEffect(0.7)
                            Text(self.courseSemester + "º Período")
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.subheadline)
                        }
                    }
                    HStack {
                        Image(systemName: "envelope.fill")
                            .scaleEffect(0.7)
                        Text(user.email)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                    }
                }
            }
            .padding(.bottom)
            HStack(spacing: 0){
                VStack(alignment: .leading){
                    
                    HStack {
                        if user.linkedin != ""{
                            Button(action: {
                                    UIApplication.shared.open(URL(string: user.linkedin)!)
                            }){
                                Text("Acessar Linkedin")
                                    .foregroundColor(Color.white)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding(5)
                            }
                            .background(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                            .cornerRadius(15)
                            .padding(.trailing)
                        }
                        if user.website != ""{
                            Button(action: {
                                UIApplication.shared.open(URL(string: user.website)!)
                            }){
                                if(user.accountType == "student"){
                                    Text("Acessar Portfólio")
                                        .foregroundColor(Color.white)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding(5)

                                } else {
                                    Text("Acessar Site")
                                        .foregroundColor(Color.white)
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .padding(5)

                                }
                            }
                            .background(Color.blue)
                            .buttonStyle(PlainButtonStyle())
                            .cornerRadius(15)
                        }
                    }
                    
                    if(user.accountType == "business"){
                        Text("Descrição:")
                        .font(.headline)
                            .padding(.top)
                        LongText(user.functionDescription)
                    }
                    Divider()
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    func loadFinishedDemands() {
        self.isReloading = true
        let currentUser = self.user ?? self.viewRouter.loggedUser!
        if currentUser.accountType == "student" {
            Solicitation.ckLoadByUser(userRecordName: currentUser.recordName!, then: { (result) -> Void in
                switch result {
                case .success(let solicitations):
                    self.finishedDemands = []
                    for solicitation in solicitations {
                        if solicitation.demand.isFinished == Demand.IsFinished.yes.rawValue {
                            self.finishedDemands.append(solicitation.demand)
                        }
                    }
                    self.isReloading = false
                case .failure(let error):
                    debugPrint("Erro on getting student`s in progress: ", error)
                }
            })
        } else {
            Demand.ckLoadByOwner(ownerRecordName: currentUser.recordName!, then: { (result) -> Void in
                switch result {
                case .success(let demands):
                    self.finishedDemands = []
                    for demand in demands {
                        if demand.isFinished == Demand.IsFinished.yes.rawValue {
                            self.finishedDemands.append(demand)
                        }
                    }
                    self.isReloading = false
                case .failure(let error):
                    debugPrint("Erro on getting bueiness`s in progress: ", error)
                }
            })
        }
    }
    
    func calculateCourseSemester(user: User) {
        
        let regNum = user.registrationNumber
        
        let index = regNum.index(regNum.startIndex, offsetBy: 2)
        
        let regYear = Int(regNum[..<index])
        
        let endIndex = regNum.index(regNum.startIndex, offsetBy: 3)
        
        let regSemester = Int(regNum[index..<endIndex])
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yy"
        let year = Int(formatter.string(from: Date()))
        
        formatter.dateFormat = "MM"
        let month = Int(formatter.string(from: Date()))
        
        if month! > 6 && regSemester == 1{
            let semester = (year!+1 - regYear!) * 2
            self.courseSemester = String(semester == 0 ? 1 : semester)
        } else if month! > 6 {
            let semester = ((year!+1 - regYear!) * 2) - 1
            self.courseSemester = String(semester == 0 ? 1 : semester)
        } else if month! < 6 && regSemester == 1 {
            let semester = (year! - regYear!) * 2 + 1
            self.courseSemester = String(semester == 0 ? 1 : semester)
        } else {
            let semester = (year! - regYear!) * 2
            self.courseSemester = String(semester == 0 ? 1 : semester)
        }
        
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(ViewRouter())
            .environmentObject(SharedNavigation())
    }
}
