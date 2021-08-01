//
//  ImageListViewModel.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation

class ImageListViewModel {
    
    let apiService: APIServiceProtocol
    var isLoading = false
    var images: [Images]?
    var imageRequestData = ImageRequest()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchImages(completion: @escaping () -> Void) {
        self.isLoading = true
        apiService.fetchImages(parameters: imageRequestData) { [weak self] (images, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let images = images?.images {
                    self?.images = images
                    completion()
                }
            }
            
        }
    }
    
}
