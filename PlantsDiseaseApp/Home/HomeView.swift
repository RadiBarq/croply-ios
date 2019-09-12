//
//  HomeView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    var options = ["History", "Email", "Password", "About us", "Contact us", "Logout"]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
              
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        self.optionClicked(option: option)
                    }){
                        Text(option)
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                            .font(.title)
                            .padding(.bottom, 5)
                    }
                }
               
            }
            .padding()
            .navigationBarTitle("Profile")
            
         
        }.colorScheme(.dark)
        

    }
    
    func optionClicked(option: String) {
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
