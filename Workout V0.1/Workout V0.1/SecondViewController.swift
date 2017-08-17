//
//  SecondViewController.swift
//  Workout V0.1
//
//  Created by Jeff on 25/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    
    @IBOutlet weak var recordsTableView: UITableView!

    var series:[NSManagedObject]?

    
    //--------------------  Properties: interface
    let cellReuseIdentifier = "cellRecords"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recordsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        recordsTableView.delegate = self
        recordsTableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Series")
        
        
        do {
            series = try managedContext.fetch(fetchRequest)
            
            
            print("Whats the deal?")

        
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        recordsTableView.reloadData()

    }
    

    //--------------------  TableView protocole : number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(series == nil){
                return 0
        }else
        {
        return series!.count;
        }
    }
    
    
    //--------------------  TableView protocole : Uicell pattern
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cell identifier
        let cellReuseIdentifier = "cellRecords"
        var ee="ee"
        // Cell instanciation
        var cell = recordsTableView.dequeueReusableCell(withIdentifier : cellReuseIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.value1  ,reuseIdentifier: cellReuseIdentifier)
        }
        
         
        
        // Database Fetch data
        if(series == nil){
            print("series is nil")
        }else
        {
            let looper:[NSManagedObject] = series!
            
             ee=""
                let i = looper[indexPath.row]
                let s1  = i.value(forKey: "s1") as! NSNumber!
                let s2  = i.value(forKey: "s2") as! NSNumber!
                let s3  = i.value(forKey: "s3") as! NSNumber!
                let s4  = i.value(forKey: "s4") as! NSNumber!
                let s5  = i.value(forKey: "s5") as! NSNumber!
            
                ee = ee + "\(s1!);" + "\(s2!); " + "\(s3!); " + "\(s4!); " + "\(s5!); "
        
        }
    
        // Cell creation : text
        cell?.textLabel?.text=ee
        cell?.detailTextLabel?.text = "date"

        
        
        // Cell return
        return cell!;
    }
    
    
}


