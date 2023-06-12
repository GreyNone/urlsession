//
//  Starships.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/9/23.
//

import Foundation

struct Starships: Decodable {
  var count: Int
  var all: [Starship]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
