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
    
    var categorysProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.categorys.joined(separator: ", ") },
            set: {
                if $0 != "" {
                    self.demand.categorys = $0.components(separatedBy: ", ")
                }
        }
        )
    }
    
    var groupSizeProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.groupSize == 0 ? "" : String(self.demand.groupSize) },
            set: {
                if $0 != "" {
                    self.demand.groupSize = Int($0)!
                }
            }
        )
    }
    
    var locationProxy: Binding<String> {
        Binding<String>(
            get: { self.demand.location },
            set: { self.demand.location = $0 }
        )
    }
    
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    @State private var isLoading = false
    
    var body: some View {
        Container {
            VStack {
                if !self.isLoading {
                    NavigationView {
                        Form {
                            TextField("Nome", text: self.$demand.title)
                            MultilineTextField(placeholder: "Descrição", text: self.$demand.description)
                            TextField("Categorias (separadas por vírgula)", text: self.categorysProxy)
                            TextField("Quantidade de participantes", text: self.groupSizeProxy)
                                .keyboardType(.numberPad)
                            TextField("Localização", text: self.locationProxy)
                            VStack {
                                HStack {
                                    Text("Data do fim das inscrições")
                                        .fixedSize(horizontal: true, vertical: true)
                                        .frame(alignment: .leading)
                                    
                                    TextField("", text: self.$selectedDateText)
                                        .opacity(0.6)
                                        .onAppear() {
                                            self.setDateString()
                                    }
                                    .disabled(true)
                                    .multilineTextAlignment(.trailing)
                                }
                                .onTapGesture {
                                    self.showDatePicker.toggle()
                                }
                                if self.showDatePicker {
                                    DatePicker("", selection: self.selectedDate, in: Date()... ,displayedComponents: .date)
                                        .datePickerStyle(WheelDatePickerStyle())
                                        .labelsHidden()
                                }
                            }
                            Picker(selection: self.estimateDurationProxy, label: Text("Duração estimada")) {
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
                                    Spacer()
                                    self.image?
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 100, height: 100)
                                } else {
                                    Text("Selecionar imagem")
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
                        .sheet(isPresented: self.$showingImagePicker, onDismiss: self.loadImage){
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
                        )
                    }
                } else {
                    LoadingView(showLogo: false)
                }
            }
        }
    }
    
    func saveDemand(){
        self.isLoading = true
        
        if inputImage != nil {
            demand.image = UIImage.resizeImage(image: inputImage!).jpegData(compressionQuality: 0.2)
        }
        
        demand.ownerUser = self.viewRouter.loggedUser!
        
        demand.ckSave(then: { (result)->Void in
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
