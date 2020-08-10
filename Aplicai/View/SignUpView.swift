//
//  SignUpView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI
import UIKit

struct SignUpView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var nameInvalid = false
    var name: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.name },
            set: {
                self.viewRouter.loggedUser!.name = $0
                if $0 ~= "^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,]{1,50}$" {
                    self.nameInvalid = false
                } else {
                    self.nameInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    @State var emailInvalid = false
    var email: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.email },
            set: {
                self.viewRouter.loggedUser!.email = $0
                if $0 ~= "\\S+@\\S+\\.\\S+" {
                    self.emailInvalid = false
                } else {
                    self.emailInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    //For student
    @State var cpfInvalid: Bool = false
    var cpf: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.cpf },
            set: {
                self.viewRouter.loggedUser!.cpf = $0
                if $0 ~= "^\\d{3}\\.?\\d{3}\\.?\\d{3}\\-?\\d{2}$" {
                    self.cpfInvalid = false
                } else {
                    self.cpfInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    
    @State var courseInvalid = false
    var course: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.course },
            set: {
                self.viewRouter.loggedUser!.course = $0
                if $0 ~= "^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,]{1,50}$" {
                    self.courseInvalid = false
                } else {
                    self.courseInvalid = true
                }
        }
        )
    }
    
    @State var registrationNumberInvalid = false
    var registrationNumber: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.registrationNumber },
            set: {
                self.viewRouter.loggedUser!.registrationNumber = $0
                if $0 ~= "^\\d{7}$" {
                    self.registrationNumberInvalid = false
                } else {
                    self.registrationNumberInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    //For business
    @State var cnpjInvalid = false
    var cnpj: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.cnpj },
            set: {
                self.viewRouter.loggedUser!.cnpj = $0
                if $0 ~= "^\\d{2}\\.?\\d{3}\\.?\\d{3}\\/?\\d{4}\\-?\\d{2}$" {
                    self.cnpjInvalid = false
                } else {
                    self.cnpjInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    @State var companyNameInvalid = false
    var companyName: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.companyName },
            set: {
                self.viewRouter.loggedUser!.companyName = $0
                if $0 ~= "^[^±!@£$%^&*_+§¡€#¢§¶•ªº«\\/<>?:;|=.,]{1,50}$" {
                    self.companyNameInvalid = false
                } else {
                    self.companyNameInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    
    @State var functionDescriptionInvalid = false
    var functionDescription: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.functionDescription },
            set: {
                self.viewRouter.loggedUser!.functionDescription = $0
                if $0 != "" {
                    self.functionDescriptionInvalid = false
                } else {
                    self.functionDescriptionInvalid = true
                }
                self.formValid = self.formIsValid()
        }
        )
    }
    
    
    @State var formValid: Bool = false
    
    var body: some View {
        Container {
            VStack(alignment: .leading, spacing: 0) {
                Form {
                    Section(header: Text(self.viewRouter.loggedUser?.accountType == "student" ? "Aluno" : "Empreendimento")
                        .font(.largeTitle)) {
                            TextField(self.viewRouter.loggedUser?.accountType == "student" ? "Nome Completo" : "Nome da Empresa", text: self.name, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                .padding()
                                .border(Color(self.nameInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            TextField("E-mail", text: self.email, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                .keyboardType(.emailAddress)
                                .padding()
                                .border(Color(self.emailInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            if self.viewRouter.loggedUser?.accountType == "student" {
                                TextField("CPF", text: self.cpf, onEditingChanged: {_ in self.formValid = self.formIsValid()})
//                                    .keyboardType(.numberPad)
                                    .padding()
                                    .border(Color(self.cpfInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                TextField("Curso", text: self.course, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                    .padding()
                                    .border(Color(self.courseInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                TextField("Matrícula", text: self.registrationNumber, onEditingChanged: {_ in self.formValid = self.formIsValid()})
//                                    .keyboardType(.numberPad)
                                    .padding()
                                    .border(Color(self.registrationNumberInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            } else if self.viewRouter.loggedUser?.accountType == "business" {
                                TextField("CNPJ", text: self.cnpj, onEditingChanged: {_ in self.formValid = self.formIsValid()})
//                                    .keyboardType(.numberPad)
                                    .padding()
                                    .border(Color(self.cnpjInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                TextField("Razão Social", text: self.companyName, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                    .padding()
                                    .border(Color(self.companyNameInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                TextField("Classificação", text: self.functionDescription, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                    .padding()
                                    .border(Color(self.functionDescriptionInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            }
                    }
                }
                .onAppear(perform: {
                    UITableView.appearance().backgroundColor = .clear
                    print("SignUpView")
                })
                Button(action: {
                    self.registerUser()
                    self.viewRouter.currentPage = Page.ContentView
                }){
                    Text("Criar conta")
                        .font(.system(size: 25))
                        .foregroundColor(Color.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                }.disabled(!self.formValid)
                .background(Color.blue)
                .buttonStyle(PlainButtonStyle())
                .cornerRadius(15)
                .padding()
            }
            .padding(.top)
        }
    }
    
    func formIsValid() -> Bool {
        
        let user = self.viewRouter.loggedUser!
        let nameEmailValid = !nameInvalid && !emailInvalid && user.name != "" && user.email != ""
        
        var validation: Bool
        if user.accountType == "student" {
            validation = nameEmailValid && !cpfInvalid && !courseInvalid && !registrationNumberInvalid && user.cpf != "" && user.course != "" && user.registrationNumber != ""
            return validation
        } else {
            validation = nameEmailValid && !cnpjInvalid && !companyNameInvalid && user.cnpj != "" && user.companyName != "" && !functionDescriptionInvalid && user.functionDescription != ""
            return validation
        }
        
    }
    
    func registerUser() {
        CKDefault.container.fetchUserRecordID(completionHandler: { (record, error)->Void in
            if let record = record {
                print("SUCCESS | UserID: ", record.recordName)
                print("NOW SAVING")
                
                self.viewRouter.loggedUser?.userID = record.recordName
                
                
                // testing image
                self.viewRouter.loggedUser?.avatarImage = UIImage(named: "aplicaiLogo")!.jpegData(compressionQuality: 0.5)
                
                print("=========> CRIANDO NOVO USER")
                self.viewRouter.loggedUser?.ckSave(then: { (result)->Void in
                    switch result {
                    case .success(let user):
                        if let user = user as? User {
                            print("USER SAVED WITH RECORD NAME: ", user.recordName!)
                            self.viewRouter.loggedUser = user
                        }
                    case .failure(let error):
                        print("error on saving")
                        debugPrint(error)
                    }
                })
            }
            if let error = error {
                debugPrint(error)
            }
        })
    }
    
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        //        SignUpView(viewRouter: ViewRouter())
        SignUpView().environmentObject(ViewRouter())
    }
}
