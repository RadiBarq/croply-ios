//
//  Crop.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/27/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

final class Crop: Codable {
    var id: Int
    var name: String
    var image: String?
    var supportedDisease: Array<Disease>?
    
    init(id: Int, name: String, thumbnail: String, image: String? = nil) {
        self.id = id
        self.name = name
        self.image = image
    }

}
