//
//  Network.swift
//  AnimateApp
//
//  Created by Tiko on 11/6/20.
//

import UIKit

class Network {
    
    func fetchImage(from url: String, completion: @escaping(UIImage?) -> Void){
        guard let url = URL(string: url),
              let data = try? Data(contentsOf: url) else {
            return
        }
        completion(UIImage(data: data))
    }
    
    //    func fetchImage(from urlString: String, completion: @escaping(UIImage?) -> Void) {
    //        guard let url = URL(string: urlString) else { return }
    //
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            guard let imageData = data,
    //                  let image = UIImage(data: imageData) else {
    //                return completion(nil)
    //            }
    //            DispatchQueue.global().async {
    //                DispatchQueue.main.async {
    //                    completion(image)
    //                    print(image)
    //                }
    //            }
    //        }.resume()
    //    }
}
