//
//  TumblePost.swift
//  tumblr
//
//  Created by Raj Sathyaseelan on 10/15/16.
//  Copyright © 2016 Token. All rights reserved.
//

import Foundation

class TumblePost {
    var postid: String
    var blogName: String
    var summary: String
    var photoURL: String
    
    
    init(postid: String, summary: String, blogName: String, photoURL: String) {
        self.postid = postid
        self.blogName = blogName
        self.photoURL = photoURL
        self.summary = summary
    }
    
}
