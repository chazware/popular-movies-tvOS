//
//  MovieCell.swift
//  popular movies tvos
//
//  Created by Charles Robinson on 11/28/15.
//  Copyright © 2015 Chazware Tech. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    //@IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieLbl: UILabel!
    
    func configureCell(movie: Movie) {
        
        if let title = movie.title {
            
            movieLbl.text = title
            
        }
        
        if let path = movie.posterPath {
            
            let url = NSURL(string: path)!
            
            
            // When downloading data from internet switch from main queue
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
                let data = NSData(contentsOfURL: url)! // Bad practice to uprap here
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    let img = UIImage(data: data)
                    self.movieImg.image = img
                    
                }
            
            }
            
        }
    }
    
}
