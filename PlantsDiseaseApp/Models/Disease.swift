//
//  Disease.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/27/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

final public class Disease: Codable, Identifiable {
    public let id: Int
    let thumbnail: String?
    let image: String?
    let name: String
    let description: String
    let controlDescription: String
    let scanId: Int?
    
    init(id: Int, thumbnail: String, image: String, name: String, description: String, controlDescription: String, scanId: Int? = nil) {
        self.id = id
        self.thumbnail = thumbnail
        self.image = image
        self.name = name
        self.description = description
        self.controlDescription = controlDescription
        self.scanId = scanId
    }
}
