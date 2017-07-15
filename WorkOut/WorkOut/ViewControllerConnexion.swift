//
//  ViewControllerConnexion.swift
//  WorkOut
//
//  Created by Jeff on 14/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerConnexion: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var people:[NSManagedObject]?
    
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            people = try managedContext.fetch(fetchRequest)
            let looper:[NSManagedObject] = people!
            
            var ee:String=""
            for i in looper {
            ee=ee+" "+(i.value(forKeyPath: "name") as? String)!
            
            }
            lastSign.text=ee
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    
    @IBOutlet weak var omtext: UITextField!

    @IBOutlet weak var lastSign: UITextView!
    
    
    @IBAction func connect(_ sender: Any) {
        
    }
    
    @IBAction func signin(_ sender: Any) {
        
        let user=User(context: context)
        user.name=omtext.text!
        user.id=14
        
     (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
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
