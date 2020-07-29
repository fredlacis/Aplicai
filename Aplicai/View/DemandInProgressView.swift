//
//  DemandInProgress.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct DemandInProgressView: View {
    
    var demand: Demand
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Color(colorScheme == .dark ? #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.1803921569, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(alignment: .top) {
                        Image(demand.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(20)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(demand.title)
                                .font(.headline)
                            Divider()
                            HStack {
                                Image(systemName: "briefcase.fill")
                                    .scaleEffect(0.7)
                                Text(demand.businessName)
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "folder.fill")
                                    .scaleEffect(0.7)
                                Text(demand.categorys.joined(separator: ", "))
                                    .font(.subheadline)
                            }
                            HStack {
                                Image(systemName: "location.fill")
                                    .scaleEffect(0.7)
                                Text(demand.location)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
    }
}

struct DemandInProgress_Previews: PreviewProvider {
    static var previews: some View {
        DemandInProgressView(demand: testData[0])
    }
}
