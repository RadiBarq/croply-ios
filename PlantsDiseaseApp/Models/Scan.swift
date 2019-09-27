//
//  Post.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/27/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

final class Scan: Codable {
    
    let id: Int?
    let userId: Int
    let diseaseId: Int?
    let cropsId: Int?
    let image: String?
    let thumbnail: String?
    let createdAt: Double?
    let lat: Double
    let long: Double
    
    init(id: Int = 0, userId: Int, diseaseId: Int = 0, cropsId: Int = 0, image: String = "", thumbnail: String = "", createdAt: Double = 0, lat: Double, long: Double) {
          self.id = id
          self.userId = userId
          self.diseaseId = diseaseId
          self.cropsId = cropsId
          self.image = image
          self.thumbnail = thumbnail
          self.createdAt = createdAt
          self.lat = lat
          self.long = long
      }
}
