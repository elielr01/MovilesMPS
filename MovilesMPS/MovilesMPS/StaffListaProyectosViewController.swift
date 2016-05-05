//
//  AdminProyectosViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 3/9/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class StaffListaProyectosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //Outlets
    @IBOutlet var proyectosTableView: UITableView!
    @IBOutlet var btnCerrarSesion: UIButton!
    
    var staff : StaffUser = StaffUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        proyectosTableView.dataSource = self
        proyectosTableView.delegate = self
        proyectosTableView.reloadData()

        btnCerrarSesion.layer.cornerRadius = 12

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        if segue.identifier == "staffSegue" {
            let view = segue.destinationViewController as! StaffProyectTabBarViewController
            
            //Le agrego el nombre del proyecto al título de la vista destino
            view.strNombreProyecto = (self.proyectosTableView.cellForRowAtIndexPath(self.proyectosTableView.indexPathForSelectedRow!))?.textLabel?.text
        }

     }
 
    // MARK: - TableViewController Methods
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("proyectoCell")
        
        cell?.textLabel?.text = "Proyecto TI Impulsa"
        
        return cell!
    }
    
    
}
