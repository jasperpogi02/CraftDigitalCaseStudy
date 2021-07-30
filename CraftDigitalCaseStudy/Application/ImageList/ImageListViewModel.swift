//
//  ImageListViewModel.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation

class ImageListViewModel {
    
    let apiService: APIServiceProtocol
    
    private var images: [Image] = [Image]()
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
}
