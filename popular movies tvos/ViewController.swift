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
    
    let URL_BASE = "http://api.themoviedb.org/3/movie/popular?api_key=c84862ed9758b0dc6a07a041d42a3b10"

    override func viewDidLoad() {
        super.viewDidLoad()
       
        downloadData()
    }
    
    func downloadData() {
        
        let url = NSURL(string: URL_BASE)!
        let request = NSURLRequest(URL: url)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            
            if error != nil {print(error.debugDescription)}
            
            else {
                
                do {
                    
                    let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? Dictionary<String, AnyObject>
                    
                    if let results = dict!["results"] as? [Dictionary<String, AnyObject>] {print(results)}
                    
                    } catch {   }
            }
            
        }
        
       task.resume()
        
    }
        
    
    

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return UICollectionViewCell()
        
    }
        
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
        return 1
        
    }
     
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(310, 479)
        
    }
    
    
        
    }
    


}