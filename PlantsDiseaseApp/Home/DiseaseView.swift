//
//  DiseaseView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/27/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI
import WebKit

struct DiseaseView: View {
    
    var disease: Disease
    var controlDiseaseList: Array<String>
    
    var testHtml = """
Apple scab is a disease of Malus trees, such as apple trees, caused by the ascomycete fungus Venturia inaequalis. The disease manifests as dull black or grey-brown lesions on the surface of tree leaves,[1] buds or fruits. Lesions may also appear less frequently on the woody tissues of the tree. Fruits and the undersides of leaves are especially susceptible. The disease rarely kills its host, but can significantly reduce fruit yields and fruit quality. Affected fruits are less marketable due to the presence of the black fungal lesions. The infection cycle begins in the springtime, when suitable temperatures and moisture promote the release of V. inaequalis ascospores from leaf litter around the base of previously infected trees. These spores rise into the air and land on the surface of a susceptible tree, where they germinate and form a germ tube that can directly penetrate the plant's waxy cuticle. A fungal mycelium forms between the cuticle and underlying epidermal tissue, starting as a yellow spot that grows and ruptures to reveal a black lesion bearing asexually as the conidia are released and germinate on fresh areas of the host tree, which in turn produce another generation of conidial spores. This cycle of secondary infections continues throughout the summer, until the leaves and fruit fall from the tree at the onset of winter.Over the winter, V. inaequalis undergoes sexual reproduction in the leaf litter around the base of the tree, producing a new generation of ascospores that are released the following spring. Scab lesions located on the woody tissues may also overwinter in place, but will not undergo a sexual reproduction cycle; these lesions can still produce infective conidial spores in the spring.
"""
    init(disease: Disease)
    {
        self.disease = disease
        controlDiseaseList =  disease.controlDescription.components(separatedBy: "+")
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            Image("profile_background")
                .resizable()
                .frame(height: 400)
            HStack {
                Text(disease.name)
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
            }
            .padding()
            
            HStack {
                Text("Control Methods")
                    .font(.title)
                    .foregroundColor(.green)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            
            HStack {
                VStack {
                    ForEach(controlDiseaseList, id: \.self) { method in
                        Text(method)
                            .font(.headline)
                            .lineLimit(3)
                            .padding(.bottom, 15).multilineTextAlignment(.leading)
                    }
                }
            }
            .padding(.init(top: 0, leading: 25, bottom: 0, trailing: 25))

            HStack {
                Text("Description")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                
                Spacer()
                
            }
            .padding()
            
            VStack {
                Text(testHtml)
                    .font(.headline)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                .frame(minHeight: 0, idealHeight: 1000, maxHeight: 1000)
                   .padding(.init(top: 0, leading: 25, bottom: 0, trailing: 25))
            }
        }
        .edgesIgnoringSafeArea([.top])
    }
    
}

struct DiseaseView_Previews: PreviewProvider {
    static var previews: some View {
        DiseaseView(disease: Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"))
    }
}

struct DescriptionWebView: UIViewRepresentable{
    
    let htmlString: String
    
    func makeUIView(context: UIViewRepresentableContext<DescriptionWebView>) -> WKWebView {
        
        var webView = WKWebView()
        return WKWebView()
    }
    
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        //        guard let url = URL(string: urlString) else { return }
        //        let urlRequest = URLRequest(url: url)
        
        uiView.loadHTMLString(htmlString, baseURL: nil)
    }
}


