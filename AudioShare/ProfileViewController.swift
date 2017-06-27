//
//  ProfileViewController.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/27/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var numberPosts: UILabel!
    
    @IBOutlet weak var numFollowers: UILabel!
    
    @IBOutlet weak var numFollowing: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.numFollowers.text = "215"
        self.numFollowing.text = "179"
        self.numberPosts.text = "21"
        
        let username = FIRAuth.auth()?.currentUser?.displayName
        
        usernameLabel.text = username
        
        
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
