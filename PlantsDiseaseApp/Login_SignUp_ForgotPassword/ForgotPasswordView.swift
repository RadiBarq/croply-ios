//
//  ForgotPasswordView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/11/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldShowAlert = false
    @State private var showIndicator = false
    
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Email")
                        .fontWeight(.bold)
                        .foregroundColor(.green)
                    TextField("radibaraq@gmaadasdasil.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.emailAddress)
                }
                .padding()
                .padding(.top, 30)
                HStack {
                    Spacer()
                    Button(action: {
                        self.changePasswordClicked()
                    }) {
                        VStack {
                            if !showIndicator {
                                Text("Send email")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                            } else{
                            ActivityIndicator(isAnimating: $showIndicator)
                            }
                        }
                    }
                    .frame(width: 150,alignment: .center)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    Spacer()
                }
                .padding()
                .padding(.bottom, 30)
            }
            .background(Color.black)
            .cornerRadius(20)
            .padding()
            Spacer()
        }
        .background(
            Image("choice")
                .resizable()
                .aspectRatio(contentMode: .fill))
            .edgesIgnoringSafeArea([.top, .bottom])
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    func changePasswordClicked() {
        if !email.isValidEmail() {
            alertTitle = "Invalid email address"
            alertMessage = "Make sure you entered a valid email address."
            shouldShowAlert = true
            return
        }
        let user = User(id: 0, username: "", email: email, password: "radibarq")
        let postRequest = APIRequest(endpoint: "auth/passwords/email_submit_mobile")
        showIndicator = true
        postRequest.forgotPassword(of: user, completion: { result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    self.alertTitle = "forgot password email"
                    self.alertMessage = ""
                    self.shouldShowAlert = true
                    SessionManager.user
                        = response.user
                case "email_error":
                    self.alertTitle = "email or password invalid"
                    self.alertMessage = "Please try again with different information."
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
struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
