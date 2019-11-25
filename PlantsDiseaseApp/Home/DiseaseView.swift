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
    
     var disease: Disease?
     var controlDiseaseList = [String]()
    @State var shouldShowIndicator = false
    @State private var shouldShowAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    var diseaseName: String
    var user =  SessionManager.user!
    
    init(diseaseName: String) {
        self.diseaseName = diseaseName
    }
    
    init (disease: Disease) {
        self.diseaseName = disease.name
        self.disease = disease
        controlDiseaseList =  disease.controlDescription?.components(separatedBy: "+") ?? []
    }
    
    var body: some View {
        return ScrollView(.vertical, showsIndicators: false){
            if shouldShowIndicator {
                HStack(alignment: .center) {
                        Spacer()
                    ActivityIndicator(isAnimating: $shouldShowIndicator)
                            .position(y: 150)
                }
            }
            else {
                ImageContainer(imageURL: NetworkManager.diseaeImageURLString +
                        "\(disease!.id)" + ".jpg")
                    .frame(height: 400)
                HStack {
                    Text(disease?.name ?? " ")
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
                    Text(self.disease?.description ?? "")
                        .font(.headline)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .frame(minHeight: 0, idealHeight: 1000, maxHeight: 1000)
                        .padding(.init(top: 0, leading: 25, bottom: 0, trailing: 25))
                }
            }
        }
        .edgesIgnoringSafeArea([.top])
        .onAppear() {
           // self.getDisease()
        }
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



