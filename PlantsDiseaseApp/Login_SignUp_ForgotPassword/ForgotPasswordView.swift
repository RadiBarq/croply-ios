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
    @State private var password: String = ""
    
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
                        Text("Send email")
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
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
    }
    
    func changePasswordClicked() {
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
