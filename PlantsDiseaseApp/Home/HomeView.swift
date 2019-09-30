//
//  HomeView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var shouldPresentSheet = false
    @State private var headerClicked = ""
    @State private var itemIdClicked = 0
    
    var headlinesDic = [String: Array<String>]()
    
    var cropType = ["Apple", "Corn", "Grape", "Potato", "Tomato"]
    
    var commonDisease = ["Apple Scab", "Tomato leaf mold", "Corn gray leaf spot", "Grape black rot", "Potato early blight", "Strawberry leaf scorch", "Peach bacterial spot", "Tomato mosaic virus", "Squash powdery mildew"]
    
    var commonDiseaseDic = [
        "Apple Scab": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        "Tomato leaf mold": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        "Corn gray leaf spot" : Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        "Grape black rot": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        "Potato early blight": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        "Strawberry leaf scorch": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        "Peach bacterial spot": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        "Tomato mosaic virus": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties"),
        
        "Squash powdery mildew": Disease(id: 0, thumbnail: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", image: "https://miro.medium.com/max/3200/1*IbJF_6mRTMsG9gL0j8uz5Q.jpeg", name: "Grape Leaf Blight", description: "radi", controlDescription:"proper spacing of plants to allow adequate air circulation is important+Yellowish in color it eventually turn the entire leaf yellow+Avoid overhead watering to keep the leave as dry as possible+This diseases also attacks watermelons and cantaloupes. Choose resistant varieties")]
    
    var historyImageDic = ["Apple Scab": Image("apple_scab_test"), "Tomato leaf mold": Image("apple_scab_test"), "Corn gray leaf spot": Image("apple_scab_test"), "Grape black rot": Image("apple_scab_test"), "Potato early blight": Image("apple_scab_test"), "Strawberry leaf scorch": Image("apple_scab_test"), "Peach bacterial spot": Image("apple_scab_test"), "Tomato mosaic virus": Image("apple_scab_test"), "Squash powdery mildew": Image("apple_scab_test")]
    
    var history = ["Apple scab", "Tomato leaf mold", "Tomato leaf mold", "Apple scab", "Tomato leaf mold", "Potato early blight", "Tomato mosaic virus"]
    
    init() {
        headlinesDic = ["Diseases by crop kind": cropType, "Common diseases": commonDisease , "Recent scans": history]
    }
    
    var body: some View {
        let keys = headlinesDic.map{$0.key}
        let values = headlinesDic.map {$0.value}
        return NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(keys, id: \.self) { headline in
                    VStack {
                        HStack{
                            Text(headline)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .padding(.leading, 15)
                            Spacer()
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach((self.headlinesDic[headline])!.indices, id: \.self){
                                    item in
                                    Button(action: {
                                        self.optionClicked(headline: headline, id: item)
                                    }) {
                                        VStack {
                                            Image("apple")
                                                .renderingMode(.original)
                                                .resizable()
                                                .frame(width: 275, height: 150)
                                            HStack {
                                                Text((self.headlinesDic[headline])![item])
                                                    .fontWeight(.bold)
                                                Spacer()
                                            }
                                        }                                    
                                        .padding(10)
                                    }
                                    .foregroundColor(.white)
                                    
                                }
                            }
                        }
                    }
                    
                }
            }
            .padding()
            .navigationBarTitle("Discover")
        }
        .sheet(isPresented: self.$shouldPresentSheet) {
            if (self.headerClicked == "Diseases by crop kind") {
            DiseaseView(disease: self.commonDiseaseDic[self.commonDisease[self.itemIdClicked]]!)
            } else {
                EmptyView()
            }
        }
        .colorScheme(.dark)
    }
    
    func optionClicked(headline: String, id: Int) {
        
        self.itemIdClicked = id
        self.headerClicked = headline
        self.shouldPresentSheet = true
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
