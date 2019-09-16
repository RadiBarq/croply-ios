//
//  ProfileView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var optionsTitle = ["History", "Email", "Password", "Logout"]
    
    @State private var shouldPresentSheet = false
    @State private var selectedItem = ""
    @State private var userName = "Radi Barq"
    @State private var city = "nablus"
    
    var body: some View {
        VStack {
            Image("profile_background")
                .resizable()
                .frame(height: 300)
                .cornerRadius(25)
            ZStack {
                
                VStack {
                    Text(userName)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .padding()
                        .padding(.bottom, 0)
                        .frame(width: 200)
                    
                    Text(city)
                        .foregroundColor(.black)
                        .font(.title)
                        .fontWeight(.semibold)
                        
                        .padding()
                        .padding(.top, -30)
                    
                }
                .background(Color.white)
                .cornerRadius(15)
                .offset(y: -75)
                .zIndex(100)
                .shadow(radius: 25)
            }
            VStack {
                Spacer()
                ForEach(optionsTitle, id: \.self) { title in
                    Button(action: {
                        self.selectedItem = title
                        self.shouldPresentSheet = true
                    }) {
                        HStack {
                            Spacer()
                            Text(title)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)
                                .font(.title)
                            Spacer()
                        }
                        .padding(.bottom, 0)
                        
                    }
                }
                .padding(.bottom, 15)
                .padding(.top, 15)
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(15)
            .padding()
        .offset(y: -75)
            .shadow(radius: 25)
            Spacer()
        }
            
        .edgesIgnoringSafeArea([.top])
        .sheet(isPresented: self.$shouldPresentSheet) {
            if self.selectedItem == "History" {
                ChangeEmailView()
            } else if self.selectedItem == "Email" {
                ChangeEmailView()
            } else if self.selectedItem == "Password" {
                ChangePasswordView()
            } else if self.selectedItem == "About us" {
                ChangePasswordView()
            } else if self.selectedItem == "Contact us" {
                ChangePasswordView()
            } else if self.selectedItem == "Logout" {
                ChangePasswordView()
            } else {
                ChangePasswordView()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

func optionClicked() {
    
}
