//
//  DemandInProgress.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandInProgressView: View {
    
    @State var demand: Demand
    
    @State private var newToDo: String = ""

    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var showingSolicitations = false
    
    @State var demandDeadline: String = ""
    @State var daysToEnd: Int = 999
    @State var progressBarValue: CGFloat = 0.0
    
    @State var solicitations: [Solicitation] = []
    
    // Loading states
    @State var isReloading = false
    var isReloadingProxy: Binding<Bool> {
        Binding<Bool>(
            get: { self.isReloading },
            set: {
                if $0 == true {
                    self.loadSolicitations()
                }
                self.isReloading = $0
        }
        )
    }
    
    var body: some View {
        Container {
            RefreshableScrollView(refreshing: self.isReloadingProxy) {
                VStack {
//                    if !self.isReloading {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center) {
                                Image(uiImage: (UIImage(data: self.demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .shadow(radius: 6, y: 6)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(self.demand.title)
                                        .font(.headline)
                                    Divider()
                                    HStack {
                                        Image(systemName: "briefcase.fill")
                                            .scaleEffect(0.7)
                                        Text(self.demand.ownerUser.name)
                                            .font(.subheadline)
                                    }
                                    HStack {
                                        Image(systemName: "folder.fill")
                                            .scaleEffect(0.7)
                                        Text(self.demand.categorys.joined(separator: ", "))
                                            .font(.subheadline)
                                    }
                                    HStack {
                                        Image(systemName: "location.fill")
                                            .scaleEffect(0.7)
                                        Text(self.demand.location)
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
                            VStack(alignment: .trailing, spacing: 5) {
                                if self.demand.isFinished == Demand.IsFinished.no.rawValue {
                                    Text("Faltam \(self.daysToEnd) dias")
                                    ProgressBar(value: self.progressBarValue)
                                        .frame(height: 10)
                                } else {
                                    Text("Demanda concluída")
                                    ProgressBar(value: 1.0)
                                    .frame(height: 10)
                                }
                                HStack {
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        Text("Entrega do projeto")
                                            .fontWeight(.thin)
                                        Text(self.demandDeadline)
                                    }
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color.gray)
                                }
                            }
                            if self.viewRouter.loggedUser!.accountType == "business" && self.demand.isFinished == Demand.IsFinished.no.rawValue{
                                Divider()
                                HStack {
                                    Button(action: {self.showingSolicitations.toggle()}){
                                        Text("Ver solicitações")
                                            .foregroundColor(Color.white)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .padding(5)
                                    }.sheet(isPresented: self.$showingSolicitations) {
                                        AllSolicitationsView(demand: self.demand)
                                    }
                                    .background(Color.blue)
                                    .buttonStyle(PlainButtonStyle())
                                    .cornerRadius(15)
                                    Button(action: self.finishDemand){
                                        Text("Concluir demanda")
                                            .foregroundColor(Color.white)
                                            .frame(minWidth: 0, maxWidth: .infinity)
                                            .padding(5)
                                    }
                                    .background(Color.blue)
                                    .buttonStyle(PlainButtonStyle())
                                    .cornerRadius(15)
                                }
                            }
                            if !self.solicitations.isEmpty {
                                Divider()
                                Text("Participantes")
                                    .font(.headline)
                                HStack(alignment: .top) {
                                    ForEach((0..<self.solicitations.count), id: \.self){ i in
                                        Group {
                                            Spacer()
                                            NavigationLink(destination:
                                                ProfileView(user: self.solicitations[i].student)
                                                    .navigationBarTitle("Perfil do Estudante")
                                                    .environmentObject(SharedNavigation())
                                            ){
                                                VStack(alignment: .center){
                                                    Image(uiImage: (UIImage(data: self.solicitations[i].student.avatarImage ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 70, height: 70)
                                                        .cornerRadius(10)
                                                        .shadow(radius: 6, y: 6)
                                                    Text(self.solicitations[i].student.name)
                                                        .font(.subheadline)
                                                        .fixedSize(horizontal: false, vertical: true)
                                                }
                                            }.buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                    Spacer()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                Text("Contatos")
                                .font(.headline)
                                VStack {
                                    HStack {
                                        Image(systemName: "envelope.fill")
                                            .scaleEffect(0.8)
                                        Text("\(self.demand.ownerUser.name): ")
                                            .fontWeight(.thin)
                                            .fixedSize(horizontal: false, vertical: true)
                                        Spacer()
                                        Text("\(self.demand.ownerUser.email)")
                                            .fixedSize(horizontal: false, vertical: true)
//                                            .font(.subheadline)
                                    }
                                    ForEach((0..<self.solicitations.count), id: \.self){ i in
                                        HStack {
                                            Image(systemName: "envelope.fill")
                                                .scaleEffect(0.8)
                                            Text("\(self.solicitations[i].student.name): ")
                                                .fontWeight(.thin)
                                                .fixedSize(horizontal: false, vertical: true)
                                            Spacer()
                                            Text("\(self.solicitations[i].student.email)")
                                                .fixedSize(horizontal: false, vertical: true)
//                                                .font(.subheadline)
                                        }
                                    }
                                }
                            }
                            Divider()
                            ZStack {
                                VStack(alignment: .leading){
                                    Text("Tarefas")
                                        .font(.title)
                                    HStack {
                                        Image(systemName: "checkmark.square")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .aspectRatio(contentMode: .fit)
                                        VStack(alignment: .leading) {
                                            Text("99/99/9999")
                                                .font(.subheadline)
                                                .fontWeight(.thin)
                                            Text("Tarefas definidas pelo aluno ou pelo empreendimento.")
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "square")
                                            .resizable()
                                            .frame(width: 35, height: 35)
                                            .aspectRatio(contentMode: .fit)
                                        VStack(alignment: .leading) {
                                            Text("99/99/9999")
                                                .font(.subheadline)
                                                .fontWeight(.thin)
                                            Text("Melhorar a organização do projeto entre os participantes.")
                                                .fixedSize(horizontal: false, vertical: true)
                                        }
                                        Spacer()
                                    }
                                    VStack {
                                        TextField("Nova tarefa", text: self.$newToDo, onCommit: {
                                            print("Nova tarefa adicionada!")
                                        })
                                            .padding(.horizontal)
                                            .padding(.top)
                                        Divider()
                                            .padding(.horizontal)
                                            .padding(.bottom)
                                        
                                    }
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(15)
                                }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .opacity(0.2)
                                VStack {
                                Text("Em breve")
                                    .font(.title)
                                }.frame(minWidth: 0, maxWidth: .infinity)
                            }
                        }
                        .padding()
//                    }
                }
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear(perform: {
            self.calculateProgresBarPoint(demand: self.demand)
            if self.solicitations.isEmpty {
                self.loadSolicitations()
            }
        })
    }
    
    func finishDemand() {
        self.isReloading = true
        
        self.demand.isFinished = Demand.IsFinished.yes.rawValue
        
        self.demand.ckSaveDemand(then: { (result)->Void in
            switch result {
            case .success(let demand):
                print("Demand updated with: ", demand.recordName!)
                self.demand = demand
                dump(demand)
                self.viewRouter.currentPage = Page.LoadingView
                self.viewRouter.currentPage = Page.ContentView
                self.isReloading = false
            case .failure(let error):
                print("Error on updating demand")
                debugPrint(error)
            }
        })
    }
    
    func loadSolicitations() {
        self.isReloading = true
        Solicitation.ckLoadByDemand(demandRecordName: self.demand.recordName!,then: { (result) -> Void in
            switch result {
                case .success(let solicitations):
                    self.solicitations = self.getAccepted(solicitations: solicitations)
                    self.isReloading = false
                case .failure(let error):
                    debugPrint("Error on loading solicitations of demand: ", error)
                    self.isReloading = false
            }
        })
        
    }
    
    func getAccepted(solicitations: [Solicitation]) -> [Solicitation]{
        return solicitations.filter { solicitation in
            return solicitation.status == Solicitation.Status.accepted.rawValue
        }
    }
    
    func calculateProgresBarPoint(demand: Demand) {
        
        let deadline = demand.deadline
        
        if demand.estimatedDuration == "Curta" {
            self.demandDeadline = deadline.sumDays(amount: 14).formatDateString()
            self.daysToEnd = Date().daysTo(date: deadline.sumDays(amount: 14))
            if self.daysToEnd > 14 {
                self.progressBarValue = 0.0
            } else {
                self.progressBarValue = 1 - CGFloat(self.daysToEnd).map(from: 0...14, to: 0...1)
            }
        } else if demand.estimatedDuration == "Média" {
            self.demandDeadline = deadline.sumDays(amount: 30).formatDateString()
            self.daysToEnd = deadline.daysTo(date: deadline.sumDays(amount: 30))
            if self.daysToEnd > 30 {
                self.progressBarValue = 0.0
            } else {
                self.progressBarValue = 1 - CGFloat(self.daysToEnd).map(from: 0...30, to: 0...1)
            }
        } else {
            self.demandDeadline = deadline.sumDays(amount: 60).formatDateString()
            self.daysToEnd = deadline.daysTo(date: deadline.sumDays(amount: 60))
            if self.daysToEnd > 60 {
                self.progressBarValue = 0.0
            } else {
                self.progressBarValue = 1 - CGFloat(self.daysToEnd).map(from: 0...60, to: 0...1)
            }
        }
    }
    
}

struct DemandInProgress_Previews: PreviewProvider {
    static var previews: some View {
        DemandInProgressView(demand: Demand.empty)
    }
}
