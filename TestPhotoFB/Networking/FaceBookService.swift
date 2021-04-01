//
//  NetworkService.swift
//  TestPhotoFB
//
//  Created by User on 29.03.2021.
//

import Foundation
import FBSDKCoreKit

class FaceBookService {
    static let shared = FaceBookService()
    typealias HandlePhotos = (Result<[PictureModel],Error>) -> ()
    
    func getUserPhotos(completion: @escaping HandlePhotos){
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me/photos?fields=link&type=uploaded", parameters: ["fields":"picture"])
        
        graphRequest.start(completionHandler: { (connection, result, error) in
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                completion(.failure(error!))
                return
            }
            
            var picModelArr: [PictureModel] = []
            
            if let result = result as? [String:Any] {
                if let data = result["data"] as? [[String:Any]] {
                    for i in data {
                        guard let pictureUrl = i["picture"] as? String else { return }
        
                        let picModel = PictureModel(link: pictureUrl)
                        picModelArr.append(picModel)
                    }
                }
            }
            completion(.success(picModelArr))
        })
    }
}


