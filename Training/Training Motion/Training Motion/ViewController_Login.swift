//
//  ViewController_Login.swift
//  Training Motion
//
//  Created by Jeff on 05/08/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ViewController_Login: UIViewController ,UITextFieldDelegate{

    @IBOutlet weak var userEmail: UITextField!
    
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool {
      textField.returnKeyType = UIReturnKeyType.done
        textField.resignFirstResponder()  //if desired
       //   self.view.endEditing(true)
        return true
    }
    
    
    @IBAction func connect(_ sender: UIButton) {
        
        performSegue(withIdentifier: "segueLogin", sender: self)
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let myVC = segue.destination as! ViewController
        if(userEmail.text! == "")
        {
        userEmail.text!="Defaut user"
        }
        myVC.user = userEmail.text!
        
    }
    
    
    override func viewDidLoad() {

       super.viewDidLoad()
        
        userEmail.delegate = self

    
        
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
