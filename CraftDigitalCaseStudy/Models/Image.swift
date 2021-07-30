//
//  Image.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation

// MARK: - Image
struct Image {
    let type: String?
    let totalCount: Int?
    let value: [Value]?
}

// MARK: - Value
struct Value {
    let url: String?
    let height, width: Int?
    let thumbnail: String?
    let thumbnailHeight, thumbnailWidth: Int?
    let base64Encoding: NSNull?
    let name, title: String?
    let provider: Provider?
    let imageWebSearchURL, webpageURL: String?
}

// MARK: - Provider
struct Provider {
    let name, favIcon, favIconBase64Encoding: String?
}
