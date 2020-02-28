//
//  APIRequest.swift
//  PlantsDiseaseApp
//
//  Created by Radi Barq on 9/16/19.
//  Copyright © 2019 RadiBarq. All rights reserved.
//

import Foundation
import UIKit
import Combine

enum APIError: Error {
    case responseProblem
    case decondingProblem
    case encodingProblem
}

class NetworkManager: ObservableObject {
    @Published var cropsDiseases = [Disease]()
    @Published var scansHistory = [Scan]()
    @Published var recentScans = [Scan]()
    @Published var recentScansHistory = [String]()
    @Published var dashboardHeadlinesDic = [String: Array<String>]()
    @Published var diseasesLocoation = [Landmark]()
    @Published var loadingScansHistory = true
    public var cropsId = [Int]()
    @Published var dashboardDiseasesDic = [String: Array<Disease>]()
    @Published var dashbaordRecentScansIds = [Int]()
    
    var rootURLString = "https://croply.azurewebsites.net/"
    var recentScansURL: URL? =  URL(string: "https://croply.azurewebsites.net/plant/get_recent_scans_mobile")
    var commonCropsURL: URL? =  URL(string: "https://croply.azurewebsites.net/plant/get_common_crops_mobile")
    var commonDiseasesURL: URL? = URL(string: "https://croply.azurewebsites.net/plant/get_common_diseases_mobile")
    var scansHistoryURL: URL? =  URL(string: "https://croply.azurewebsites.net/plant/get_all_scans_mobile")
    var diseaseByCropKind: URL? = URL(string: "https://croply.azurewebsites.net/plant/get_crop_diseases_mobile")
    var diseasesLocationURL: URL? = URL(string: "https://croply.azurewebsites.net/plant/get_map_markers_mobile")
    static var scanImageURLStrig = "https://croply.azurewebsites.net/img/scans/"
    static var scanThumbnailURLString = "https://croply.azurewebsites.net/img/thumbnails/scans/"
    static var diseaeImageURLString = "https://croply.azurewebsites.net/img/thumbnails/diseases/"
    static var cropsImageURLString = "https://croply.azurewebsites.net/img/crops/"
    
    func dataIsReady() -> Bool {
        return dashboardHeadlinesDic.count == 3
    }
    
    func getScansHistory(for user: User, completion: @escaping(Result<ScanHistoryRequest, APIError>) -> Void) {
        do {
            guard let url = scansHistoryURL else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(ScanHistoryRequest.self, from: jsonData)
                    
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    
                    DispatchQueue.main.async {
                        self.scansHistory = response.scans
                        self.loadingScansHistory = false
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getDiseasesLocation(completion: @escaping(Result<ScansLocationRequest, APIError>) -> Void) {
        
        guard let url = diseasesLocationURL else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(ScansLocationRequest.self, from: jsonData)
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }
                DispatchQueue.main.async {
                    self.diseasesLocoation = response.markers.map {marker in
                        Landmark(name: marker.disease.name + " (" + String(marker.count) + ")", location: .init(latitude: marker.lat, longitude: marker.lng), red: marker.red, green: marker.green, blue: marker.blue)
                    }
                    completion(.success(response))
                }
            } catch {
                completion(.failure(.decondingProblem))
            }
        }
        dataTask.resume()
    }
    
