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
    
    var diseases = [
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        Disease(id: 0, thumbnail: "apple_scab_test", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties")
    ]
    
    var body: some View {
        Group {
        if shouldShowIndicator { ActivityIndicator(isAnimating: $shouldShowIndicator) }
    
        else {
        List(self.networkingManager.cropsDiseases) { disease in
            NavigationLink(destination: DiseaseView(disease: disease)) {
                DiseaseCell(diseaseName: disease.name, imageURL: "https://image.shutterstock.com/image-photo/cherry-leaf-isolated-on-white-260nw-1145339282.jpg", description: disease.description)
                }
        }
        .navigationBarTitle(self.cropName)
        }
        }
        .colorScheme(.dark)
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
