//
//  NotificationsView.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 29/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import SwiftUI
import UIKit

struct NotificationsView: View {
    
    @EnvironmentObject var sharedNavigation: SharedNavigation
    
    var body: some View {
//        NavigationView {
            Container {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Novas")
                            .font(.title)
                        Divider()
                        VStack {
                            HStack {
                                Image(uiImage: (UIImage(data: testData[0].image ?? Data()) ?? UIImage(named: "avatarPlaceholder"))!)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(10)
                                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
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
//                        Text("Antigas")
//                            .font(.title)
//                        Divider()
//                        VStack {
//                            HStack {
//                                Image(testData[0].image)
//                                    .resizable()
//                                    .frame(width: 70, height: 70)
//                                    .cornerRadius(10)
//                                VStack {
//                                    HStack {
//                                        Image(systemName: "briefcase.fill")
//                                            .scaleEffect(0.7)
//                                        Text(testData[0].businessName)
//                                            .font(.subheadline)
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Image(systemName: "bell.fill")
//                                            .scaleEffect(0.7)
//                                        Text("Você foi aceito no projeto!")
//                                            .font(.subheadline)
//                                        Spacer()
//                                    }
//                                }
//                            }
//                            .opacity(0.6)
//                            Divider()
//                        }
                        
                    }
                    .padding()
                }
            }
            .onAppear(perform: {
                self.sharedNavigation.type = .large
                self.sharedNavigation.title = "Notificações"
            })
//            .navigationBarTitle("Notificações")
//        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}
