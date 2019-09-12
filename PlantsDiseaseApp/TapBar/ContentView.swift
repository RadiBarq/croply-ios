//
//  ContentView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/10/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 0
    
    //    init() {
    //
    //        UITabBar.appearance().backgroundColor = UIColor.black
    //
    //    }
    //
    var body: some View {
        TabView(selection: $selection){
            Text("First View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "house.fill")
                            .font(Font.title.weight(.semibold))
                    }
            }
            .tag(0)
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "plus.circle.fill")
                            .font(Font.title.weight(.semibold))
                        
                    }
            }
            .tag(1)
            
            Text("Second View")
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "person.fill")
                          .font(Font.title.weight(.semibold))
                            
                    }
            }
            .tag(2)
            
        }.colorScheme(.dark)
            .accentColor(.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
