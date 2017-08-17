//
//  FirstViewController.swift
//  Workout V0.1
//
//  Created by Jeff on 25/07/2017.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //---------------------- Outlet & action definition
    
    @IBOutlet weak var currentValue: UILabel!
    
    @IBOutlet weak var TableSerie: UITableView!
    
    @IBOutlet weak var ObjectiveLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    
    @IBOutlet weak var saveText: UIButton!
    //--------------------  Properties: model

    var currentRow : Int?
    var items = ["1","2","3","4","5"]
    var series = [0,0,0,0,0]
    var objectives = [29,32,35,29,20]
    var Value : Int = 29
    var time = 91
    var timer = Timer()

    //--------------------  Properties: Core data model
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //---------------------- Outlet & action definition: save
    @IBAction func save(_ sender: UIButton) {
        

    if(currentRow == nil)
    {
    
    }else{
        time=91
        
        self.series[currentRow!] = Int(currentValue.text!)!
        self.TableSerie.reloadData()
        
        if(currentRow==4){
            
            
            // Update title
            sender.setTitle("FINISHED AND SAVE", for:.normal)

            
            //Series update
            let indexPath = IndexPath(row: currentRow!, section: 0)
            TableSerie.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            TableSerie.delegate?.tableView!(TableSerie, didSelectRowAt: indexPath)
            
            //
            
            //Database save
            let DBseries=Series(context: context)
            DBseries.s1=Int16(self.series[0])
            DBseries.s2=Int16(self.series[1])
            DBseries.s3=Int16(self.series[2])
            DBseries.s4=Int16(self.series[3])
            DBseries.s5=Int16(self.series[4])
            DBseries.id=Int16(1)

            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
        }
        
        if(currentRow!<4){
            
            sender.setTitle("CONTINUE AND REST", for:.normal)

            
        // Series update
        let indexPath = IndexPath(row: currentRow!+1, section: 0)
        TableSerie.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        TableSerie.delegate?.tableView!(TableSerie, didSelectRowAt: indexPath)

        // Objective update
            print(String(currentRow!+1))
         ObjectiveLabel.text=String(self.objectives[currentRow!])
            
            
        // Time update
            timer.invalidate()
            timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabelTimer), userInfo: nil, repeats: true)
            
            
            
        
        }

        }
        
    }
    
    
    @IBAction func Plus(_ sender: UIButton) {
        Value = Int(currentValue.text!)!
        Value=Value+1
        currentValue.text = String(Value)
        if(currentRow == nil){}else
        {self.series[currentRow!]=Value}
        self.TableSerie.reloadData()

    }
    
    @IBAction func Minus(_ sender: Any) {
        
        Value = Int(currentValue.text!)!
        if(Value>0){Value=Value-1}else{Value=0}
        currentValue.text = String(Value)
        if(currentRow == nil){}else
        {self.series[currentRow!]=Value}
        self.TableSerie.reloadData()

    }
    

    func updateLabelTimer()
    {
        if(time==0){
        TimeLabel.text=String(90)
        timer.invalidate()

            
        }else{
    time=time-1
    TimeLabel.text=String(time)
        }
    }
    //--------------------  Properties: interface
    let cellReuseIdentifier = "cellReuseIdentifier"
    
    //--------------------  Methods override
    override func viewDidLoad() {
        super.viewDidLoad()

        currentValue.text = String(Value)
        
        
        let nib = UINib(nibName: "customCell", bundle: nil)
        self.TableSerie.register(nib, forCellReuseIdentifier: "cellReuseIdentifier")
     
        
      //  self.TableSerie.register(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        TableSerie.delegate = self
        TableSerie.dataSource = self
        
        let indexPath = IndexPath(row: 0, section: 0)
        TableSerie.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        TableSerie.delegate?.tableView!(TableSerie, didSelectRowAt: indexPath)
        
        
        self.TableSerie.rowHeight=60
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //--------------------  TableView protocole : number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count;
    }
    //--------------------  TableView protocole : Uicell pattern
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Cell identifier
        let cellReuseIdentifier = "cellReuseIdentifier"

        // Cell instanciation
        var cell : customCell! = TableSerie.dequeueReusableCell(withIdentifier : cellReuseIdentifier) as? customCell
        if (cell == nil) {
            cell = customCell(style: .default  ,reuseIdentifier: cellReuseIdentifier)
        }

        // Cell creation: image
          let imageWin = UIImage(named: "002-interface")
          let imageLoss = UIImage(named: "001-error")

        // cell?.imageView?.image = image
        
     //   let highlightedImage = UIImage(named: "abs")
   //     cell?.imageView?.highlightedImage = highlightedImage
        
        
        if(self.series[indexPath.row]>self.objectives[indexPath.row])
        {
        cell.imageObj.image = imageWin
        }else{cell.imageObj.image=imageLoss}
        
        // Cell creation : text
        cell.serieValue.text=String(self.series[indexPath.row])
        cell.serieObj.text = String(self.objectives[indexPath.row])
        cell.serieNum.text=self.items[indexPath.row]
        cell.serieMean.text=String(self.series[indexPath.row]-1)
        
//        cell?.textLabel?.textColor=UIColor(red:0.43, green:0.83, blue:0.81, alpha:1.0)
 //       cell?.detailTextLabel?.textColor = UIColor(red:0.43, green:0.83, blue:0.81, alpha:1.0)

        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(white: 1, alpha: 0.2)
        cell!.selectedBackgroundView = backgroundView
        
        // Cell creation : style
        cell!.backgroundColor = UIColor(white: 1, alpha: 0)
        

        // Cell return
        return cell!;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Update current row & Objective label
        currentRow=indexPath.row
    

        // Objective update
        ObjectiveLabel.text=String(self.objectives[currentRow!])
        
        if(indexPath.row<4){
            saveText.setTitle("Continue and rest", for:.normal)

        }else{
            saveText.setTitle("Finished and save", for:.normal)

        }
        
        
        
    }
    

    

    
    
}

