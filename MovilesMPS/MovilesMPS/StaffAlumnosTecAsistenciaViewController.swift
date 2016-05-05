//
//  StaffAlumnosTecAsistenciaViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 4/13/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class StaffAlumnosTecAsistenciaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var arrstrNames : [String]!
    var arrboolAsistencias : [Bool]!

    @IBOutlet var alumnoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.alumnoTableView.delegate = self
        self.alumnoTableView.dataSource = self
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
        
        let view = segue.destinationViewController as! StaffAlumnosTecViewController
        view.arrboolAsistencias = self.arrboolAsistencias
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrstrNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alumnoCell") as! AlumnoTableViewCell
        
        cell.lbNombreAlumno.text = arrstrNames[indexPath.row]
        cell.swtAsistencia.on = arrboolAsistencias[indexPath.row]
        cell.swtAsistencia.enabled = true
        cell.swtAsistencia.tag = indexPath.row
        
        
        
        return cell
    }
    
    //Se toma asistencia de los alumnos Socioformadores
    @IBAction func cambioAsistencia(sender: UISwitch) {
        arrboolAsistencias[sender.tag] = sender.on
    }

}
