//
//  ProfileView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var optionsTitle = ["History", "Email", "Password", "About us", "Contct us", "Logout"]
    
    @State var shouldPresentSheet = false
    @State var selectedItem = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ScrollView(.horizontal) {
                    ForEach(optionsTitle, id: \.self) { title in
                        Button(action: {
                            self.selectedItem = title
                            self.shouldPresentSheet = true
                        }) {
                            Text(title)
                                .fontWeight(.bold)
                                .foregroundColor(.green)
                                .font(.title)
                                .padding(.bottom, 15)
                        }
                        
                    }
                }
                .padding(.top, 100)
                Spacer()
            }
            Spacer()
        }
        .background(Color.black)
        .edgesIgnoringSafeArea([.top, .bottom])
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
