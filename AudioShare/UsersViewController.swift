//
//  PostViewController.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/21/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import FirebaseDatabase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    


    
    var user = [User]()
    @IBOutlet weak var tableview: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveUsers()
    }
    
    
    func retrieveUsers() {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            let users = snapshot.value as! [String: AnyObject]
            self.user.removeAll()
            for(_, value) in users {
                if let uid = value["uid"] as? String {
                    if uid != FIRAuth.auth()?.currentUser!.uid {
                        //var userToShow = User(username: self.usernameField.text)
                        let userToShow = User()
                        if let usernameVal = value["username"] as? String {
                        
                            userToShow.username = usernameVal
                            userToShow.userID = uid
                            self.user.append(userToShow)
                        }
                    }
                }
            }
            self.tableview.reloadData()
        })
        ref.removeAllObservers()
    }
    
    
    

    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        
        cell.usernameField.text = self.user[indexPath.row].username
        
        checkFollowing(indexPath: indexPath)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let uid = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let key = ref.child("users").childByAutoId().key
        
        var isFollower = false
        
        ref.child("users").child(uid).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            
            
            if let following = snapshot.value as? [String: AnyObject] {
                for(key, value) in following {
                    if value as! String == self.user[indexPath.row].username {
                        isFollower = true
                        
                        ref.child("users").child(uid).child("following/\(key)").removeValue()
                        ref.child("users").child(self.user[indexPath.row].username).child("followers/\(key)").removeValue()
                        
                        self.tableview.cellForRow(at: indexPath)?.accessoryType = .none
                    }
                }
            }
            
            if !isFollower {
                let following = ["following/\(key)" : self.user[indexPath.row].username]
                let followers = ["followers/\(key)" : uid]
                
                ref.child("users").child(uid).updateChildValues(following)
                ref.child("users").child(self.user[indexPath.row].username).updateChildValues(followers)
                
                self.tableview.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
            
        })
        ref.removeAllObservers()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("User count is ")
        print(user.count)
        return user.count
    }
    
    
    func checkFollowing(indexPath: IndexPath) {
        let uid = FIRAuth.auth()?.currentUser?.uid
        let ref = FIRDatabase.database().reference()

        ref.child("users").child(uid!).child("following").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in

            if let following = snapshot.value as? [String: AnyObject] {
                
                for(_, value) in following {
                    if value as? String == self.user[indexPath.row].username {
                        self.tableview.cellForRow(at: indexPath)?.accessoryType = .checkmark
                    }
                }
            }
            
            
        })
        ref.removeAllObservers()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //    func DownloadGoogle() {
    //
    //        Alamofire.request("http://www.google.com", method: .get).responseString { (AlamofireResponse) in
    //            print(AlamofireResponse.result.value!)
    //        }
    //
    //    }
    

}
