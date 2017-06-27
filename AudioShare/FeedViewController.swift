//
//  FeedViewController.swift
//  AudioShare
//
//  Created by Kedar Pujara on 6/27/17.
//  Copyright © 2017 kpujara. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase

class FeedViewController: UITableViewController {//, UITableViewDelegate, UITableViewDataSource {

    var posts = [Feed]()
    var following = [String]()
    
//    @IBOutlet weak var numLikes: UILabel!
//    
//    @IBAction func likeButton(_ sender: Any) {
//        
//    }
//    
//    @IBOutlet weak var usernameField: UILabel!
//    
//    
//    @IBOutlet weak var postField: UILabel!
    
    
    @IBOutlet weak var tableview: FeedCell!
    
    
    @IBOutlet weak var feedTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPosts()
        
//        let ref = FIRDatabase.database().reference()
        
//        //ref.child("posts").queryOrderedByKey()
//        
//        let uid = FIRAuth.auth()?.currentUser?.uid
//        
//        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            
//            
//            let value = snapshot.value as? NSDictionary
//            let username = value?["author"] as? String ?? ""
//            let song = value?["song"]
//            let artist = value?["artist"]
//            let likes = value?["likes"]
//        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    func fetchPosts() {
        
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in
            let postsnap = snapshot.value as! [String: AnyObject]
            for(_, post) in postsnap {
                let postObject = Post()
                postObject.artist = post["artist"] as? String
                postObject.likes = post["likes"] as? Int
                postObject.song = post["song"] as? String
                
                
            }
            self.feedTableView.reloadData()
        })
        
        
        /*ref.child("users").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot) in

            let users = snapshot.value as! [String:AnyObject]
            
            for(_, value) in users {
                if let uid = value["uid"] as? String {
                    if uid == FIRAuth.auth()?.currentUser?.uid {
                        if let followingUsers = value["following"] as? [String : String] {
                            for(_,user) in followingUsers {
                                self.following.append(user)
                            }
                            
                        }
                        
                        self.following.append((FIRAuth.auth()?.currentUser?.uid)!) //follow yourself too
                        
                        ref.child("posts").queryOrderedByKey().observeSingleEvent(of: .value, with: { (snapshot2) in
                            
                            let postsSnap = snapshot2.value as! [String: AnyObject]
                            
                            for(_, post) in postsSnap {
                                if let userID = post["userID"] as? String {
                                    
                                    for each in self.following {
                                        if each == userID {
                                            let postObject = Post()
                                            if let username = post["author"] as? String,
                                            let song = post["song"] as? String,
                                            let artist = post["artist"] as? String,
                                            let likes = post["likes"] as? Int,
                                            let postid = post["postID"] as? String
                                            {
                                                
                                                postObject.author = username
                                                postObject.likes = likes
                                                postObject.postID = postid
                                                postObject.userID = userID
                                                postObject.song = song
                                                postObject.artist = artist
                                                
                                                if let people = post["peopleWhoLike"] as? [String: AnyObject] {
                                                    for(_, person) in people {
                                                        postObject.peopleWhoLike.append(person as! String)
                                                    }
                                                }
                                                
                                                self.posts.append(postObject)
                                            
                                            }
                                        }
                                    }
                                    
                                    self.tableview.reloadInputViews()
                                }
                            }
                            
                            
                            
                        })
                        
                    }
                    
                }
                
            }
            
        }) //End of query
        ref.removeAllObservers()*/
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    /*
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        
        cell.authorLabel.text = self.posts[indexPath.row].author
        cell.likesLabel.text = self.posts[indexPath.row].likes as? String
        cell.postLabel.text = self.posts[indexPath.row].song + " by " + self.posts[indexPath.row].artist
        

        return cell as? UICollectionView
    }
    */

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.posts.count
    }
 
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
       
        
        //cell.authorLabel.text = self.posts[indexPath.row].author
        cell.likesLabel.text = self.posts[indexPath.row].likes as? String
        cell.postLabel.text = self.posts[indexPath.row].song + " by " + self.posts[indexPath.row].artist
        
     
        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
