//
//  InProgressView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct AllInProgressView: View {
    
//    var demandsInProgress: [Demand]
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    @EnvironmentObject var viewRouter: ViewRouter
    
    // Demand creation
    @State var showingNewDemand = false
    
    // Demands to be displayed
    @Binding var userSolicitations: [Solicitation]
    @Binding var ownedDemands: [Demand]
    
    // Loading states
    @State var isReloading = false
    var isReloadingProxy: Binding<Bool> {
        Binding<Bool>(
            get: { self.isReloading },
            set: {
                if $0 == true {
                    if self.viewRouter.loggedUser!.accountType == "student" {
                        self.loadSudentData()
                    } else {
                        self.loadBusinessData()
                    }
                }
                self.isReloading = $0
        }
        )
    }
    
    var body: some View {
        Container {
            ZStack {
                RefreshableScrollView(refreshing: self.isReloadingProxy) {
//                    ForEach((0..<self.demandsInProgress.count), id: \.self){ i in
//                        self.generateCard(demand: self.demandsInProgress[i])
//                    }
                    if self.viewRouter.loggedUser!.accountType == "student" {
                        ForEach((0..<self.userSolicitations.count), id: \.self){ i in
                            self.generateStudentCard(solicitation: self.userSolicitations[i])
                        }
                        .padding(.vertical)
                    } else {
                        ForEach((0..<self.ownedDemands.count), id: \.self){ i in
                            self.generateBusinessCard(demand: self.ownedDemands[i])
                        }
                        .padding(.vertical)
                    }
                }
                if self.viewRouter.loggedUser!.accountType == "business" {
                    self.generateNewDemandButton()
                }
            }
        }
        .onAppear(perform: {
            if self.viewRouter.loggedUser!.accountType == "student" {
                if self.userSolicitations.isEmpty {
                    self.loadSudentData()
                }
            } else {
                if self.ownedDemands.isEmpty {
                    self.loadBusinessData()
                }
            }
            self.sharedNavigation.type = .large
            self.sharedNavigation.title = "Em andamento"
        })
    }
    
    func loadSudentData(){
        print("=========> Loading student's in progress")
        self.isReloading = true
        let user = self.viewRouter.loggedUser!
        Solicitation.ckLoadByUser(userRecordName: user.recordName!, then: { (result) -> Void in
            switch result {
            case .success(let solicitations):
                print("=========> Finished loading student's in progress")
                self.userSolicitations = []
                for solicitation in solicitations {
                    if solicitation.demand.isFinished == Demand.IsFinished.no.rawValue{
                        self.userSolicitations.append(solicitation)
                    }
                }
                self.isReloading = false
            case .failure(let error):
                debugPrint("Erro on getting student`s in progress: ", error)
            }
        })
    }
    
    func loadBusinessData() {
        print("=========> Loading business's in progress")
        self.isReloading = true
        let user = self.viewRouter.loggedUser!
        Demand.ckLoadByOwner(ownerRecordName: user.recordName!, then: { (result) -> Void in
            switch result {
            case .success(let demands):
                print("=========> Finished loading business's in progress")
                self.ownedDemands = []
                for demand in demands {
                    if demand.isFinished == Demand.IsFinished.no.rawValue{
                        self.ownedDemands.append(demand)
                    }
                }
                self.isReloading = false
            case .failure(let error):
                debugPrint("Erro on getting bueiness`s in progress: ", error)
            }
        })
    }
    
    func generateStudentCard(solicitation: Solicitation) -> some View {
        
        let demand = solicitation.demand
        
        return NavigationLink(destination: DemandInProgressView(demand: demand)){
            VStack {
                HStack(alignment: .top) {
                    Image(uiImage: (UIImage(data: demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .cornerRadius(15)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(demand.title)
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                        Divider()
                        HStack {
                            Image(systemName: "briefcase.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.ownerUser.name)
                                .font(.subheadline)
                        }
                        HStack {
                            Image(systemName: "folder.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.categorys.joined(separator: ", "))
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        HStack {
                            Image(systemName: "location.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.location)
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(8)
                if solicitation.status == Solicitation.Status.waiting.rawValue{
                    Text("Status: Aguardando avaliação")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                } else if solicitation.status == Solicitation.Status.accepted.rawValue{
                    ProgressBar(value: 0.4)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                } else {
                    Text("Status: Recusado")
                        .foregroundColor(.red)
                        .font(.subheadline)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 8)
                }
            }
            .background(Color("cardBackgroundColor"))
            .cornerRadius(20)
            .shadow(radius: 6, y: 6)
        }
        .disabled(solicitation.status != Solicitation.Status.accepted.rawValue)
        .padding(.horizontal)
        .padding(.bottom)
        .buttonStyle(PlainButtonStyle())
    }
    
    func generateBusinessCard(demand: Demand) -> some View {
        return NavigationLink(destination: DemandInProgressView(demand: demand)){
            VStack {
                HStack(alignment: .top) {
                    Image(uiImage: (UIImage(data: demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 120, height: 120)
                        .cornerRadius(15)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(demand.title)
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                        Divider()
                        HStack {
                            Image(systemName: "briefcase.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.ownerUser.name)
                                .font(.subheadline)
                        }
                        HStack {
                            Image(systemName: "folder.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.categorys.joined(separator: ", "))
                                .font(.subheadline)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        HStack {
                            Image(systemName: "location.fill")
                                .scaleEffect(0.7)
                                .foregroundColor(Color.gray)
                            Text(demand.location)
                                .font(.subheadline)
                        }
                    }
                }
                ProgressBar(value: calculateProgresBarPoint(demand: demand))
                    .padding(.vertical, 5)
                Spacer()
            }
            .padding(8)
            .background(Color("cardBackgroundColor"))
            .cornerRadius(20)
            .shadow(radius: 6, y: 6)
        }
        .padding(.horizontal)
//        .padding(.bottom)
        .buttonStyle(PlainButtonStyle())
    }
    
    func generateNewDemandButton() -> some View {
        return VStack() {
            Spacer()
            Button(action: {
                self.showingNewDemand.toggle()
            }) {
                HStack {
                    Image(systemName: "plus")
                        .scaleEffect(0.9)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .padding(.leading)
                    Text("Nova demanda")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .padding(.trailing)
                }
                .background(Color.blue)
                .cornerRadius(15)
                .padding()
                .shadow(radius: 6, y: 6)
            }.sheet(isPresented: self.$showingNewDemand) {
                NewDemandView().environmentObject(self.viewRouter)
            }
        }.frame(minHeight: 0, maxHeight: .infinity)
    }
    
    func calculateProgresBarPoint(demand: Demand) -> CGFloat {
        
        let deadline = demand.deadline
        
        if demand.estimatedDuration == "Curta" {
            let daysToEnd = Date().daysTo(date: deadline.sumDays(amount: 14))
            if daysToEnd > 14 {
                return 0.0
            } else {
                return 1.0 - CGFloat(daysToEnd).map(from: 0...14, to: 0...1)
            }
        } else if demand.estimatedDuration == "Média" {
            let daysToEnd = deadline.daysTo(date: deadline.sumDays(amount: 30))
            if daysToEnd > 30 {
                return 0.0
            } else {
                return 1.0 - CGFloat(daysToEnd).map(from: 0...30, to: 0...1)
            }
        } else {
            let daysToEnd = deadline.daysTo(date: deadline.sumDays(amount: 60))
            if daysToEnd > 60 {
                return 0.0
            } else {
                return 1.0 - CGFloat(daysToEnd).map(from: 0...60, to: 0...1)
            }
        }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AllInProgressView(userSolicitations: .constant([]), ownedDemands: .constant([]))
    }
}
