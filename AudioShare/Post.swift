//
//  Post.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/27/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit

class Post: NSObject {
    
    var author: String!
    var song: String!
    var artist: String!
    var likes: Int!
    var userID: String!
    var postID: String!
    
    var peopleWhoLike: [String] = [String]()

    
}
