//
//  FeedVC.swift
//  devslopes-social
//
//  Created by Franklin Tackett Jr. on 5/29/17.
//  Copyright © 2017 Franklin Tackett Jr. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super .viewDidLoad()
        
    }
    @IBAction func signOutTapped(_ sender: Any) {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: false, completion: nil)
        }
        let _ = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        print("FRANKLIN: Keychain removed successfully")
        //performSegue(withIdentifier: "toLogIn", sender: nil)
    }

}
