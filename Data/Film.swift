//
//  films.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import Foundation

struct Film: Decodable {
    
    let id: Int
    let title: String
    let openingCrawl: String
    let director: String
    let producer: String
    let releaseDate: String
    let starships: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case starships
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(Int.self, forKey: .id)
//        title = try container.decode(String.self, forKey: .title)
//        openingCrawl = try container.decode(String.self, forKey: .openingCrawl)
//        director = try container.decode(String.self, forKey: .director)
//        producer = try container.decode(String.self, forKey: .producer)
//        releaseDate = try container.decode(String.self, forKey: .releaseDate)
//        starships = try container.decode([String].self, forKey: .starshiphs)
//        count = try container.decode(Int.self, forKey: .count)
//        all = try container.decode([Films].self, forKey: .all)
//    }
}




