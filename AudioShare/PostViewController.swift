//
//  PostViewController.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/27/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostViewController: UIViewController {

    
    @IBOutlet weak var songText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    
    @IBAction func submitPost(_ sender: Any) {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()
        let key = ref.child("posts").childByAutoId().key
        let postid = ref.child("posts").childByAutoId().key
        
        
        
        

        let feed = ["userID": uid,
                    "postID": postid,
                    "author": FIRAuth.auth()?.currentUser?.displayName,
                    "likes": 0,
                    "song": songText.text!,
                    "artist": artistText.text!] as [String:Any]
        
        
        
        
        let postFeed = ["\(key)" : feed]
        
        
        ref.child("posts").updateChildValues(postFeed)
        
        print("New post was made. " + songText.text! +  " by " + artistText.text!)
        
        
        //Notification
        //segue to feed view controller
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
