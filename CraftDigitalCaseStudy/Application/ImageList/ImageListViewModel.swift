//
//  ImageListViewModel.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation

class ImageListViewModel {
    
    let apiService: APIServiceProtocol
    var imageRequestData = ImageRequest()
    var images: [Images]? = [Images]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var reloadTableViewClosure: (() -> Void)?
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchImages() {
        self.isLoading = true
        apiService.fetchImages(parameters: imageRequestData) { [weak self] (images, error) in
            self?.isLoading = false
            if let error = error {
                self?.alertMessage = error.localizedDescription
            } else {
                if let images = images?.images {
                    self?.images = images
                }
            }
            
        }
    }
    
}
