//
//  NewDemandView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 09/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct NewDemandView: View {
    
    @State var demand:Demand = Demand.empty
    
    @State private var showPicker: Bool = false
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
    
    var body: some View {
        Container {
            Form {
                Text("Nova demanda")
                    .font(.title)
                TextField("Nome", text: self.$demand.title)
                TextField("Descricao", text: self.$demand.description)
                TextField("Categorias (separadas por vírgula)", text: self.categorysProxy)
                TextField("Quantidade de participantes", text: self.groupSizeProxy)
                    .keyboardType(.numberPad)
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
                        self.showPicker.toggle()
                    }
                    if self.showPicker {
                        DatePicker("", selection: self.selectedDate, displayedComponents: .date)
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
                
                Button(action: {
//                    self.save()
                    
                }) {
                    Text("Salvar")
                }.padding()
            }
        }
    }
}

struct NewDemandView_Previews: PreviewProvider {
    static var previews: some View {
        NewDemandView()
    }
}
