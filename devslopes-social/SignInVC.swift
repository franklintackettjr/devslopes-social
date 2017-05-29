//
//  SignInVC.swift
//  devslopes-social
//
//  Created by Franklin Tackett Jr. on 5/28/17.
//  Copyright © 2017 Franklin Tackett Jr. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("FRANKLIN: Unable to login with Facebook - \(error)")
            } else if result?.isCancelled == true {
                print("FRANKLIN: User cancelled Facebook auth ")
            } else {
                print("FRANKLIN: Successfully logged in with facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    }
    
    func firebaseAuth (_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print("FRANKLIN: Unable to auth with firebase - \(error)")
            } else {
                print("FRANKLIN: Successfully authed with firebase")
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailField.text , let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                if error == nil {
                    print("FRANKLIN: (Email) User authed with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("FRANKLIN: Unabled to auth email with firebase")
                        } else {
                            print("FRANKLIN: (Email) User created with Firebase")
                        }
                    })
                }
            })
        }
    }

}

