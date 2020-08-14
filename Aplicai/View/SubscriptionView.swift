//
//  SubscriptionView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct SubscriptionView: View {
    
    var demand: Demand
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var isLoading = false
    @State private var navigationIsActive = false
    
    @State private var characterCounter: Int = 0
    
    @State private var motivationText: String = ""
    @State var motivationTextInvalid = true
    var motivationTextProxy: Binding<String> {
        Binding<String>(
            get: { self.motivationText },
            set: {
                self.motivationText = $0
                if $0 != "" {
                    self.motivationTextInvalid = false
                } else {
                    self.motivationTextInvalid = true
                }
        }
        )
    }
    
    var body: some View {
        Container {
            VStack {
                if self.isLoading {
                    LoadingView(showLogo: false)
                } else {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center) {
                                Image(uiImage: (UIImage(data: self.demand.image  ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(15)
                                    .shadow(radius: 6, y: 6)
                                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
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
                            Divider()
                                .padding(.top)
                            Text("Interessado no projeto?")
                                .font(.headline)
                            Text("O que te faz querer ingressar nesse projeto?")
                                .font(.subheadline)
                            Text("Conte um pouco sobre suas ambições para seu parceiro!")
                                .font(.subheadline)
                            
                            
                            VStack(alignment: .trailing) {
                                LimitedMultilineTextField(placeholder: "Escreva um pequeno texto dizendo suas motivações para participar deste projeto.", text: self.motivationTextProxy, textCounter: self.$characterCounter, onCommit: { print(self.motivationText) })
                                    .multilineTextAlignment(.leading)
                                    .padding()
                                Spacer()
                                Text("\(self.characterCounter)/400")
                                    .padding()
                            }
                            .frame(minHeight: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color(self.motivationTextInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                            )
                            
                            
                            NavigationLink(destination: ValidationView(demand: self.demand), isActive: self.$navigationIsActive) {
                                EmptyView()
                            }
                            
                            Button(action: self.publishSolicitation) {
                                Text("Enviar")
                                    .font(.title)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                                    .cornerRadius(15)
                                    .padding(.top)
                            }
                            .disabled(self.motivationTextInvalid)
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
            }
        }
    }
    
    func publishSolicitation() {
        self.isLoading = true
        
        let solicitation = Solicitation(demand: demand, student: self.viewRouter.loggedUser!, motivationText: self.motivationText)
        
        solicitation.ckSave(then: { (result)->Void in
            switch result {
            case .success(let solicitation):
                print("Solicitation created with: ", solicitation.recordName!)
                self.navigationIsActive = true
                self.isLoading = false
            case .failure(let error):
                print("error on creating solicitation")
                debugPrint(error)
            }
        })
    }
    
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView(demand: testData[0])
    }
}
