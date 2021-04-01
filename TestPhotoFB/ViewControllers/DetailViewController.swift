//
//  DetailViewController.swift
//  TestPhotoFB
//
//  Created by User on 31.03.2021.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!
    
    var photoLink: PictureModel?
    var imageLinksArray: [PictureModel] = []
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeInterface()
        customizeLabel()
    }
    
    func customizeInterface() {
        guard let link = photoLink?.link else { return }
        guard let url = URL(string: link) else { return }
        photoImageView.load(url: url)
    }
    
    func customizeLabel() {
        guard let index = index else { return }
        let imageCount = imageLinksArray.count
        countLabel.text =  "\(index + 1)/\(imageCount)"
    }
}

