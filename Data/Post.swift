//
//  Posts.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/8/23.
//

import Foundation

struct Post: Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(userId: Int, id: Int, title: String, body: String) {
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
    }
}

struct Posts: Decodable {
    let posts: [Post]
}
