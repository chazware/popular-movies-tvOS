//
//  ViewController.swift
//  popular movies tvos
//
//  Created by Charles Robinson on 11/28/15.
//  Copyright © 2015 Chazware Tech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [Movie]()
    
    let URL_BASE = "http://api.themoviedb.org/3/movie/popular?api_key=c84862ed9758b0dc6a07a041d42a3b10"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.registerClass(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
       
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        
        downloadData()
    }
    // This download should be done in the model but put here for convenience.
    func downloadData() {
        
        let url = NSURL(string: URL_BASE)!  //forced upwrapped because we know this works otherwise try catch for error on url.
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in  //Autocomplete doesn't work with this.
            
            if error != nil {print(error.debugDescription)}
            
            else { // parse the JSON out from the database
                
                do {
                    
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["results"] as? [Dictionary<String, AnyObject>] {
                    
                        for obj in results {
                            
                            let movie = Movie(movieDict: obj)
                            self.movies.append(movie)
                        }
                        
                        //Main UI thread
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            self.collectionView.reloadData()
                        }
                        
                    }
                    
                    
                    
                } catch {   }
            }
            
        }
        
       task.resume()
        
    }
    
    // collectionView functions
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell {
            
            let movie = movies[indexPath.row]
            
            cell.configureCell(movie)
            
            return cell
            
        } else {
            
            return MovieCell()
            
        }
        
        
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        return movies.count
        
    }
     
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(310, 479)
        
    }
    
    
        
}
    


