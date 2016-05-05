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
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var btnIniciarSesion: UIButton!
    
    var staff : StaffUser!
    var admin : AdminUser!
    var socio : SocioformadorUser!
    
    var bAlert : Bool!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.backgroundView.layer.cornerRadius = 14
        self.btnIniciarSesion.layer.cornerRadius = 8
        
        bAlert = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindLogOut(unwindSegue: UIStoryboardSegue) {
        txfUsuario.text = ""
        txfContraseña.text = ""
    }
    
    @IBAction func iniciarSesion(sender: UIButton) {
        
        self.tryLoginStaff()
        self.tryLoginAdmin()
        self.tryLoginSocio()
    }
    
    func tryLoginStaff() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginStaff.php")!)
        request.HTTPMethod = "POST"
        
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            //If doesn't return, it means that theres data.
            /*
             let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                if (responseString != "-1") {
                    //JSON is good so far, so it's time to parse
                    self.bAlert=true
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.staff = StaffUser.init()
                    
                    self.staff.contra = user.valueForKey("contra") as! String
                    self.staff.id_staff = user.valueForKey("id_staff") as! String
                    self.staff.nombre = user.valueForKey("nombre") as! String
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("StaffSegue", sender: self)
                    }
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    func tryLoginAdmin() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginAdmin.php")!)
        request.HTTPMethod = "POST"
        
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            //If doesn't return, it means that theres data.
            /*
             let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                if (responseString != "-1") {
                    //JSON is good so far, so it's time to parse
                    self.bAlert = true
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.admin = AdminUser.init()
                    
                    self.admin.contra = user.valueForKey("contra") as! String
                    self.admin.id_admin = user.valueForKey("id_admin") as! String
                    self.admin.nombre = user.valueForKey("nombre") as! String
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("AdminSegue", sender: self)
                    }
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    func tryLoginSocio() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginSocio.php")!)
        request.HTTPMethod = "POST"
        
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            //If doesn't return, it means that theres data.
            /*
             let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                if (responseString != "-1") {
                    //JSON is good so far, so it's time to parse
                    self.bAlert = true
                    
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.socio = SocioformadorUser.init()
                    
                    self.socio.contra = user.valueForKey("contra") as! String
                    self.socio.id_socioformador = user.valueForKey("id_socioformador") as! String
                    self.socio.nombre = user.valueForKey("nombre") as! String
                    self.socio.id_proyecto_coordina = Int.init(user.valueForKey("id_proyecto_coordina") as! String)
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("SocioSegue", sender: self)
                    }
                }
                else {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.showAlert()
                    }
                    
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    func showAlert() {
        
        if (!bAlert!) {
            
            let alert = UIAlertController(title: "Error al iniciar sesión", message: "El usuario o contraseña no son correctos. Vuelva a intentarlo, por favor", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.dismissKeyboard()
        
        if segue.identifier == "StaffSegue" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let view = nav.topViewController as! StaffListaProyectosViewController
            view.staff = self.staff
            
        } else if segue.identifier == "AdminSegue" {
            
            let nav = segue.destinationViewController as! UINavigationController
            let view = nav.topViewController as! AdminProyectosViewController
            view.admin = self.admin
            
        } else if segue.identifier == "SocioSegue" {
            
            let view = segue.destinationViewController as! SocioTabBarViewController
            view.socio = self.socio
            
        }
        

    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    

}

