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
    
//    @State private var avatarImage: Image?
    
    @State var courseSemester: String = "X"
    
    var body: some View {
        Container {
            ScrollView {
                VStack() {
                    HStack(alignment: .center) {
                        Image("avatarPlaceholder")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                            .shadow(radius: 6, y: 6)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(self.viewRouter.loggedUser!.name)
                                .fixedSize(horizontal: false, vertical: true)
                                .font(.headline)
                            Divider()
                            if(self.viewRouter.loggedUser!.accountType == "student"){
                                HStack {
                                    Image(systemName: "studentdesk")
                                        .scaleEffect(0.7)
                                    Text(self.viewRouter.loggedUser!.course)
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
                                Text(self.viewRouter.loggedUser!.email)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.subheadline)
                            }
                        }
                    }
                    .padding(.bottom)
                    HStack(spacing: 0){
                        VStack(alignment: .leading){
                            
                            HStack {
                                Button(action: {
                                    if self.viewRouter.loggedUser!.linkedin != ""{
                                        UIApplication.shared.open(URL(string: self.viewRouter.loggedUser!.linkedin)!)
                                    }
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
                                
                                Button(action: {
                                    if self.viewRouter.loggedUser!.website != ""{
                                        UIApplication.shared.open(URL(string: self.viewRouter.loggedUser!.website)!)
                                    }
                                }){
                                    if(self.viewRouter.loggedUser!.accountType == "student"){
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
                            
                            if(self.viewRouter.loggedUser!.accountType == "business"){
                                Text("Descrição:")
                                .font(.headline)
                                    .padding(.top)
                                LongText(self.viewRouter.loggedUser!.functionDescription)
                            }
                            Divider()
                        }
                        Spacer(minLength: 0)
                    }
                        Text("Demandas concluídas")
                            .font(.title)
                        ForEach(0..<testData.count/2, id: \.self){ i in
                            ExploreCard(demand: testData[i])
                                .padding(.bottom, 8)
                                .onTapGesture {
                                    self.viewRouter.selectedDemand = testData[i]
                                    self.viewRouter.currentPage = Page.DemandView
                            }

                    }
                    Spacer(minLength: 0)
                }
                    .padding()
            }
        }
        .onAppear(perform: {
//            self.loadImage()
            self.sharedNavigation.type = .inline
            if self.viewRouter.loggedUser?.accountType == "student" {
                self.calculateCourseSemester()
                self.sharedNavigation.title = "Perfil do Estudante"
            } else {
                self.sharedNavigation.title = "Perfil do Empreendimento"
            }
        })
    }

//    func loadImage() {
//        guard let inputImage = UIImage(data: self.viewRouter.loggedUser!.avatarImage!) else { return }
//        self.avatarImage = Image(uiImage: inputImage)
//    }
    
    func calculateCourseSemester() {
        
        let regNum = self.viewRouter.loggedUser!.registrationNumber
        
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
