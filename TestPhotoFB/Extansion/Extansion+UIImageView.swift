//
//  Extansion+UIImageView.swift
//  TestPhotoFB
//
//  Created by User on 01.04.2021.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityIndicator.center = CGPoint(x:self.frame.width/2,
                                           y: self.frame.height/2)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        activityIndicator.stopAnimating()
                        activityIndicator.isHidden = true
                    }
                }
            }
        }
    }
}
