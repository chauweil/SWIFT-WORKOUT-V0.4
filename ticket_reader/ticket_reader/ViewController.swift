//
//  ViewController.swift
//  ticket_reader
//
//  Created by Jeff on 24/12/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func getdata(_ sender: Any) {
        
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        //getAPI()
        sentAPI()


        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    func getAPI() {
        
        // set the url to be queried
        let url = URL(string: "http://vps447991.ovh.net:5000/im")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        // Foundation > URL loading system > URLSession 
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil
            {print("error")}
            else{
                if let content = data {
                    do {
                        let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!
                        
                        let serie = myjson as! NSDictionary
                        let ee:String = serie.value(forKey:"im") as! String
                        let dataDecoded : Data = Data(base64Encoded: ee, options: .ignoreUnknownCharacters)!
                        let decodedimage = UIImage(data: dataDecoded)
                        self.imageTake.image  = decodedimage
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    }
                    catch{print("bug")}
                    
                }
                
            }
        }
        task.resume()
        print("done")
  
    }
    
    func sentAPI() {
        
        // set the url to be queried
        let url = URL(string: "http://vps447991.ovh.net:5000/q")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        
        // Foundation > URL loading system > URLSession
        let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil
            {print("error")}
            else{
                if let content = data {
                    do {
                       let image    = UIImage(named: ("IMG_3498"))
                        let imageData:NSData = UIImagePNGRepresentation(image!)! as NSData
                       let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                        let json=["image":strBase64]
                        request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) //
                        
                        self.activityIndicator.stopAnimating()
                        UIApplication.shared.endIgnoringInteractionEvents()
                        
                    }
                    catch{print("bug")}
                    
                }
                
            }
        }
        task.resume()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageTake.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        
        present(ac, animated: true)
        
        var imageToSave: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        UIImageWriteToSavedPhotosAlbum(imageToSave,nil,nil,nil)


    }
/*
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }*/


}

