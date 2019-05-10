//
//  ImageViewExtension.swift
//  Contact
//
//  Created by Ankit Kedia on 11/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation
import UIKit

private let imageDownloadQueue = DispatchQueue.init(label: "imageDownloadQueue", qos: .background, attributes: .concurrent)
var cache:NSCache<AnyObject, AnyObject>! = NSCache()

extension UIImageView {
    func downloadImage(from url: URL) {
        imageDownloadQueue.async {
            if cache.object(forKey: url as AnyObject) != nil {
                DispatchQueue.main.async() {
                    self.image = (cache.object(forKey: url as AnyObject) as! UIImage)
                }
            } else {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                        let data = data, error == nil,
                        let image = UIImage(data: data)
                        else { return }
                    DispatchQueue.main.async() {
                        cache.setObject(image, forKey: url as AnyObject)
                        self.image = image
                    }
                    }.resume()
            }
            }
            
    }

}
