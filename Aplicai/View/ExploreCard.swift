//
//  ExploreCard.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 03/08/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct ExploreCard: View {
    
    var demand: Demand
    
    var body: some View {
            HStack(alignment: .top) {
                Image(uiImage: UIImage(data: self.demand.image ?? Data()) ?? UIImage(named: "avatarPlaceholder")!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .cornerRadius(15)
                VStack(alignment: .leading, spacing: 5) {
                    Text(self.demand.title)
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                    Divider()
                    HStack {
                        Image(systemName: "briefcase.fill")
                            .scaleEffect(0.7)
                            .foregroundColor(Color.gray)
                        Text(self.demand.ownerUser.name != "" ? self.demand.ownerUser.name : "Demo Business")
                            .font(.subheadline)
                    }
                    HStack {
                        Image(systemName: "folder.fill")
                            .scaleEffect(0.7)
                            .foregroundColor(Color.gray)
                        Text(self.demand.categorys.joined(separator: ", "))
                            .font(.subheadline)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    HStack {
                        Image(systemName: "location.fill")
                            .scaleEffect(0.7)
                            .foregroundColor(Color.gray)
                        Text(self.demand.location)
                            .font(.subheadline)
                    }
                }
            }
            .padding(8)
            .background(Color("cardBackgroundColor"))
            .cornerRadius(20)
            .shadow(radius: 6, y: 6)
        }
}

struct ExploreCard_Previews: PreviewProvider {
    static var previews: some View {
        ExploreCard(demand: Demand.empty)
    }
}
