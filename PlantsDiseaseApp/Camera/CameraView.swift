//
//  CameraView.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/12/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import SwiftUI

struct CameraView: View {
    
    @State var showImagePicker = false
    @State var showAction: Bool = false
    @State var uiImage: UIImage? = nil
    @State private var showIndicator = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldShowAlert = false
    
    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Leaf Image"),
            buttons: [
                .default(Text("Change"), action: {
                    self.showAction = false
                    self.showImagePicker = true
                }),
                .cancel(Text("Close"), action: {
                    self.showAction = false
                }),
                .destructive(Text("Remove"), action: {
                    self.showAction = false
                    self.uiImage = nil
                })
        ])
    }
    var body: some View {
        VStack {
            if (uiImage == nil) {
                Image(systemName: "camera.on.rectangle")
                    .accentColor(Color.purple)
                    .background(
                        Color.gray
                            .frame(width: 100, height: 100)
                            .cornerRadius(6))
                    .onTapGesture {
                        self.showImagePicker = true
                }
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            self.dismissImageClicked()
                        }) {
                            Image(systemName: "xmark")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    Spacer()
                    Image(uiImage: uiImage!)
                        .resizable()
                        .onTapGesture {
                            self.showAction = true
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            self.uploadClicked()
                        }) {
                            VStack {
                                if !showIndicator {
                                    HStack {
                                        Spacer()
                                        Text("Detect disease")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                } else {
                                    
                                    HStack {
                                        Spacer()
                                        ActivityIndicator(isAnimating: $showIndicator)
                                        Spacer()
                                        
                                    }
                                }
                            }
                        }
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                    }
                    .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                }
            }
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
            self.showImagePicker = false
        }, content: {
            CameraViewController(isShown: self.$showImagePicker, image: self.$uiImage)
        })
            .actionSheet(isPresented: $showAction) {
                sheet
        }
        .alert(isPresented: $shouldShowAlert) {
                       Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func uploadClicked() {
        showIndicator = true
        let scanRequest = Scan(userId: 0, lat: 32.123124, long: 30.12312123)
        let postRequest = APIRequest(endpoint: "user/edit_email_mobile")
        showIndicator = true
        postRequest.scanDisease(with: scanRequest) {
            result in
            self.showIndicator = false
            switch result {
            case .success(let response):
                switch response.result {
                case "success":
                    self.diseaseDetected()
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
    func dismissImageClicked() {
        showAction = true
    }
    
    func diseaseDetected() {
        
        self.alertTitle = "Disease detected successfully!"
        self.alertMessage = "We are working on the issue."
        self.shouldShowAlert = true
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}

struct CameraViewController: UIViewControllerRepresentable{
    
    @Binding var isShown: Bool
    @Binding var image: UIImage?
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isShown: Bool
        @Binding var image: UIImage?
        
        init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
            _isShown = isShown
            _image = image
        }
    
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = imagePicked
            isShown = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraViewController>) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CameraViewController>) {
        
    }
}
