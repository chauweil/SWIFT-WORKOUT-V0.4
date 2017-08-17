//
//  ThirdViewController.swift
//  Workout V0.1
//
//  Created by Jeff on 25/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func serverSend(_ sender: UIButton) {
        

        fetchSendData() 
        
    }
    
@IBOutlet weak var tableAPI: UITableView!
    private let refreshControl = UIRefreshControl()
    

    
    var serieAPI = [Int: Int]()

    
    func fetchSendData() {
        let url = URL(string: "http://137.74.168.147/add?id=1&name=Jeff")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
       // let postString = "?id=1&name=Jeff"
      //  request.httpBody = postString.data(using: .utf8)

        print(request.httpBody)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil
            {print("error")}
            else{
                if let content = data {
                    do {
                        let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!
                        
                        
                        print(myjson)
                        
                        
                        
                        
                    }
                    catch{print("bug")}
                    
                }
                
            }}
        task.resume()
        
        
        
        
        refreshControl.endRefreshing()
    }
    
    
     func fetchWeatherData() {
        let url = URL(string: "http://137.74.168.147/")
        let task=URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
            {print("error")}
            else{
                if let content = data {
                    do {
                        let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!
                        
                        
                        print(myjson)
                        let serie = myjson as! NSDictionary
                        
                        self.serieAPI[0] = (serie.value(forKey:"serie1") as! Int)
                        self.serieAPI[1] = (serie.value(forKey:"serie2") as! Int)
                        self.serieAPI[2] = (serie.value(forKey:"serie3") as! Int)
                        self.serieAPI[3] = (serie.value(forKey:"serie4") as! Int)
                        self.serieAPI[4] = (serie.value(forKey:"serie5") as! Int)
                        
                        
                        //  print(serie)
                        //   self.serieAPI!.append(String(myjson["serie1"]))
                        //     self.serieAPI.append(serie)
                        print("append done")
                        
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                        
                        //Database save
                        let DBseries=Series(context: context)
                        DBseries.s1=Int16( self.serieAPI[0]!)
                        DBseries.s2=Int16( self.serieAPI[1]!)
                        DBseries.s3=Int16( self.serieAPI[2]!)
                        DBseries.s4=Int16( self.serieAPI[3]!)
                        DBseries.s5=Int16( self.serieAPI[4]!)
                        DBseries.id=Int16(1)
                        
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        DispatchQueue.main.async() {
                            self.tableAPI.reloadData()
                        }
                        
                        
                    }
                    catch{print("bug")}
                    
                }
                
            }
        }
        task.resume()
        refreshControl.endRefreshing()
                            }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableAPI.register(UITableViewCell.self, forCellReuseIdentifier: "cellAPI")
        tableAPI.delegate = self
        tableAPI.dataSource = self
        self.tableAPI.refreshControl = refreshControl

        refreshControl.addTarget(self, action: #selector(fetchWeatherData), for: UIControlEvents.valueChanged)

        // Do any additional setup after loading the view.
        
        
        let url = URL(string: "http://137.74.168.147/")
        let task=URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil
                {print("error")}
            else{
                if let content = data {
                    do {
                    let myjson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject!
                        
                        
                        print(myjson)
                        let serie = myjson as! NSDictionary
                        
                        self.serieAPI[0] = (serie.value(forKey:"serie1") as! Int)
                        self.serieAPI[1] = (serie.value(forKey:"serie2") as! Int)
                        self.serieAPI[2] = (serie.value(forKey:"serie3") as! Int)
                        self.serieAPI[3] = (serie.value(forKey:"serie4") as! Int)
                        self.serieAPI[4] = (serie.value(forKey:"serie5") as! Int)
                    
                        
                      //  print(serie)
                     //   self.serieAPI!.append(String(myjson["serie1"]))
                   //     self.serieAPI.append(serie)
                        print("append done")
                        
                        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

                        //Database save
                        let DBseries=Series(context: context)
                        DBseries.s1=Int16( self.serieAPI[0]!)
                        DBseries.s2=Int16( self.serieAPI[1]!)
                        DBseries.s3=Int16( self.serieAPI[2]!)
                        DBseries.s4=Int16( self.serieAPI[3]!)
                        DBseries.s5=Int16( self.serieAPI[4]!)
                        DBseries.id=Int16(1)
                        
                        
                        (UIApplication.shared.delegate as! AppDelegate).saveContext()
                        
                        DispatchQueue.main.async() {
                            self.tableAPI.reloadData()
                        }

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieAPI.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableAPI.dequeueReusableCell(withIdentifier: "cellAPI", for: indexPath) as? UITableViewCell
        
        if(cell == nil)
        {
            print("crée les cellsvide ")
            cell = UITableViewCell(style : .default,reuseIdentifier: "cellAPI")
        }else{
            
            
             var output : Int = self.serieAPI[indexPath.row]!
             var output2 = String(output)
            print(output2)
            cell!.textLabel!.text = output2
        }
        
        
        return(cell!)
    }

}
