//
//  ChangePasswordView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ChangePasswordView: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var alertTitle = ""
    @State private var shouldShowAlert = false
    @EnvironmentObject var user: SessionUser
    @State private var alertMessage = ""
    @State private var showIndicator = false
    @Environment(\.presentationMode) var presentation
    
    
    
    var body: some View {
        VStack {
            Form {
                Section(
                    header:
                    Text("Old password")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                        .font(.headline)
                        .padding(.top, 15)
                    ,
                    footer:
                    SecureField("", text: $oldPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                ) {
                    EmptyView()
                }
                Section (
                    header:
                    Text("New password")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .font(.headline)
                        .padding(.top, 15)
                    ,
                    footer:
                    SecureField("", text: $newPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                ){
                    EmptyView()
                }
                
                Section(footer:
                    HStack {
                        Spacer()
                        Button(action: {
                            self.changePasswordClicked()
                        }) {
                            if !showIndicator {
                                Text("Change password")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                            } else {
                                ActivityIndicator(isAnimating: $showIndicator)
                            }
                            
                        }
                        .frame(width: 150,alignment: .center)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        Spacer()
                    }
                ){
                    EmptyView()
                }
            }
            .colorScheme(.dark)
            .cornerRadius(20)
            .padding(.top, 100)
            .frame(height: 440)
            .padding()
            Spacer()
        }
        .background(Color.white)
        .edgesIgnoringSafeArea([.top, .bottom])
        .navigationBarItems(leading:
            Button(action: {
                self.presentation.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.black)
        })
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
        
    }
    func changePasswordClicked() {
        let changePasswordRequest = ChangePasswordRequest(id: 18, oldPassword: oldPassword, newPassword: newPassword)
        let postRequest = APIRequest(endpoint: "user/edit_password_mobile")
        showIndicator = true
        postRequest.changePasswordReuquest(with: changePasswordRequest, completion: {
            result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    self.alertTitle = "Your password has been changed"
                    self.alertMessage = ""
                    self.shouldShowAlert = true
                case "email_error":
                    self.alertTitle = "Old password is invalid"
                    self.alertMessage = "Please try again with different password."
                    self.shouldShowAlert = true
                default:
                    self.alertTitle = "Unexpected problem happened!"
                    self.alertMessage = "We are working on the issue."
                    self.shouldShowAlert = true
                }
            case .failure(let type):
                switch type {
                case .responseProblem:
                    self.alertTitle = "Connection problem happened!"
                    self.alertMessage = "Please try again later."
                    self.shouldShowAlert = true
                case .decondingProblem, .encodingProblem:
                    self.alertTitle = "Unexpected problem happened!"
                    self.alertMessage = "We are working on the issue."
                    self.shouldShowAlert = true
                }
            }
        })
    }
}
struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
