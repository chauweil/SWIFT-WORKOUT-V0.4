//
//  LastSaveViewController.swift
//  WorkOut
//
//  Created by Jeff on 16/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreData

class LastSaveViewController: UIViewController {

    
    var series:[NSManagedObject]?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
            let looper:[NSManagedObject] = series!
            
            var ee:String=" "
            for i in looper {
                let e  = i.value(forKey: "rep1") as! NSNumber!
                ee = ee + "\(e!)"

               /* ee=ee + "User: ??" + "rep 1: "+(i.value(forKeyPath: "rep1") as? String)!+"rep 2: "+(i.value(forKeyPath: "rep2") as? String)!+"rep 3: "+(i.value(forKeyPath: "rep3") as? String)!
                ee=ee + "User: ??" + "rep 1: "+(i.value(forKeyPath: "rep1") as? String)!*/
            }
            lastPerf.text=ee
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    @IBOutlet weak var lastPerf: UITextView!
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
