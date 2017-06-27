//
//  SignUp.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/21/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import Alamofire

class SignUp: UIViewController {
    
    var ref: FIRDatabaseReference!
    //var userStorage: FIRStorageReference!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
       //let storage = FIRStorage.storage().reference(forURL: "gs://audioshare-k24.com")
        //userStorage = storage.child("users")
        
    }
    
    
    //Sign the User Up
    @IBAction func SignUpButton(_ sender: AnyObject) {

        
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            let followers = [String]()
            let following = [String]()
            if let user = user {
                let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                changeRequest?.displayName = self.username.text
                changeRequest?.commitChanges(completion: nil
                )
                let userInfo: [String : Any] = ["uid" : user.uid,
                                            "username" : self.username.text!,
                                            "followers": followers,
                                            "following": following]
            
                self.ref.child("users").child(user.uid).setValue(userInfo)
            }
        })
        print("username: " + self.username.text! + " was created")

    }
    
    
    //Log the user in
    @IBAction func LogInButton(_ sender: AnyObject) {
        
        
        FIRAuth.auth()?.signIn(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if(error == nil) {
                print(self.email.text! + " logged in successfully!")
            } else {
                print(error.debugDescription)
                
            }
        })
        
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
