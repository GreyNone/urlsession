//
//  Films.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import Foundation

struct Films: Decodable {
    let count: Int
    let all: [Film]
    
    enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}
