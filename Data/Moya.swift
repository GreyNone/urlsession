//
//  Moya.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/12/23.
//

import Foundation
import Moya

struct Breed: Decodable {
    var breed: String
    var country: String
    var origin: String
    var coat: String
    var pattern: String
    
    enum CodingKeys: String, CodingKey {
        case breed
        case country
        case origin
        case coat
        case pattern
    }
}

struct Breeds: Decodable {
    var data: [Breed]
    var currentPage: Int
    var lastPage: Int
    var nextPageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case data
        case currentPage = "current_page"
        case lastPage = "last_page"
        case nextPageUrl = "next_page_url"
    }
}

struct Fact: Decodable {
    var fact: String
    
    enum CodingKeys: String, CodingKey {
        case fact
    }
}

struct Facts: Decodable {
    var data: [Fact]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

enum MyService {
    case breeds
    case facts
}

extension MyService: TargetType {
    var baseURL: URL { URL(string: "https://catfact.ninja")! }
    var path: String {
        switch self {
        case .breeds:
            return "/breeds"
        case .facts:
            return "/facts"
        }
    }
    var method: Moya.Method {
        switch self {
        case .breeds, .facts:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .breeds, .facts:
            return .requestPlain
        }
    }
    var sampleData: Data {
        return Data()
    }
    var headers: [String : String]? {
        return ["Content-Type": "application/jsonpos"]
    }
    public var validationType: ValidationType {
      return .successCodes
    }
}
