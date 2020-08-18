//
//  NewDemandView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 09/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct NewDemandView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var demand:Demand = Demand.empty
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State private var showDatePicker: Bool = false
    @State private var selectedDateText: String = "Date"
    private var selectedDate: Binding<Date> {
        Binding<Date>(get: { self.demand.deadline }, set : {
            self.demand.deadline = $0
            self.setDateString()
        })
    }
    private func setDateString() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        
        self.selectedDateText = formatter.string(from: self.demand.deadline)
    }
    
    var durations = ["Curta", "Média", "Longa"]
    var durationsDescriptions = ["até 2 semanas", "até 1 mês", "a partir de 1 mês"]
    @State private var selectedDurationIndex = 1
    var estimateDurationProxy: Binding<Int> {
        Binding<Int>(
            get: { self.selectedDurationIndex },
            set: {
                self.selectedDurationIndex = $0
                self.demand.estimatedDuration = self.durations[$0]
        }
        )
    }
    
    @State var categoryFirstEddit = true
    @State var categoryInvalid = true
    var categorysProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.categorys.joined(separator: ", ") },
            set: {
                self.categoryFirstEddit = false
                if $0 != "" {
                    self.categoryInvalid = false
                    self.demand.categorys = $0.components(separatedBy: ", ")
                } else {
                    self.categoryInvalid = true
                    self.demand.categorys = []
                }
        }
        )
    }
    
    @State var groupSizeFirstEddit = true
    @State var groupSizeInvalid = true
    var groupSizeProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.groupSize == 0 ? "" : String(self.demand.groupSize) },
            set: {
                self.groupSizeFirstEddit = false
                if $0 != "" {
                    self.groupSizeInvalid = false
                    self.demand.groupSize = Int($0)!
                } else {
                    self.groupSizeInvalid = true
                    self.demand.groupSize = 0
                }
            }
        )
    }
    
    @State var locationFirstEddit = true
    @State var locationInvalid = true
    var locationProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.location },
            set: {
                    self.locationFirstEddit = false
                    if $0 != ""{
                        self.locationInvalid = false
                        self.demand.location = $0
                    } else {
                        self.locationInvalid = true
                        self.demand.location = $0
                    }
                }
        )
    }
    
    @State var titleFirstEddit = true
    @State var titleInvalid = true
    var titleProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.title },
            set: {
                    self.titleFirstEddit = false
                    if $0 != ""{
                        self.titleInvalid = false
                        self.demand.title = $0
                    } else {
                        self.titleInvalid = true
                        self.demand.title = $0
                    }
                }
        )
    }
    
    @State var descriptionFirstEdit = true
    @State var descriptionInvalid = true
       var descriptionProxy: Binding<String> {
           Binding<String>(
               get: { self.demand.description },
               set: {
                        self.descriptionFirstEdit = false
                       if $0 != ""{
                           self.descriptionInvalid = false
                           self.demand.description = $0
                       } else {
                           self.descriptionInvalid = true
                            self.demand.description = $0
                       }
                   }
           )
       }
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isLoading = false
    
    @State var formValid = false
    
    @State private var keyboardOffset: CGFloat = 0
    
    var body: some View {
        Container {
            VStack {
                if !self.isLoading {
                    NavigationView {
                        Form {
                            TextField("Nome", text: self.titleProxy, onEditingChanged: { _ in self.formIsValid() })
                                .padding()
                                .border(Color(self.titleInvalid && !self.titleFirstEddit ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            MultilineTextField(placeholder: "Descrição", text: self.descriptionProxy, onCommit: { self.formIsValid() })
                                .padding()
                            .border(Color(self.descriptionInvalid && !self.descriptionFirstEdit ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            TextField("Categorias (separadas por vírgula)", text: self.categorysProxy, onEditingChanged: { _ in self.formIsValid() })
                                .padding()
                                .border(Color(self.categoryInvalid && !self.categoryFirstEddit ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            TextField("Quantidade de participantes", text: self.groupSizeProxy, onEditingChanged: { _ in self.formIsValid() })
                                .keyboardType(.numberPad)
                                .padding()
                                .border(Color(self.groupSizeInvalid && !self.groupSizeFirstEddit ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            TextField("Localização", text: self.locationProxy, onEditingChanged: { _ in self.formIsValid() })
                                .padding()
                                .border(Color(self.locationInvalid && !self.locationFirstEddit ? #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1) : .clear))
                            VStack {
                                HStack {
                                    Text("Data do fim das inscrições")
                                        .fixedSize(horizontal: true, vertical: true)
                                        .frame(alignment: .leading)
                                        .padding(.leading)
                                        .padding(.vertical)
                                    
                                    TextField("", text: self.$selectedDateText)
                                        .opacity(0.6)
                                        .onAppear() {
                                            self.setDateString()
                                    }
                                    .disabled(true)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.trailing)
                                    .padding(.vertical)
                                }
                                .onTapGesture {
                                    self.showDatePicker.toggle()
                                    self.formIsValid()
                                }
                                if self.showDatePicker {
                                    DatePicker("", selection: self.selectedDate, in: Date()... ,displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .labelsHidden()
                                }
                            }
                            Picker(selection: self.estimateDurationProxy, label: Text("Duração estimada").padding(.leading).padding(.vertical)) {
                                ForEach(0 ..< self.durations.count, id: \.self) { i in
                                    VStack(alignment: .center) {
                                        Text(self.durations[i])
                                        Text(self.durationsDescriptions[i])
                                            .opacity(0.7)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                }
                            }
                            HStack {
                                if self.image != nil {
                                    Text("Alterar imagem")
                                        .foregroundColor(Color(UIColor.placeholderText))
                                        .padding(.leading)
                                        .padding(.vertical)
                                    Spacer()
                                    self.image?
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .padding(.trailing)
                                        .padding(.vertical)
                                } else {
                                    Text("Selecionar imagem")
                                        .foregroundColor(Color(UIColor.placeholderText))
                                        .padding(.leading)
                                        .padding(.vertical)
                                    Spacer()
                                    Image(systemName: "photo.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(Color(UIColor.placeholderText))
                                        .padding(.trailing)
                                        .padding(.vertical)
                                }
                            }
                            .onTapGesture {
                                self.showingImagePicker = true
                                self.formIsValid()
                            }
                        }
                        .sheet(isPresented: self.$showingImagePicker, onDismiss: {
                            self.loadImage()
                            self.formIsValid()
                        }){
                            ImagePicker(image: self.$inputImage)
                        }
                        .navigationBarTitle("Nova demanda", displayMode: .inline)
                        .navigationBarItems(leading:
                            Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                                Text("Cancelar")
                                    .foregroundColor(.red)
                            }.padding()
                        , trailing:
                            Button(action: self.saveDemand) {
                                Text("Salvar")
                                    .foregroundColor(.blue)
                            }.padding()
                                .disabled(!self.formValid)
                                .opacity(!self.formValid ? 0.3 : 1)
                        )
                    }
                    Rectangle()
                        .frame(height: self.keyboardOffset)
                        .animation(.default)
                        .background(Color.clear)
                        .foregroundColor(.clear)
                } else {
                    LoadingView(showLogo: false)
                }
            }
        }
        .onAppear(perform: {
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) {
                (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                self.keyboardOffset = value.height
            }
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) {
                (noti) in
                self.keyboardOffset = 0
            }
            })
    }
    
    func formIsValid() {
        
        self.formValid = !self.titleInvalid && !self.descriptionInvalid && !self.categoryInvalid && !self.groupSizeInvalid && self.image != nil
        
    }
    
    func saveDemand(){
        self.isLoading = true
        
        if inputImage != nil {
            demand.image = UIImage.resizeImage(image: inputImage!).jpegData(compressionQuality: 0.2)
        }
        
        demand.ownerUser = self.viewRouter.loggedUser!
        
        demand.ckSaveDemand(then: { (result)->Void in
            switch result {
                case .success(_):
                    self.presentationMode.wrappedValue.dismiss()
                    self.isLoading = false
                case .failure(_):
                    self.presentationMode.wrappedValue.dismiss()
                    self.isLoading = false
            }
        })
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct NewDemandView_Previews: PreviewProvider {
    static var previews: some View {
        NewDemandView()
    }
}
