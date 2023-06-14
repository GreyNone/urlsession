//
//  CacheManager.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/14/23.
//

import Foundation
import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    func getValue(for key: String) -> UIImage? {
        if let imageFromCache = imageCache.object(forKey: key as AnyObject) {
            let image = imageFromCache as? UIImage
            return image
        }
        
        return nil
    }
    
    func write(value: UIImage, for key: String) {
        imageCache.setObject(value, forKey: key as AnyObject)
    }
}
