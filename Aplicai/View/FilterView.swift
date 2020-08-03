//
//  FilterView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 31/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    
    var durations = ["Curta", "Média", "Longa"]
    var durationsDescriptions = ["até 2 semanas", "até 1 mês", "a partir de 1 mês"]
    @State private var selectedDurationIndex = 1
    @State private var text = ""
    @State private var km: Double = 0
    @State var nearMe: Bool = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form() {
                Section(header: Text("Localização")) {
                    Toggle(isOn: $nearMe) {
                        Text("Perto de você")
                    }
                    VStack(alignment: .leading) {
                        Text("Raio")
                        HStack {
                            Slider(value: $km, in: 0...100, step: 1)
                                .disabled(!nearMe)
                            Text("\(Int(km)) km")
                                .opacity(0.7)
                        }
                    }
                }
                Section(header: Text("Tempo")) {
                    Picker(selection: $selectedDurationIndex, label: Text("Duração")) {
                        ForEach(0 ..< durations.count) { i in
                            VStack(alignment: .center) {
                                    Text(self.durations[i])
                                    Text(self.durationsDescriptions[i])
                                        .opacity(0.7)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }
            }
            .padding(.top)
            .navigationBarTitle("Filtros", displayMode: .inline)
            .navigationBarItems(
                leading:
                    Button(action: {self.presentationMode.wrappedValue.dismiss()}){
                        Text("Cancelar")
                    }
                    .foregroundColor(Color.red)
                , trailing:
                    Button(action: {}){
                        Text("Aplicar")
                    }
            )
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
