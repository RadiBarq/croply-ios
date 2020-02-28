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
    let userId: Int?
    let diseaseName: String?
    let cropName: String?
    let disease: Disease?
    let disease2: Disease?
    let disease3: Disease?
    var diseaseId: Int?
    let diseaseId2: Int?
    let diseaseId3: Int?
    let accuracy: Float
    let accuracy2: Float
    let accuracy3: Float
    let crop: Crop?
    let cropId: Int?
    let image: String?
    let thumbnail: String?
    let createdAt: String?
    let lat: Double?
    let lng: Double?

    init(id: Int = 0, userId: Int, diseaseName: String = "", cropName: String = "", cropId: Int = 0, image: String = "", thumbnail: String = "", createdAt: String = " ", lat: Double, lng: Double, crop: Crop? = nil, disease: Disease? = nil, disease2: Disease? = nil, disease3: Disease? = nil, diseaseId: Int? = nil, diseaseId2: Int? = nil, diseaseId3: Int? = nil ,accuracy: Float, accuracy2: Float, accuracy3: Float) {
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
          self.crop = crop
          self.disease = disease
          self.disease2 = disease2
          self.disease3 = disease3
          self.accuracy = accuracy
          self.accuracy2 = accuracy2
          self.accuracy3 = accuracy3
          self.diseaseId = diseaseId
          self.diseaseId2 = diseaseId2
          self.diseaseId3 = diseaseId3
    }
}
