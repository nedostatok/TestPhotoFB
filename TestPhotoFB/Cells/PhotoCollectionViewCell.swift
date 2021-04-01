//
//  PhotoCollectionViewCell.swift
//  TestPhotoFB
//
//  Created by User on 26.03.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView!
    
    func customiseCell(link: PictureModel ) {
        guard let link = link.link else { return }
        guard let url = URL(string: link) else { return }
        imageView.load(url: url)
    }
}


