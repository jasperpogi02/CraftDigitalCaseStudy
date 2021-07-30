//
//  APIManager.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchImages(complete: @escaping( _ success: Bool, _ images: [Image], _ error: Error) -> Void)
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
    
    func fetchImages(complete: @escaping (Bool, [Image], Error) -> Void) {
        
    }
}
