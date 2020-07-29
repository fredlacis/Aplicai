//
//  NotificationsView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI

struct NotificationsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(colorScheme == .dark ? #colorLiteral(red: 0.1529411765, green: 0.168627451, blue: 0.1803921569, alpha: 1) : #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 1, alpha: 1)).edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Novas")
                            .font(.title)
                        Divider()
                        VStack {
                            HStack {
                                Image(testData[0].image)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(20)
                                VStack {
                                    HStack {
                                        Image(systemName: "briefcase.fill")
                                            .scaleEffect(0.7)
                                        Text(testData[0].businessName)
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "bell.fill")
                                            .scaleEffect(0.7)
                                        Text("Você foi aceito no projeto!")
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                }
                            }
                            Divider()
                        }
                        Text("Antigas")
                            .font(.title)
                        Divider()
                        VStack {
                            HStack {
                                Image(testData[0].image)
                                .resizable()
                                .frame(width: 70, height: 70)
                                .cornerRadius(20)
                                VStack {
                                    HStack {
                                        Image(systemName: "briefcase.fill")
                                            .scaleEffect(0.7)
                                        Text(testData[0].businessName)
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                    HStack {
                                        Image(systemName: "bell.fill")
                                            .scaleEffect(0.7)
                                        Text("Você foi aceito no projeto!")
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                }
                            }
                            .opacity(0.6)
                            Divider()
                        }
                        
                    }
                    .padding()
                }
            }
        .navigationBarTitle("Notificações")
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
