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
import Alamofire

class SignUp: UIViewController {
    
    var ref: FIRDatabaseReference!
    
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
    }
    
    
    //Sign the User Up
    @IBAction func SignUpButton(_ sender: AnyObject) {

        
        FIRAuth.auth()?.createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let user = user {
            
                let userInfo: [String : Any] = ["uid" : user.uid,
                                            "username" : self.username.text!]
            
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
