//
//  ViewController.swift
//  ticket_reader
//
//  Created by Jeff on 24/12/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreImage
import Alamofire
import AlamofireImage

class ViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate  {
    
// ------------------------------------ Constructor ---------------------------------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
// ------------------------------------  Attributes  ---------------------------------------------------
    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!

    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    
// ------------------------------------  Actions  ---------------------------------------------------

    
    @IBAction func getdata(_ sender: Any) {
        
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        //getAPI()
        getImage()


        
    }
    
    @IBAction func sendData(_ sender: Any) {
        activityIndicator.center=self.view.center
        activityIndicator.hidesWhenStopped=true
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        //getAPI()
        sentImage()

    }


    @IBAction func takePhoto(_ sender: UIButton) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
// ------------------------------------  Functions  ---------------------------------------------------
    

    func getImage() {
                
        Alamofire.request("http://vps447991.ovh.net:5000/image").responseImage { response in
            if let image = response.result.value {
                print("image downloaded: \(image)")
                self.imageTake.image  = image
            }
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
        }
    }

    func sentImage() {
        
        let image = UIImage.init(named: "BIG1")
        let imgData = UIImageJPEGRepresentation(image!, 0.8)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpeg")
                                                                    },to:"http://vps447991.ovh.net:5000/upload")
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    print("e??")
                    let data = response.result.value as! NSDictionary
                    print(data)
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
            }
    }
        self.activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
        
        
        
        
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


    /*
    func sentAPI() {
        

         set the url to be queried
         print("1")
         let url = URL(string: "http://vps447991.ovh.net:5000/q")
         var request = URLRequest(url: url!)
         request.httpMethod = "POST"
         print("2")
         let image    = UIImage(named: ("download"))
         let imageData:NSData = UIImagePNGRepresentation(image!)! as NSData
         print("3")
         let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
         print("4")
         //let json = ["image":strBase64]
         print("5")
         request.httpBody =  strBase64.data(using: .utf8)
         print(request.httpBody! )
         // Foundation > URL loading system > URLSession
         let task=URLSession.shared.dataTask(with: request) { (data, response, error) in
         if error != nil
         {print("error")}
         else{
         self.activityIndicator.stopAnimating()
         UIApplication.shared.endIgnoringInteractionEvents()
         
         
         }
         }
         task.resume()
         print("endtask")
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
     
    */
}

