//
//  ViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 3/9/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var txfUsuario: UITextField!
    @IBOutlet var txfContraseña: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doLogin(sender: UIButton) {
        
        if txfUsuario.text == "socio" {
            
            performSegueWithIdentifier("SocioSegue", sender: self)
            
        } else if txfUsuario.text == "admin" {
            
            performSegueWithIdentifier("AdminSegue", sender: self)
            
        } else if txfUsuario.text == "staff" {
            
            performSegueWithIdentifier("StaffSegue", sender: self)
            
        }
    }
    
    @IBAction func unwindLogOut(unwindSegue: UIStoryboardSegue) {
        
    }

}

