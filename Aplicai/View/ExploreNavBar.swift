////
////  ExploreNavba.swift
////  Aplicai
////
////  Created by Frederico Lacis de Carvalho on 30/07/20.
////  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
////
//
//import SwiftUI
//
//struct ExploreNavBar: View {
//
//    @State private var searchText: String = ""
//
//    @State var showingFilter = false
//
//    var body: some View {
//        VStack(spacing: 0) {
//            HStack{
//                Text("Explorar")
//                    .font(.largeTitle)
//                    .bold()
//                Spacer()
//                Button(action: {
//                    self.showingFilter.toggle()
//                }){
//                    Image(systemName: "line.horizontal.3.decrease.circle")
//                        .resizable()
//                        .frame(width: 30, height: 30)
//                }.sheet(isPresented: $showingFilter) {
//                    Text("Filtros")
//                }
//            }
//            .padding(.top)
//            .padding(.leading)
//            .padding(.trailing)
//            SearchBar(text: $searchText, onCommit: {})
//                .padding(.top, 0)
//        }
//        .background(
//            Color("cardBackgroundColor").edgesIgnoringSafeArea(.top)
//                .shadow(color: Color.black.opacity(0.2), radius: 6, y: 6)
//        )
//
//    }
//}
//
//struct ExploreNavBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ExploreView(demands: testData)
//    }
//}
