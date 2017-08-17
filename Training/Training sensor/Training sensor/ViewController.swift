//
//  ViewController.swift
//  Training sensor
//
//  Created by Jeff on 03/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    @IBAction func axtion(_ sender: UIButton) {
        
        label.text! = String(device.proximityState)
        print(device.proximityState)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        device.isProximityMonitoringEnabled=true
        print(device.isProximityMonitoringEnabled)

        print(device.name)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    let device = UIDevice()
    
    
    
    
}

