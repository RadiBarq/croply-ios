//
//  DiseaseListView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/28/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI


struct DiseaseListView: View {
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldShowAlert = false
    @ObservedObject var networkingManager =  NetworkManager()
    @State var shouldShowIndicator = true
    var cropId: Int
    var cropName: String
    
    var body: some View {
        Group {
        if shouldShowIndicator { ActivityIndicator(isAnimating: $shouldShowIndicator) }
    
        else {
        List(self.networkingManager.cropsDiseases) { disease in
            NavigationLink(destination: DiseaseView(disease: disease)) {
                DiseaseCell(diseaseName: disease.name, imageURL: NetworkManager.diseaeImageURLString +
                "\(disease.id)" + ".jpg", description: disease.description)
                }
        }
        .navigationBarTitle(self.cropName)
        }
        }
        .onAppear() {
            self.networkingManager.getDiseaseByCropKind(for: User(id: self.cropId, username: " ", email: " ", password:  " ")) { result in
                  self.shouldShowIndicator = false
            }
        }
    }
}

fileprivate struct DiseaseCell: View {
    let diseaseName: String?
    let imageURL: String?
    let description: String?
    
    var body: some View {
        HStack(alignment: .center) {
            VStack {
                ImageContainer(imageURL: imageURL ?? " ")
                    .frame(width: 180, height: 220)
                    .cornerRadius(5)
                    .padding(.top, 15)
            }
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Text(diseaseName ?? " ")
                        .fontWeight(.bold)
                        .font(.title)
                        .lineLimit(5)
                        .padding()
                }
                HStack {
                    Text(description ?? " ")
                        .foregroundColor(.green)
                        .font(Font.system(size: 14))
                        .fontWeight(.bold)
                        .padding(.leading, 15)
                        .lineLimit(10)
                }
                Spacer()
            }
        }
        .padding(.bottom, 15)
    }
}

struct DiseaseListView_Previews: PreviewProvider {
    static var previews: some View {
        DiseaseListView(cropId: 1, cropName: "Apple")
    }
}
