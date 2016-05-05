//
//  SocioTabBarViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/3/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class SocioTabBarViewController: UITabBarController {
    
    var socio : SocioformadorUser = SocioformadorUser()
    var proyecto : Proyecto = Proyecto()
    var lugar : Lugar = Lugar()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getProject()
        getLugar()
    }
    
    override func viewWillAppear(animated: Bool) {
        getProject()
        getLugar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProject() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/proyectoSocioformador.php")!)
        request.HTTPMethod = "POST"
        
        let strPostBody = "id_socio=\(self.socio.id_socioformador)"
        
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
                    
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.proyecto.descripcion = user.valueForKey("descripcion") as! String
                    self.proyecto.id_proyecto = Int.init(user.valueForKey("id_proyecto") as! String)
                    self.proyecto.nombre = user.valueForKey("nombre") as! String
                    
                    

                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    
    func getLugar() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/lugarSocioformador.php")!)
        request.HTTPMethod = "POST"
        
        let strPostBody = "id_socio=\(self.socio.id_socioformador)"
        
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
                    
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.lugar.id_lugar = Int.init(user.valueForKey("id_lugar") as! String)
                    self.lugar.nombre = user.valueForKey("nombre") as! String
                    self.lugar.direccion = user.valueForKey("direccion") as! String
                    
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
