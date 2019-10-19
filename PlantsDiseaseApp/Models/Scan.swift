//
//  Post.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/27/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation

final class Scan: Codable, Identifiable {
    let id: Int?
    let userId: Int
    let diseaseId: Int?
    let diseaseName: String?
    let cropName: String?
    let disease: Disease?
    let crop: Crop?
    let cropId: Int?
    let image: String?
    let thumbnail: String?
    let createdAt: String?
    let lat: Double
    let lng: Double

    init(id: Int = 0, userId: Int, diseaseId: Int = 0, diseaseName: String = "", cropName: String = "", cropId: Int = 0, image: String = "", thumbnail: String = "", createdAt: String = " ", lat: Double, lng: Double, disease: Disease? = nil, crop: Crop? = nil) {
          self.id = id
          self.userId = userId
          self.diseaseId = diseaseId
          self.cropId = cropId
          self.image = image
          self.thumbnail = thumbnail
          self.createdAt = createdAt
          self.lat = lat
          self.lng = lng
          self.diseaseName = diseaseName
          self.cropName = cropName
          self.disease = disease
          self.crop = crop
      }
}
