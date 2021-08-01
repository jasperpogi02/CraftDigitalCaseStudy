//
//  ImageListViewModelTests.swift
//  ImageListViewModelTests
//
//  Created by CDGTaxi on 30/7/21.
//

import XCTest
@testable import CraftDigitalCaseStudy

class ImageListViewModelTests: XCTestCase {
    
    var sut: ImageListViewModel!
    var mockAPIService: MockApiService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockApiService()
        sut = ImageListViewModel(apiService: mockAPIService)
        
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testFetchImages() {
        mockAPIService.completeImages = [Images]()
        
        sut.fetchImages()
        
        XCTAssert(mockAPIService!.isFetchImageCalled)
    }
    
    func testLoadingWhenFetching() {
        
        var loadingStatus = false
        let expect = XCTestExpectation(description: "Loading Status Updated")
        sut.updateLoadingStatus = { [weak sut] in
            loadingStatus = sut!.isLoading
            expect.fulfill()
        }
        
        sut.fetchImages()
        XCTAssertTrue( loadingStatus )
        
        mockAPIService!.fetchSuccess()
        XCTAssertFalse( loadingStatus )
        
        wait(for: [expect], timeout: 60.0)
    }
    
}

class MockApiService: APIServiceProtocol {
    
    var isFetchImageCalled = false
    var completeImages: [Images] = [Images]()
    var completeClosure: ((ImageResponse?, Error?) -> Void)!
    
    func fetchImages(parameters: ImageRequest, complete: @escaping (ImageResponse?, Error?) -> Void) {
        isFetchImageCalled = true
        completeClosure = complete
    }
    
    func fetchSuccess() {
        completeClosure(nil, nil )
    }
    
    func fetchFail(error: Error?) {
        completeClosure(nil, error )
    }
    
}
