//
//  Demand.swift
//  Aplicai
//
//  Created by Frederico Lacis de Carvalho on 24/07/20.
//  Copyright © 2020 Frederico Lacis de Carvalho. All rights reserved.
//

import Foundation

struct Demand: Identifiable {
    
    var id = UUID()
    var title: String
    var businessName: String
    var categorys: [String]
    var location: String
    var image: String
    var estimatedDuration: String
    var deadline: Date
    var groupSize: Int
    var description: String
    
}

let testData: [Demand] = [
    Demand(title: "Dar aulas de robótica para crianças via zoom", businessName: "Robótica do Bem", categorys: ["Engenharia Elétrica"], location: "Rio de Janeiro", image: "image1", estimatedDuration: "Média Duração", deadline: Date(), groupSize: 3, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu."),
    Demand(title: "Criar obras de arte mecanicas", businessName: "MASP", categorys: ["Engenharia", "Design"], location: "São Paulo", image: "image2", estimatedDuration: "Curta Duração", deadline: Date(), groupSize: 1, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat."),
    Demand(title: "Desenvolver software para controle de estoque", businessName: "Loiola Construções", categorys: ["Administração", "Computação", "Engenharia"], location: "São Paulo", image: "image3", estimatedDuration: "Longa Duração", deadline: Date(), groupSize: 6, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec congue tincidunt elit eget varius. Nunc a eleifend enim, ac dapibus leo. Quisque ac aliquet nunc, a lacinia lorem. Sed bibendum sagittis purus sed semper. Maecenas suscipit tellus metus, et aliquet est rutrum vitae. Duis non sagittis arcu. Nulla ante ante, volutpat sed vehicula vulputate, maximus in libero. Integer eu finibus justo. Sed quis felis sed mi cursus efficitur ac eu lacus. Pellentesque cursus libero ac nunc condimentum, eu scelerisque est semper. Pellentesque consequat lacus ut luctus convallis. Quisque blandit orci ac odio posuere pellentesque. Aliquam erat volutpat.")
]
