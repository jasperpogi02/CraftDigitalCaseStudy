//
//  APIManager.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchImages(parameters: ImageRequest, complete: @escaping(_ images: ImageResponse?, _ error: Error?) -> Void)
}

class APIService: APIServiceProtocol {
    
    static let sharedInstance = APIService()
    
    enum Router: URLConvertible {
        
        case settings
        
        var path: String {
            switch self {
            case .settings:
                return "ImageSearchAPI"
            }
        }
        
        func asURL() throws -> URL {
            switch self {
            case .settings:
                let url = URL(string: Constants.url)
                return url!.appendingPathComponent(path)
            }
        }
    }
    
    let config = URLSessionConfiguration.default
    
    var defaultManager: Alamofire.Session!
    
    init() {
        
        config.timeoutIntervalForRequest = Constants.timeoutIntervalForRequest
        config.timeoutIntervalForResource = Constants.timeoutIntervalForResponse
        config.requestCachePolicy = .reloadIgnoringCacheData
        
        let sessionManager = Session(configuration: config)
        
        self.defaultManager = sessionManager
        
    }
    
    func fetchImages(parameters: ImageRequest, complete: @escaping(_ images: ImageResponse?, _ error: Error?) -> Void) {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(parameters)
            guard let jsonDict = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] else { return }
            let headers = [
                "x-rapidapi-key": Constants.rapidApiKey,
                "x-rapidapi-host": Constants.rapidApiHost
            ]
            defaultManager.request(APIService.Router.settings,
                                   method: .get,
                                   parameters: jsonDict,
                                   encoding: URLEncoding.default,
                                   headers: HTTPHeaders(headers)).responseDecodable(of: ImageResponse.self) { response in
                                    switch response.result {
                                    case .success(let data):
                                        complete(data, nil )
                                    case .failure(let error):
                                        complete(nil, error)
                                    }
                                   }
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
}
