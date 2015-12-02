//
//  Movie.swift
//  popular movies tvos
//
//  Created by Charles Robinson on 12/2/15.
//  Copyright © 2015 Chazware Tech. All rights reserved.
//

import Foundation

class Movie {
    
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    
    var title: String!
    var overview: String!
    var posterPath: String!
    
    init(movieDict: Dictionary<String, AnyObject>) {
        
        if let title = movieDict["title"] as? String {  //need to check there is actual data here but for now...
            
            self.title = title
        }
        
        if let overview = movieDict["overview"] as? String {
            
            self.overview = overview
        }
        
        if let path = movieDict["posterPath"] as? String {
            
            self.posterPath = "\(URL_BASE)\(path)"
        }
    }
    
}