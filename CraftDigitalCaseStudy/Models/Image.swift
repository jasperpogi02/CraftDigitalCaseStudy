//
//  Image.swift
//  CraftDigitalCaseStudy
//
//  Created by CDGTaxi on 30/7/21.
//

import Foundation

// MARK: - Image
struct ImageResponse: Codable {
    let type: String?
    let totalCount: Int?
    let images: [Images]?
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case totalCount
        case images = "value"
    }
}

// MARK: - Value
struct Images: Codable {
    let url: String?
    let height, width: Int?
    let thumbnail: String?
    let thumbnailHeight, thumbnailWidth: Int?
    let base64Encoding: JSONNull?
    let name, title: String?
    let provider: Provider?
    let imageWebSearchURL, webpageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case url, height, width, thumbnail, thumbnailHeight, thumbnailWidth, base64Encoding, name, title, provider
        case imageWebSearchURL = "imageWebSearchUrl"
        case webpageURL = "webpageUrl"
    }
}

// MARK: - Provider
struct Provider: Codable {
    let name, favIcon, favIconBase64Encoding: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath,
                                                                                  debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

struct ImageRequest: Codable {
    var q = ""
    var pageNumber = 1
    var pageSize = 10
    var autoCorrect = "true"
    var safeSearch: Bool?
}
