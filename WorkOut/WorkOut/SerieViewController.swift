//
//  SerieViewController.swift
//  WorkOut
//
//  Created by Jeff on 15/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class SerieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text3: UITextField!
    @IBOutlet weak var text4: UITextField!
    @IBOutlet weak var text5: UITextField!
    @IBOutlet weak var text6: UITextField!
    
    
    
    @IBAction func Serie1(_ sender: UIStepper) {
        text1.text = String(sender.value)

    }
    
    @IBAction func Serie2(_ sender: UIStepper) {
        text2.text = String(sender.value)

    }
    
    
    @IBAction func Serie3(_ sender: UIStepper) {
        text3.text = String(sender.value)

    }
    
    
    
    @IBAction func Serie4(_ sender: UIStepper) {
        text4.text = String(sender.value)

    }
    
    
    @IBAction func Serie5(_ sender: UIStepper) {
        text5.text = String(sender.value)

    }
    @IBAction func Serie6(_ sender: UIStepper) {
        text6.text = String(sender.value)

    }
    
    
    
    @IBAction func saveSeries(_ sender: UIButton) {
        
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let serie=Series(context: context)
        
    
        
        let user=User(context: context)
        user.name="jeff"
        user.id=14
        
    serie.rep1 = Double(text1.text!)!
    serie.rep2 = Double(text2.text!)!
    serie.rep3 = Double(text3.text!)!
    serie.rep4 = Double(text4.text!)!
    serie.rep5 = Double(text5.text!)!
    serie.rep6 = Double(text6.text!)!
    serie.date = NSDate()
    serie.user=user
        
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
