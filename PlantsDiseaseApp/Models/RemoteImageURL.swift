//
//  RemoteImageURL.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 10/11/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation


class RemoteImageURL: ObservableObject {
    
    @Published var data = Data()
    @Published var stillLoading = true
    
    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
                self.stillLoading = false
            }
        }.resume()
    }
}
