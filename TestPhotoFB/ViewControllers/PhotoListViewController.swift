//
//  PhotoListViewController.swift
//  TestPhotoFB
//
//  Created by User on 26.03.2021.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class PhotoListViewController: UIViewController {
    @IBOutlet weak var photoCollection: UICollectionView!
    
    var imageLinksArray: [PictureModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.photoCollection.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
    }
    
    func fetchPhotos() {
        FaceBookService.shared.getUserPhotos { photos in
            switch photos {
            case let .success(photoArr):
                self.imageLinksArray = photoArr
            case let .failure(err):
                print(err)
            }
        }
    }
    
    func checkLogin() {
        if !(AccessToken.isCurrentAccessTokenActive) {
            guard let loginVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else { return }
            loginVC.closureForFetchPhotos = {
                self.fetchPhotos()
            }
            self.present(loginVC, animated: true)
            return
        }
    }
}

extension PhotoListViewController: UICollectionViewDelegate{}
extension PhotoListViewController: UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageLinksArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell()}
        let imgLink = imageLinksArray[indexPath.item]
        cell.customiseCell(link: imgLink)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVC = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController else { return }
        let selected = imageLinksArray[indexPath.item]
        let picArray = imageLinksArray
        let index = indexPath.item
        
        detailVC.photoLink = selected
        detailVC.index = index
        detailVC.imageLinksArray = picArray
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension PhotoListViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount: CGFloat = 3
        let padding = 20 * (itemsCount + 1)
        let width = collectionView.frame.width - padding
        let itemWidth = width / itemsCount
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
}
