//
//  SolicitationsView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 10/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct AllSolicitationsView: View {
    
    @State var demand: Demand
    
    @State var solicitations: [Solicitation] = []
    @State var acceptedSolicitations: [Solicitation] = []
    @State var rejectedSolicitations: [Solicitation] = []
    
    @State var limitReached: Bool = false
    
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
        NavigationView {
            Container {
                RefreshableScrollView(refreshing: self.isReloadingProxy) {
                    if !self.isReloading {
                        VStack(alignment: .leading, spacing: 10) {
                            if !self.acceptedSolicitations.isEmpty {
                                Text("Aceitos")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                Divider()
                                ForEach((0..<self.acceptedSolicitations.count), id: \.self){ i in
                                    self.generateSolicitationCard(solicitation: self.acceptedSolicitations[i])
                                }
                            }
                            if !self.solicitations.isEmpty {
                                Text("Aguardando avaliação")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                Divider()
                                ForEach((0..<self.solicitations.count), id: \.self){ i in
                                    self.generateSolicitationCard(solicitation: self.solicitations[i])
                                }
                            }
                            if !self.rejectedSolicitations.isEmpty {
                                Text("Recusados")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.headline)
                                Divider()
                                ForEach((0..<self.rejectedSolicitations.count), id: \.self){ i in
                                    self.generateSolicitationCard(solicitation: self.rejectedSolicitations[i])
                                }
                            }
                            if self.rejectedSolicitations.isEmpty && self.solicitations.isEmpty && self.acceptedSolicitations.isEmpty {
                                VStack(alignment: .center) {
                                    Text("Ainda não foram feitas solicitações de participação.")
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(.gray)
                                }.frame(minWidth: 0, maxWidth: .infinity)
                            }
                            EmptyView()
                        }
                        .padding()
                    } else {
                        EmptyView()
                    }
                }
            }.onAppear(perform: {
                if self.solicitations.isEmpty {
                    self.loadSolicitations()
                }
            })
                .navigationBarTitle("Solicitações de participação", displayMode: .inline)
        }
    }
    
    func loadSolicitations() {
        self.isReloading = true
        Solicitation.ckLoadByDemand(demandRecordName: self.demand.recordName!,then: { (result) -> Void in
            switch result {
                case .success(let solicitations):
                    self.solicitations = solicitations
                    self.filterSolicitations()
                    self.isReloading = false
                case .failure(let error):
                    debugPrint("Error on loading solicitations of demand: ", error)
                    self.isReloading = false
            }
        })
        
    }
    
    func filterSolicitations() {
        self.acceptedSolicitations = self.solicitations.filter { solicitation in
            return solicitation.status == Solicitation.Status.accepted.rawValue
        }
        self.rejectedSolicitations = self.solicitations.filter { solicitation in
            return solicitation.status == Solicitation.Status.rejected.rawValue
        }
        self.solicitations = self.solicitations.filter { solicitation in
            return solicitation.status == Solicitation.Status.waiting.rawValue
        }
        if self.acceptedSolicitations.count >= demand.groupSize {
            limitReached = true
        } else {
            limitReached = false
        }
    }
    
    func generateSolicitationCard(solicitation: Solicitation) -> some View {
        
        let user = solicitation.student
        
        return VStack {
            HStack {
                Image(uiImage: UIImage(data: user.avatarImage ?? Data()) ?? UIImage(named: "avatarPlaceholder")!)
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(10)
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "person.fill")
                            .scaleEffect(0.7)
                        Text(user.name)
                            .font(.subheadline)
                        Spacer()
                    }
                    NavigationLink(destination: SolicitationView(solicitation: solicitation, limitReached: limitReached)){
                        Text("Avaliar solicitação")
                            .foregroundColor(Color.white)
                            .padding(5)
                            .padding(.horizontal)
                    }
                    .background(Color.blue)
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(15)
                }
            }
            Divider()
        }
    }
    
}

struct AllSolicitationsView_Previews: PreviewProvider {
    static var previews: some View {
        AllSolicitationsView(demand: Demand.empty)
    }
}
