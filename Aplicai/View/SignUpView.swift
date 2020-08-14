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
    
    var linkedin: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.linkedin },
            set: { self.viewRouter.loggedUser!.linkedin = $0 }
        )
    }
    
    var website: Binding<String> {
        Binding<String>(
            get: { self.viewRouter.loggedUser!.website },
            set: { self.viewRouter.loggedUser!.website = $0 }
        )
    }
    
    
    @State var formValid: Bool = false
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isLoading = false
    
    var body: some View {
        Container {
            VStack(alignment: .leading, spacing: 0) {
                if !self.isLoading {
                    Form {
                        Section(header: Text(self.viewRouter.loggedUser?.accountType == "student" ? "Aluno" : "Empreendimento")
                            .font(.largeTitle)) {
                                TextField(self.viewRouter.loggedUser?.accountType == "student" ? "Nome Completo" : "Nome da Empresa", text: self.name, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                    .padding()
                                    .border(Color(self.nameInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                TextField("E-mail", text: self.email, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding()
                                    .border(Color(self.emailInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                if self.viewRouter.loggedUser?.accountType == "student" {
                                    TextField("CPF", text: self.cpf, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                        .padding()
                                        .border(Color(self.cpfInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                    TextField("Curso", text: self.course, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                        .padding()
                                        .border(Color(self.courseInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                    TextField("Matrícula", text: self.registrationNumber, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                        .padding()
                                        .border(Color(self.registrationNumberInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                } else if self.viewRouter.loggedUser?.accountType == "business" {
                                    TextField("CNPJ", text: self.cnpj, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                        .padding()
                                        .border(Color(self.cnpjInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                    TextField("Razão Social", text: self.companyName, onEditingChanged: {_ in self.formValid = self.formIsValid()})
                                        .padding()
                                        .border(Color(self.companyNameInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                    MultilineTextField(placeholder: "Descrição do empreendimento", text: self.functionDescription)
                                        .padding()
                                        .border(Color(self.functionDescriptionInvalid ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                                }
                                HStack {
                                    if self.image != nil {
                                        Text("Alterar imagem de perfil")
                                            .foregroundColor(Color(UIColor.placeholderText))
                                        Spacer()
                                        self.image?
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                    } else {
                                        Text("Selecionar imagem de perfil")
                                            .foregroundColor(Color(UIColor.placeholderText))
                                        Spacer()
                                        Image(systemName: "photo.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 100, height: 100)
                                            .foregroundColor(Color(UIColor.placeholderText))
                                    }
                                }
                                .onTapGesture {
                                    self.showingImagePicker = true
                                }
                        }
                        Section(header: Text("Links").font(.headline)){
                            TextField("URL Linkedin", text: self.linkedin)
                            if self.viewRouter.loggedUser!.accountType == "student" {
                                TextField("URL Portfólio", text: self.website)
                            } else {
                                TextField("URL Site", text: self.website)
                            }
                        }
                        
                    }
                    .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage){
                        ImagePicker(image: self.$inputImage)
                    }
                    .onAppear(perform: {
                        UITableView.appearance().backgroundColor = .clear
                        print("SignUpView")
                    })
                    Button(action: {
                        self.registerUser()
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
                } else {
                    LoadingView(showLogo: false)
                }
            }
            .padding(.top)
        }
    }
    
    func loadImage() {
        self.formValid = self.formIsValid()
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
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
        self.isLoading = true
        
        if inputImage != nil {
            self.viewRouter.loggedUser!.avatarImage = UIImage.resizeImage(image: inputImage!).jpegData(compressionQuality: 0.2)
        }
        
        CKDefault.container.fetchUserRecordID(completionHandler: { (record, error)->Void in
            if let record = record {
                print("SUCCESS | UserID: ", record.recordName)
                print("NOW SAVING")
                
                self.viewRouter.loggedUser?.userID = record.recordName
                
                print("=========> CRIANDO NOVO USER")
                self.viewRouter.loggedUser?.ckSave(then: { (result)->Void in
                    switch result {
                    case .success(let user):
                        print("USER SAVED WITH RECORD NAME: ", user.recordName!)
                        self.viewRouter.loggedUser = user
                        self.viewRouter.currentPage = Page.ContentView
                        self.isLoading = false
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
