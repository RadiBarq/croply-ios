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
    @State var networkManager: NetworkManager = NetworkManager()
    @State var headlinesDic = [String: Array<String>]()
    var cropType = ["Apple", "Corn", "Grape", "Potato", "Tomato"]
    var commonDisease = ["Apple Scab", "Tomato leaf mold", "Corn gray leaf spot", "Grape black rot", "Potato early blight", "Strawberry leaf scorch", "Peach bacterial spot", "Tomato mosaic virus", "Squash powdery mildew"]
    @State var shouldShowIndicator = true
    @State var test = true
    
    init() {
        print("radi")
    }
//    func test() {
//
//        var test1 =  self.networkManager.dashboardHeadlinesDic[headline]![item] as! Crop).name
//
//    }
    
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
    
    //  var historyImageDic = ["Apple Scab": Image("apple_scab_test"), "Cherry Powdery Mildew": Image("apple_scab_test"), "Corn Gray Leaf Spot": Image("apple_scab_test"), "Grape Black Rot": Image("apple_scab_test"), "Orange Huanglongbing": Image("apple_scab_test"), "Peach Bacterial Spot": Image("apple_scab_test"), "Peach bacterial spot": Image("apple_scab_test"), "Bell Pepper Bacterial Spot": Image("apple_scab_test"), "Strawberry Healthy": Image("apple_scab_test")]
    
    var history = ["Apple scab", "Tomato leaf mold", "Tomato leaf mold", "Apple scab", "Tomato leaf mold", "Potato early blight", "Tomato mosaic virus"]
    
    var body: some View {
        let keys = self.networkManager.dashboardHeadlinesDic.map{$0.key}
        let values = self.networkManager.dashboardHeadlinesDic.map {$0.value}
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
                        if headline != "Diseases by crop kind" {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach((self.networkManager.dashboardHeadlinesDic[headline])!.indices, id: \.self){
                                        item in
                                        NavigationLink(destination:
                                            DiseaseView(disease: self.networkManager.dashboardDiseasesDic[headline]![item])
                                        ) {
                                            VStack {
                                                ImageContainer(imageURL: "https://image.shutterstock.com/image-photo/cherry-leaf-isolated-on-white-260nw-1145339282.jpg")
                                                   // .renderingMode(.original)
                                                   // .resizable()
                                                    .frame(width: 275, height: 150)
                                                HStack {
                                                    Text((self.networkManager.dashboardHeadlinesDic[headline])![item])
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                }
                                            }
                                            .padding(10)
                                        }
                                    }
                                }
                            }
                        }
                            
                        else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach((self.networkManager.dashboardHeadlinesDic[headline])!.indices, id: \.self){
                                        item in
                                        NavigationLink(destination:
                                            DiseaseListView(cropId: self.networkManager.cropsId[item], cropName: self.networkManager.dashboardHeadlinesDic[headline]![item]))
                                         {
                                            VStack {
                                                    ImageContainer(imageURL: "https://image.shutterstock.com/image-photo/cherry-leaf-isolated-on-white-260nw-1145339282.jpg")
                                                    //.renderingMode(.original)
                                                    //.resizable()
                                                    .frame(width: 275, height: 150)
                                                HStack {
                                                    Text((self.networkManager.dashboardHeadlinesDic[headline])![item])
                                                        .fontWeight(.bold)
                                                    Spacer()
                                                }
                                            }
                                            .padding(10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                
                if shouldShowIndicator {ActivityIndicator(isAnimating: $shouldShowIndicator)}
            }
            .navigationBarTitle("Discover")
        }
        .onAppear() {
            self.networkManager.getRecentScans(for: SessionManager.user!) { result in
                if self.networkManager.dataIsReady() { self.shouldShowIndicator = false }
            }
            self.networkManager.getCommonCrops(for: SessionManager.user!) { result in
                if self.networkManager.dataIsReady() { self.shouldShowIndicator = false }
            }
            self.networkManager.getCommonDiseases(for: SessionManager.user!) { result in
                if self.networkManager.dataIsReady() { self.shouldShowIndicator = false }
            }
        }
        //        .sheet(isPresented: self.$shouldPresentSheet) {
        ////            if self.headerClicked == "Recent scans" || self.headerClicked == "Common diseases" {
        ////                DiseaseView(diseaseName: self.networkManager.dashboardHeadlinesDic[self.headerClicked]![self.itemIdClicked])
        ////            } else {
        ////                EmptyView()
        ////            }
        //        }
        //.colorScheme(.dark)
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
