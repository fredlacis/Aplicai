//
//  Explore.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct ExploreView: View {
    
    var demands: [Demand]
    
    @State var showingFilter = false
    
    @State private var searchText: String = ""
    
    @State private var isNavigationBarHidden = true
    
    var body: some View {
        NavigationView {
            Container {
                VStack(spacing: 0) {
                        ScrollView {
                            ForEach(self.demands, id: \.id){ demand in
                                NavigationLink(destination:
                                    DemandView(demand: demand)
                                ) {
                                    HStack(alignment: .center) {
                                        Image(demand.image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 120)
                                            .cornerRadius(20)
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(demand.title)
                                                .font(.headline)
                                                .fixedSize(horizontal: false, vertical: true)
                                            Divider()
                                            HStack {
                                                Image(systemName: "briefcase.fill")
                                                    .scaleEffect(0.7)
                                                    .foregroundColor(Color.gray)
                                                Text(demand.businessName)
                                                    .font(.subheadline)
                                            }
                                            HStack {
                                                Image(systemName: "folder.fill")
                                                    .scaleEffect(0.7)
                                                    .foregroundColor(Color.gray)
                                                Text(demand.categorys.joined(separator: ", "))
                                                    .font(.subheadline)
                                                    .fixedSize(horizontal: false, vertical: true)
                                            }
                                            HStack {
                                                Image(systemName: "location.fill")
                                                    .scaleEffect(0.7)
                                                    .foregroundColor(Color.gray)
                                                Text(demand.location)
                                                    .font(.subheadline)
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .background(Color("cardBackgroundColor"))
                                    .cornerRadius(20)
                                    .shadow(radius: 6, y: 6)
                                }
                                .padding(.trailing)
                                .padding(.leading)
                                .buttonStyle(PlainButtonStyle())
                            }
                            .padding(.top)
                        }
                        Spacer()
                }
            }
            .navigationBarTitle("Explorar", displayMode: .inline)
            .navigationBarItems(
                center:
                    SearchBar(text: $searchText, onCommit: {})
                        .padding(.trailing)
                , trailing:
                    Button(action: {
                        self.showingFilter.toggle()
                    }){
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }.sheet(isPresented: $showingFilter) {
                        Text("Filtros")
                    }
            )
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(demands: testData)
    }
}
