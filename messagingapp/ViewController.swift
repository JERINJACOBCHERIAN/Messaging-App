//
//  ViewController.swift
//  messagingapp
//
//  Created by JERIN JACOB CHERIAN on 23/04/17.
//  Copyright © 2017 JERIN JACOB CHERIAN. All rights reserved.

import UIKit
import FirebaseDatabase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var postData=[String]()
    var ref:FIRDatabaseReference?
    var databaseHandle:FIRDatabaseHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
        //setup database reference
        ref=FIRDatabase.database().reference()
        
        //retrieve posts and listen for changes
        // Do any additional setup after loading the view, typically from a nib.
        databaseHandle=ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost=post{
                self.postData.append(actualPost)
                //reload view
                self.tableView.reloadData()
        }
    
    })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "postCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }


}

