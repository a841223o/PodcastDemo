//
//  ImageLoader.swift
//  PodcastDemo
//
//  Created by leo on 2022/6/15.
//

import Foundation
import UIKit

public class ImageLoader {
    
    static let shared = ImageLoader()
    private var loadedImages = [URL: UIImage]()
    private var runningRequests = [UUID: URLSessionDataTask]()
    private var uuidDic = [UIImageView:UUID]()
    
    private func setImage(_ image:UIImage , for imageView : UIImageView){
        DispatchQueue.main.async {
            imageView.image = image
        }
    }

    func load(_ url: URL, for imageView: UIImageView) {
        
        if let image = loadedImages[url] {
            setImage(image, for: imageView)
        }
        
        let uuid = UUID()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer {self.runningRequests.removeValue(forKey: uuid) }
            if let data = data , let image = UIImage(data: data){
                self.loadedImages[url] = image
                self.setImage(image, for: imageView)
                return
            }
            
        }
        task.resume()
        runningRequests[uuid] = task
        uuidDic[imageView] = uuid
        
    }

    func cancel(for imageView: UIImageView) {
        
        imageView.image = nil
        
        guard let uuid = uuidDic[imageView] else{
            return
        }
        runningRequests[uuid]?.cancel()
        runningRequests.removeValue(forKey: uuid)
        uuidDic.removeValue(forKey: imageView)
    }
    
    
}

extension UIImageView {
    
    func loadImage(at url: URL) {
        ImageLoader.shared.load(url, for: self)
    }

    func cancelImageLoad() {
        ImageLoader.shared.cancel(for: self)
    }
}