    func getDiseaseByCropKind(for user: User, completion: @escaping(Result<CommonDiseasesRequest, APIError>) -> Void) {
        do {
            guard let url = diseaseByCropKind else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(CommonDiseasesRequest.self, from: jsonData)
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    DispatchQueue.main.async {
                        self.cropsDiseases = response.diseases
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getRecentScans(for user: User, completion: @escaping(Result<ScanHistoryRequest, APIError>) -> Void) {
        do {
            guard let url = recentScansURL else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(ScanHistoryRequest.self, from: jsonData)
                    
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    DispatchQueue.main.async {
                        self.dashboardDiseasesDic["Recent scans"] = response.scans.map { scan in
                            scan.disease!
                        }
                        self.dashboardHeadlinesDic["Recent scans"]  = response.scans.map { scan in
                            return scan.disease!.name
                        }
                        self.dashbaordRecentScansIds = response.scans.map { scan in
                            return scan.id!
                        }
                        
                        self.recentScans = response.scans
                        
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getCommonCrops(for user: User, completion: @escaping(Result<CommonCropsRequest, APIError>) -> Void) {
        do {
            guard let url = commonCropsURL else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(CommonCropsRequest.self, from: jsonData)
                    
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    DispatchQueue.main.async {
                        
                        self.cropsId = response.crops.map {$0.id}
                        self.dashboardHeadlinesDic["Diseases by crop kind"] = response.crops.map {$0.name}
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func getCommonDiseases(for user: User, completion: @escaping(Result<CommonDiseasesRequest, APIError>) -> Void) {
        do {
            guard let url = commonDiseasesURL else { return }
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(CommonDiseasesRequest.self, from: jsonData)
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                        print(JSONString)
                    }
                    DispatchQueue.main.async {
                        self.dashboardDiseasesDic["Common diseases"] = response.diseases
                        self.dashboardHeadlinesDic["Common diseases"] = response.diseases.map{ disease in
                            disease.name
                        }
                        completion(.success(response))
                    }
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
}
struct APIRequest {
    let resourceURL: URL
    let signUpUserURL: URL? = URL(string: "https://croply.azurewebsites.net/auth/register_mobile")
    init(endpoint: String) {
        let reourceString = "https://croply.azurewebsites.net/\(endpoint)"
        guard let resourceURL = URL(string: reourceString) else{fatalError()}
        self.resourceURL = resourceURL
    }
    
    func add(user: User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    func signUpUser(user:User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: signUpUserURL!)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                      let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
                    {
                        print(JSONString)
                    }
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func authenticate(user:User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                      let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8)
                    {
                        print(JSONString)
                    }
                      completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func forgotPassword(of user:User, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(user)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, data != nil else {
                    completion(.failure(.responseProblem))
                    return
                }
                completion(.success(APIResult(result: "success")))
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func changePasswordReuquest(with forgotPasswordRequest: ChangePasswordRequest, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(forgotPasswordRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func changeEmailRequest(with changeEmailRequest: ChangeEmailRequest, completion: @escaping(Result<APIResult, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(changeEmailRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let response = try JSONDecoder().decode(APIResult.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    
    func scanDisease(with scanRequest: Scan, completion: @escaping(Result<Scan, APIError>) -> Void) {
        do {
            var urlRequest = URLRequest(url: resourceURL)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField:  "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(scanRequest)
            let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response,_ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let jsonData = data else {
                    if let JSONString = String(data: data!, encoding: String.Encoding.utf8)
                            {
                                           print(JSONString)
                            }
                    completion(.failure(.responseProblem))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let response = try decoder.decode(Scan.self, from: jsonData)
                    completion(.success(response))
                } catch {
                    completion(.failure(.decondingProblem))
                }
            }
            dataTask.resume()
        } catch {
            completion(.failure(.encodingProblem))
        }
    }
    
    func UploadRequest(image: UIImage, scanId: Int, completion: @escaping(Result<String, APIError>) -> Void) {
        let url = URL(string: "https://croply.azurewebsites.net/plant/upload_photo_mobile")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let image_data = image.jpegData(compressionQuality: 0.8)
        if(image_data == nil) {
            completion(.failure(.encodingProblem))
            return
        }
        let body = NSMutableData()
        let fname = "\(scanId)" + ".jpeg"
        let mimetype = "image/jpeg"
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            guard ((data) != nil), let _:URLResponse = response, error == nil else {
                completion(.failure(.responseProblem))
                return
            }
            if let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) {
                completion(.success(dataString as String))
            }
        })
        
        task.resume()
    }
    
    func PredictImage(image: UIImage, completion: @escaping(Result<PredictionResult, APIError>) -> Void) {
      //  let url = URL(string: "https://croply-django.azurewebsites.net/predict")
        let url = URL(string: "http://127.0.0.1:8000/predict")
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let image_data = image.jpegData(compressionQuality: 0.5)
        if(image_data == nil) {
            completion(.failure(.encodingProblem))
            return
        }
        
        let body = NSMutableData()
        let fname = "test.jpeg"
        let mimetype = "image/jpeg"
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"test\"\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append("hi\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition:form-data; name=\"file\"; filename=\"\(fname)\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(image_data!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            guard ((data) != nil), let _:URLResponse = response, error == nil, let jsonData = data else {
                completion(.failure(.responseProblem))
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PredictionResult.self, from: jsonData)
                completion(.success(response))
            } catch(let error) {
                print(error)
                completion(.failure(.decondingProblem))
            }
        })
        task.resume()
    }
    func generateBoundaryString() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
}

struct APIResult: Decodable{
    var result: String
    var user: User?
}

struct PredictionResult: Decodable {
    var result1: Prediction
    var result2: Prediction
    var result3: Prediction
}

struct Prediction: Decodable {
    var id: Int
    var prediction: Float
}

struct ChangePasswordRequest: Encodable {
    var id: Int
    var oldPassword: String
    var newPassword: String
}

struct ChangeEmailRequest: Encodable {
    var email: String
    var id: Int
}
