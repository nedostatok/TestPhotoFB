//
//  ViewController.swift
//  TestPhotoFB
//
//  Created by User on 26.03.2021.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    var closureForFetchPhotos : (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createLoginButton()
    }
    
    func createLoginButton() {
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        loginButton.permissions = ["public_profile","email","user_photos"]
        loginButton.delegate = self
        view.addSubview(loginButton)
    }
}

extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard AccessToken.isCurrentAccessTokenActive else { return }
        openPhotoVC()
    }
    
    private func openPhotoVC() {
        dismiss(animated: true,completion: closureForFetchPhotos)
    }
}


