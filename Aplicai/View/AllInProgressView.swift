//
//  InProgressView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct AllInProgressView: View {
    
    var demandsInProgress: [Demand]
       
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView{
           ZStack {
               Color(colorScheme == .dark ? #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.1803921569, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
               ScrollView {
                   VStack(spacing: 16) {
                       ForEach(demandsInProgress, id: \.id){ demand in
                           NavigationLink(destination: DemandView(demand: demand)){
                            VStack {
                                HStack(alignment: .center) {
                                       Image(demand.image)
                                           .resizable()
                                           .aspectRatio(contentMode: .fill)
                                           .frame(width: 120)
                                           .cornerRadius(20)
                                       VStack(alignment: .leading, spacing: 5) {
                                           Text(demand.title)
                                               .font(.headline)
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
                                ProgressBar(value: 0.4)
                                    .padding(.top, 5)
                            }
                            .padding()
                            .background(Color(self.colorScheme == .dark ? #colorLiteral(red: 0.2240682542, green: 0.2468768656, blue: 0.2671875358, alpha: 1) : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                            .cornerRadius(20)
                            .shadow(radius: 6, y: 6)
                           }
                           .isDetailLink(true)
                           .buttonStyle(PlainButtonStyle())
                       }
                       Spacer()
                   }
                   .padding()
               }
               .navigationBarTitle("Em andamento")
           }
       }
    }
}

struct InProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AllInProgressView(demandsInProgress: testData)
    }
}
