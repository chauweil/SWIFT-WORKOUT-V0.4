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
    }
    
    
    @IBAction func Serie3(_ sender: UIStepper) {
    }
    
    
    
    @IBAction func Serie4(_ sender: UIStepper) {
    }
    
    
    
    @IBAction func Serie5(_ sender: UIStepper) {
    }
    @IBAction func Serie6(_ sender: UIStepper) {
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
