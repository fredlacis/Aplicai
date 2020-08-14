//
//  SolicitationView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 10/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct SolicitationView: View {
    
    @State var solicitation: Solicitation
    
    var body: some View {
        Container {
            VStack {
                HStack(alignment: .center) {
                    Image(uiImage: UIImage(data: self.solicitation.student.avatarImage ?? Data()) ?? UIImage(named: "avatarPlaceholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .cornerRadius(15)
                        .shadow(radius: 6, y: 6)
                    VStack(alignment: .leading, spacing: 5) {
                        Text(self.solicitation.student.name)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.headline)
                        NavigationLink(destination: ProfileView(user: self.solicitation.student).environmentObject(SharedNavigation())){
                            Text("Ver perfil")
                                .foregroundColor(Color.white)
                                .padding(5)
                                .padding(.horizontal)
                        }
                        .background(Color.blue)
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(15)
                    }
                    Spacer()
                }
                .padding(.bottom)
                Text(self.solicitation.motivationText)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom)
                HStack {
                    Button(action: { self.updateSolicitationStatus(Solicitation.Status.accepted) }){
                        Text(self.solicitation.status == Solicitation.Status.accepted.rawValue ? "Aceito" : "Aceitar")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(10)
                    }
                    .background(Color.green)
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(15)
                    .disabled(self.solicitation.status == Solicitation.Status.accepted.rawValue)
                    .opacity(self.solicitation.status == Solicitation.Status.accepted.rawValue ? 0.4 : 1.0)
                    
                    Button(action: { self.updateSolicitationStatus(Solicitation.Status.rejected) }){
                        Text(self.solicitation.status == Solicitation.Status.rejected.rawValue ? "Recusado" : "Recusar")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding(10)
                    }
                    .background(Color.red)
                    .buttonStyle(PlainButtonStyle())
                    .cornerRadius(15)
                    .disabled(self.solicitation.status == Solicitation.Status.rejected.rawValue)
                    .opacity(self.solicitation.status == Solicitation.Status.rejected.rawValue ? 0.4 : 1.0)
                }
            }
        .padding()
        }
    }
    
    func updateSolicitationStatus(_ newStatus: Solicitation.Status) {
        
        self.solicitation.status = newStatus.rawValue
        
        self.solicitation.ckSave(then: { (result)->Void in
            switch result {
            case .success(let solicitation):
                print("Solicitation created with: ", solicitation.recordName!)
                self.solicitation = solicitation
                dump(solicitation)
//                self.isLoading = false
            case .failure(let error):
                print("error on creating solicitation")
                debugPrint(error)
            }
        })
    }
}

struct SolicitationView_Previews: PreviewProvider {
    static var previews: some View {
        SolicitationView(solicitation: Solicitation(demand: Demand.empty, student: User.emptyStudent, motivationText: ""))
    }
}
