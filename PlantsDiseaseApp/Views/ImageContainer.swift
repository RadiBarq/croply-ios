
 //ImageContainer.swift
 // PlantsDiseaseApp

 // Created by Radi Barq on 10/11/19.
 // Copyright © 2019 RadiBarq. All rights reserved.

import SwiftUI

struct ImageContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL
    @State var shouldShowIndicator: Bool = true
    
    init(imageURL: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }
    
    var body: some View {
        Group {
            if remoteImageURL.stillLoading {ActivityIndicator(isAnimating: $remoteImageURL.stillLoading)}
            else {
                Image(uiImage: UIImage(data: remoteImageURL.data) ?? UIImage(named: "apple-1")!)
                .renderingMode(.original)
                .resizable()
            }
        }
    }
}

struct ImageContainer_Previews: PreviewProvider {
    static var previews: some View {
        ImageContainer(imageURL: "https://image.shutterstock.com/image-photo/cherry-leaf-isolated-on-white-260nw-1145339282.jpg")
    }
}
