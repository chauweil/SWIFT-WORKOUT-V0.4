//
//  ViewController.swift
//  Training_CustomCell
//
//  Created by Jeff on 30/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var tableUsual: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let myIdentifier="myIdentifier"
      //  tableUsual.register(UINib(nibName: "CustomCeller", bundle: nil), forCellReuseIdentifier: "myIdentifier")

        
        let nib = UINib(nibName: "CustomCeller", bundle: nil)
        tableUsual.register(nib, forCellReuseIdentifier: "myIdentifier")
        
        tableUsual.dataSource = self
        tableUsual.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellReuseIdentifier = "myIdentifier"

      //  let myCell:CustomCeller? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CustomCeller
        let myCell:CustomCeller? = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? CustomCeller

        
        myCell!.lab1.text = "Row \(indexPath.row)"
        myCell!.lab2.text = "String \(indexPath.row)"
        return myCell!
    }

}

