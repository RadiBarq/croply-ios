//
//  ChangeEmail.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ChangeEmailView: View {
    
    @State private var email: String = ""
    @EnvironmentObject var user: SessionUser
    @Environment(\.presentationMode) var presentation
    @State private var alertTitle = ""
    @State private var shouldShowAlert = false
    @State private var alertMessage = ""
    @State private var showIndicator = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Email")
                            .fontWeight(.bold)
                            .foregroundColor(.green)
                        TextField(user.email, text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(5)
                            .textContentType(.emailAddress)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .padding(.top, 1)
                    HStack {
                        Spacer()
                        Button(action: {
                            self.changeEmailClicked()
                        }) {
                            if !showIndicator {
                                Text("Change email")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .font(.headline)
                            } else{
                                ActivityIndicator(isAnimating: $showIndicator)
                            }
                        }
                        .frame(width: 150,alignment: .center)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        Spacer()
                    }
                    .padding()
                    .padding(.bottom, 15)
                }
                .background(Color.black)
                .cornerRadius(20)
                .padding(.top, 100)
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
            .onAppear() {
                self.email = self.user.email
            }
        }
    }
    func changeEmailClicked() {
        let changeEmailRequest = ChangeEmailRequest(email: email, id: 20)
        let postRequest = APIRequest(endpoint: "user/edit_email_mobile")
        showIndicator = true
        postRequest.changeEmailRequest(with: changeEmailRequest) {
            result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    self.alertTitle = "Email has been changed"
                    self.alertMessage = ""
                    self.shouldShowAlert = true
                     DispatchQueue.main.async {
                        self.user.email = self.email
                    }
                case "email_error":
                    self.alertTitle = "Email entered is not available right now"
                    self.alertMessage = "Please try again with different different email."
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
        }
    }
}
struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView()
    }
}
