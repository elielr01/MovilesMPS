//
//  AdminProyectosViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 3/9/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class AdminProyectosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var proyectosTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        proyectosTableView.reloadData()
        proyectosTableView.dataSource = self
        proyectosTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("proyectoCell")
        
        cell?.textLabel?.text = "Proyecto TI Impulsa"
        
        return cell!
    }
    

}
