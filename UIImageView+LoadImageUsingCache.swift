//
//  UIImageView+LoadImageUsingCache.swift
//  BrastlewarkGame
//
//  Created by Hector Hernandez on 11/22/18.
//  Copyright © 2018 Hector Hernandez. All rights reserved.
//


import UIKit

let imageCache = NSCache<NSString, AnyObject>()


extension UIImageView {
    
   
     public func loadImageUsingCache(withUrl urlString: String) {
        let url = URL(string: urlString)
        self.image = nil
        
       
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
      
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
        }).resume()
    }

    
    public func setRounded() {
        self.layer.borderWidth = 0.5
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
