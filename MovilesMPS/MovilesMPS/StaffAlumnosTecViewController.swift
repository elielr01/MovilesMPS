//
//  StaffAlumnosTecViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 3/9/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class StaffAlumnosTecViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var arrstrNames : [String]!
    var arrboolAsistencias : [Bool]!
    

    @IBOutlet var alumnosTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        
        arrstrNames = ["César Armando Galván", "Ángel González Galván", "Melisa Alejandra González Aguirre", "María de Nicole Paulina Barbosa Ramírez"]
        
        arrboolAsistencias = [Bool](count: arrstrNames.count, repeatedValue: false)
        
        alumnosTableView.delegate = self
        alumnosTableView.dataSource = self
        alumnosTableView.tableHeaderView = UIView.init(frame: CGRectMake(0.0, 0.0, alumnosTableView.bounds.size.width, 0.01))
        
        
        
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
        
        let view = segue.destinationViewController as! StaffAlumnosTecAsistenciaViewController
        view.arrstrNames = self.arrstrNames
        view.arrboolAsistencias = self.arrboolAsistencias
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrstrNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alumnoCell") as! AlumnoTableViewCell
        
        cell.lbNombreAlumno.text = arrstrNames[indexPath.row]
        cell.swtAsistencia.on = arrboolAsistencias[indexPath.row]
        cell.swtAsistencia.enabled = false

        return cell
    }
    
    @IBAction func unwindTomarListaAlumnos(unwindSegue: UIStoryboardSegue) {
        
        self.alumnosTableView.reloadData()
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

}
