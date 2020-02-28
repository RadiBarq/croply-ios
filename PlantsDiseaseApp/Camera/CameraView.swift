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
    @State var showCamera = false
    @State var showChangeImageAction: Bool = false
    @State  var showPickImageAction: Bool = false
    @State var uiImage: UIImage?
    @State private var showIndicator = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var shouldShowAlert = false
    @State private var detectionFinished = false
    @State var detectedDisease: Disease?
    @State var otherDieaseas: [Disease?]?
    @State var accuraces: [Float]?
    @EnvironmentObject var user: SessionUser
    @EnvironmentObject var location: LocationManager
    
    var changeImageSheet: ActionSheet {
        ActionSheet(
            title: Text("Scan Image"),
            buttons: [
                .default(Text("Change"), action: {
                    self.showChangeImageAction = false
                    self.showChangeImageAction = true
                }),
                .cancel(Text("Close"), action: {
                    self.showChangeImageAction = false
                    
                }),
                .destructive(Text("Remove"), action: {
                    self.showChangeImageAction = false
                    self.uiImage = nil
                })
        ])
    }
    var pickImageSheet: ActionSheet {
        ActionSheet(
            title: Text("Pick Image"),
            buttons: [
                .default(Text("Camera"), action: {
                    self.showPickImageAction = false
                    self.showCamera = true
                    self.showImagePicker = true
                }),
                .default(Text("Library"), action: {
                    self.showPickImageAction = false
                    self.showCamera = false
                    self.showImagePicker = true
                    //self.showImagePicker = true
                }),
                .cancel(Text("Close"), action: {
                    self.showPickImageAction = false
                })
        ])
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Button(action: {
                        self.dismissImageClicked()
                    }) {
                        if self.uiImage != nil {
                            Image(systemName: "xmark")
                                .font(.title)
                        } else {
                            EmptyView()
                        }
                    }
                    Spacer()
                }
                .padding()
                .sheet(isPresented: $detectionFinished, onDismiss: {
                       self.detectionFinished = false
                   }, content: {
                    DiseaseView(disease: self.detectedDisease!, otherDiseases: self.otherDieaseas!, accuraces: self.accuraces ?? [], showNavigation: true)
                   })
                Spacer()
                
                Image(uiImage: uiImage ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .onTapGesture {
                        self.showChangeImageAction = true
                }
                
                Spacer()
                HStack {
                    Button(action: {
                        if self.uiImage != nil {
                            self.uploadClicked()
                        } else {self.pickImageClicked()}
                    }) {
                        VStack {
                            if !showIndicator {
                                HStack {
                                    Spacer()
                                    Text(self.uiImage == nil ? "Pick an image" : "Detect disease")
                                        .foregroundColor(Color.white)
                                        .fontWeight(.bold)
                                        .font(Font.system(size: 18))
                                    
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
                    .frame(height: 25)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    
                }
                .padding()
                .padding(.init(top: 0, leading: 80, bottom: 25, trailing: 80))
                .sheet(isPresented: $showImagePicker, onDismiss: {
                    self.showImagePicker = false
                }, content: {
                    CameraViewController(isShown: self.$showImagePicker, image: self.$uiImage, showCamera: self.$showCamera)
                })
            }
        }
        .actionSheet(isPresented: $showChangeImageAction) {
                changeImageSheet
        }
        .actionSheet(isPresented: $showPickImageAction) {
            pickImageSheet
        }
        .alert(isPresented: $shouldShowAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
        }
    }
    
    func uploadClicked() {
        showIndicator = true
        //let scanRequest = Scan(userId: user.id, diseaseName: "Apple Scab", cropName: "Apple", lat: 32.234562, lng: 35.251255)
        let postRequest = APIRequest(endpoint: "plant/add_scan_mobile")
        showIndicator = true
        // postRequest.UploadRequest(image: uiImage!)
        postRequest.PredictImage(image: uiImage!){ result in
            switch result {
            case .success(let response):
                if response.result1.id == 0 {
                    self.alertTitle = "Cannot detect disease!"
                    self.alertMessage = "Please take a picture of only one leaf. We are working on improving the supported diseases in our app."
                    self.shouldShowAlert = true
                    self.showIndicator = false
                    return
                }
                
                let scanRequest = Scan(id: response.result1.id, userId: self.user.id, lat: self.location.lastKnownLocation?.coordinate.latitude ?? 0.0, lng: self.location.lastKnownLocation?.coordinate.longitude ?? 0.0, diseaseId: response.result1.id, diseaseId2: response.result2.id, diseaseId3: response.result3.id, accuracy: response.result1.prediction, accuracy2: response.result2.prediction, accuracy3: response.result3.prediction)
                postRequest.scanDisease(with: scanRequest) {
                    result in
                    self.showIndicator = false
                    switch result {
                    case .success(let scan):
                        postRequest.UploadRequest(image: self.uiImage!, scanId: scan.disease!.scanId!) { result in }
                        self.diseaseDetected(disease: scan.disease!, otherDiseases: [scan.disease2, scan.disease3], accuraces: [scan.accuracy, scan.accuracy2, scan.accuracy3])
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
            case .failure(let type):
                self.showIndicator = false
                switch type {
                case .responseProblem:
                    self.alertTitle = "Connection problem happened!"
                    self.alertMessage = "Please try again later."
                    self.shouldShowAlert = true
                case .encodingProblem, .decondingProblem:
                    self.alertTitle = "Unexpected problem happened!"
                    self.alertMessage = "We are working on the issue."
                    self.shouldShowAlert = true
                }
            }
        }
    }
    
    func parseModelResult(modelResult: String) -> (String, String) {
        let result = modelResult.split(separator: "_").map{String($0)}
        return (result[0], result[1])
    }
    
    func dismissImageClicked() {
        self.uiImage = nil
    }
    
    func diseaseDetected(disease: Disease, otherDiseases: [Disease?], accuraces: [Float]) {
        self.user.scansChanged = true
        self.detectedDisease = disease
        self.otherDieaseas = otherDiseases
        self.accuraces = accuraces
        dismissImageClicked()
        self.detectionFinished = true
    }
    
    func pickImageClicked() {
        showPickImageAction = true
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
    @Binding var showCamera: Bool
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var isShown: Bool
        @Binding var image: UIImage?
        @Binding var showCamera: Bool
        init(isShown: Binding<Bool>, image: Binding<UIImage?>, showCamera: Binding<Bool>) {
            _isShown = isShown
            _image = image
            _showCamera = showCamera
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = imagePicked
            isShown = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, image: $image, showCamera: $showCamera)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraViewController>) -> UIImagePickerController {
        let vc = UIImagePickerController()
        if self.showCamera {vc.sourceType = .camera}
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CameraViewController>) {
        
    }
}
