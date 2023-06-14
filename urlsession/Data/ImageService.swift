//
//  ImageService.swift
//  urlsession
//
//  Created by Aliaksandr Vasilevich on 6/13/23.
//

import Foundation
import UIKit
import Alamofire

final class ImageService {
    
    func image(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let request = AF.request(url, method: HTTPMethod.get)
        request.validate().response { response in
            var image: UIImage?
            
            defer {
                DispatchQueue.main.async {
                    completion(image)
                }
            }
            
            guard let data = response.data else { return }
            image = UIImage(data: data)
        }
    }
}
