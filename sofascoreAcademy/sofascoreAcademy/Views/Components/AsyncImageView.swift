//
//  AsyncImageView.swift
//  hw3
//
//  Created by Tina Jureško on 29.03.2025..
//

import Foundation
import UIKit

class AsyncImageView: UIImageView {
    
    func setImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
