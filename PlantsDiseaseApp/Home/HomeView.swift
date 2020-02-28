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
    @EnvironmentObject var user: SessionUser
    @State var headlinesDic = [String: Array<String>]()
    var cropType = ["Apple", "Corn", "Grape", "Potato", "Tomato"]
    var commonDisease = ["Apple Scab", "Tomato leaf mold", "Corn gray leaf spot", "Grape black rot", "Potato early blight", "Strawberry leaf scorch", "Peach bacterial spot", "Tomato mosaic virus", "Squash powdery mildew"]
    @State var shouldShowIndicator = true
    @State var keys = [String]()
    
    var body: some View {
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
                                            DiseaseView(disease: self.networkManager.dashboardDiseasesDic[headline]![item], otherDiseases: [], accuraces: [], showNavigation: false)
                                        ) {
                                            VStack {
                                                if headline == "Recent scans" {
                                                    ImageContainer(imageURL: NetworkManager.scanThumbnailURLString +
                                                        "\(self.networkManager.dashbaordRecentScansIds[item])" + ".jpeg")
                                                        // .renderingMode(.original)
                                                        // .resizable()
                                                        .frame(width: 275, height: 150)
                                                    HStack {
                                                        Text((self.networkManager.dashboardHeadlinesDic[headline])![item])
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                        Spacer()
                                                    }
                                                }
                                                else {
                                                    ImageContainer(imageURL: NetworkManager.diseaeImageURLString +
                                                        "\(self.networkManager.dashboardDiseasesDic[headline]![item].id)" + ".jpg")
                                                        // .renderingMode(.original)
                                                        // .resizable()
                                                        .frame(width: 275, height: 150)
                                                    HStack {
                                                        Text((self.networkManager.dashboardHeadlinesDic[headline])![item])
                                                            .font(.body)
                                                            .fontWeight(.bold)
                                                        Spacer()
                                                    }
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
                                                ImageContainer(imageURL: NetworkManager.cropsImageURLString + "\(self.networkManager.cropsId[item])" + ".jpg")
                                                    //.renderingMode(.original)
                                                    //.resizable()
                                                    .frame(width: 275, height: 150)
                                                HStack {
                                                    Text((self.networkManager.dashboardHeadlinesDic[headline])![item])
                                                        .font(.body)
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
                    .padding(.leading, 15)
                }
                if shouldShowIndicator {ActivityIndicator(isAnimating: $shouldShowIndicator)}
            }
            .navigationBarTitle("Discover")
        }
        .onAppear() {
            if self.user.scansChanged {
                self.user.scansChanged = false
                self.networkManager.getRecentScans(for: SessionManager.user!) { result in
                    if self.networkManager.dataIsReady() {
                        self.keys = self.networkManager.dashboardHeadlinesDic.map{$0.key}
                        self.shouldShowIndicator = false }
                }
                self.networkManager.getCommonCrops(for: SessionManager.user!) { result in
                    if self.networkManager.dataIsReady() { self.shouldShowIndicator = false
                        self.keys = self.networkManager.dashboardHeadlinesDic.map{$0.key}
                    }
                }
                self.networkManager.getCommonDiseases(for: SessionManager.user!) { result in
                    if self.networkManager.dataIsReady() { self.shouldShowIndicator = false
                        self.keys = self.networkManager.dashboardHeadlinesDic.map{$0.key}
                    }
                }
            }
        }
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
