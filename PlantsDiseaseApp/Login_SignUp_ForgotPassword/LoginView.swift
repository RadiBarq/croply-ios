//
//  LoginView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/10/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var shouldShowAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showIndicator = false
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var user: SessionUser
    
    var body: some View {
        VStack {
            Spacer()
            HStack(alignment: .center) {
                Image("grapes")
                    .resizable()
                    .frame(width: 75, height: 130, alignment: .center)
            }
            Form {
                Section(header: Text("Email")
                    .fontWeight(.bold)
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.top, 15),
                        footer:
                    TextField("radibaraq@gmail.com", text: $email)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(5)
                        .textContentType(.emailAddress)
                ) {
                    EmptyView()
                }
                .font(.headline)
                Section(
                    header:
                    Text("Password")
                        .fontWeight(.bold)
                        .font(.headline)
                        .foregroundColor(.green)
                        .padding(.top, 15)
                    ,
                    footer: SecureField("", text: $password)
                        .padding()
                        .cornerRadius(5)
                        .background(Color.white)
                        .textContentType(.password)) {
                            
                            EmptyView()
                }
                .cornerRadius(5)
                .font(.headline)
                Section(footer:
                    HStack {
                        Spacer()
                        Button(action: {
                            self.loginClicked()
                        }) {
                            VStack {
                                if !showIndicator {
                                    Text("Log in")
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
                    .font(.headline)
                ){
                    EmptyView()
                }
                Section(footer:
                    HStack {
                        Spacer()
                        Button(action: {
                            self.signupClicked()
                        }) {
                            Text("Forgot password?")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                ){
                    EmptyView()
                }
                .font(.headline)
                Section(footer:
                    HStack {
                        Spacer()
                        Text("Don't have an account?")
                            .foregroundColor(.green)
                            .font(.subheadline)
                        Button(action: {
                            self.signupClicked()
                        }) {
                            Text("Sign up here")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .font(.subheadline)
                        }
                        Spacer()
                }){
                    EmptyView()
                }
            }
            .colorScheme(.dark)
            .cornerRadius(15)
            .frame(height: 440)
            .padding()
            Spacer()
        }
        .background(
            Image("choice")
                .resizable()
                .aspectRatio(contentMode: .fill))
            .edgesIgnoringSafeArea([.top])
            .alert(isPresented: $shouldShowAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    func loginClicked() {
        if !email.isValidEmail() {
            alertTitle = "Invalid email address"
            alertMessage = "Make sure you entered a valid email address."
            shouldShowAlert = true
            return
        } else if password.count < 5 {
            alertTitle = "Passowrd is invalid!"
            alertMessage = "Make sure you entered a valid password."
            shouldShowAlert = true
            return
        }
        let currentUser = User(id: 0, username: "", email: email, password: password)
        let postRequest = APIRequest(endpoint: "auth/login_mobile")
        showIndicator = true
        postRequest.authenticate(user: currentUser, completion: { result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    DispatchQueue.main.async {
                        guard let user = response.user else { return }
                        SessionManager.user = user
                        self.user.email = user.email
                        self.user.username = user.username
                        self.user.id = user.id
                        self.user.signedUpClicked = false
                        self.user.signedInClicked = false
                       // UserDefaults.standard.set(user, forKey: "user")
                        UserDefaults.standard.set(self.user.email , forKey: "email")
                        UserDefaults.standard.set(self.user.id , forKey: "id")
                        UserDefaults.standard.set(self.user.username , forKey: "username")
                        UserDefaults.standard.set(true , forKey: "signed_in")
                    }
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
    
    func signupClicked() {
        
        self.user.signedUpClicked = true
        self.user.signedInClicked = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(SessionUser())
    }
}
