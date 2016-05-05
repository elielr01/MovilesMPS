//
//  SocioBeneficiariosViewController.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 3/9/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class SocioBeneficiariosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //var arrstrNames : [String]!
    var arrboolAsistencias : [Bool]!
    var arrBeneficiarios : [Beneficiario] = [Beneficiario]()
    
    var proyecto : Proyecto = Proyecto()
    var lugar : Lugar = Lugar()
    var socio : SocioformadorUser = SocioformadorUser()
    
    var sesion = 1

    @IBOutlet var beneficiariosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        beneficiariosTableView.delegate = self
        beneficiariosTableView.dataSource = self
        
        self.proyecto = (self.tabBarController as! SocioTabBarViewController).proyecto
        self.lugar = (self.tabBarController as! SocioTabBarViewController).lugar
        self.socio = (self.tabBarController as! SocioTabBarViewController).socio

        //Información dummy sólo para validar funcionalidad
        //arrstrNames = ["Carlos Gómez Leal", "Sebastián Ríos Cepeda", "José Israel Sandoval Romero", "Andrea de la Torre Tamez", "Rosa Bertha Carmina Romero Lira"]
        //arrboolAsistencias = [Bool](count: arrstrNames.count, repeatedValue: true)
        
        self.getBeneficiariosList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProject() {
        
        //Creo el URL
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/proyectoSocioformador.php")!)
        request.HTTPMethod = "POST"
        
        //Agrego el cuerpo que es necesario para el POST
        let strPostBody = "id_socio=\(self.socio.id_socioformador)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //E inicio sesión.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // verifico errores de red
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           //errores de http
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            
            //Si no regresa, significa que hay NSData lista para serializar
            
            //Esto es usa para ver cómo nos regresa el php el json.
            /*
             let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            //Intento Serializar
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                //Si es -1, significa que sí regresó algo, pero no lo esperado
                if (responseString != "-1") {
                    //Si sí entra aquí, entonces la información está lista para parsearse.
                    
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
        
        //Creo el URL
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/lugarSocioformador.php")!)
        request.HTTPMethod = "POST"
        
        //Agrego el cuerpo que es necesario para el POST
        let strPostBody = "id_socio=\(self.socio.id_socioformador)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //E inicio sesión.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // verifico errores de red
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // errores de http
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
                return
            }
            
            //Si no regresa, significa que hay NSData lista para serializar
            
            //Esto es usa para ver cómo nos regresa el php el json.
            /*
             let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            //Intento Serializar
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                
                //Si es -1, significa que sí regresó algo, pero no lo esperado
                if (responseString != "-1") {
                    //Si sí entra aquí, entonces la información está lista para parsearse.
                    
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
    
    func getBeneficiariosList() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/listaBeneficiarioXProyecto.php")!)
        request.HTTPMethod = "POST"
        
        let strPostBody = "id_proyecto=\(self.proyecto.id_proyecto)"
        
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
            
             /*let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
             print("responseString = \(responseString)")*/
            
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                if (responseString != "-1") {
                    //JSON is good so far, so it's time to parse
                    
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    for beneficiario in jsonArray {
                        
                        let tempBeneficiario = Beneficiario()
                        
                        tempBeneficiario.id_beneficiario = Int.init(beneficiario.valueForKey("id_beneficiario") as! String)
                        tempBeneficiario.nombre = beneficiario.valueForKey("nombre") as! String
                        tempBeneficiario.edad = Int.init(beneficiario.valueForKey("edad") as! String)
                        
                        self.arrBeneficiarios.append(tempBeneficiario)
                    }
                    
                    self.arrboolAsistencias = [Bool](count: self.arrBeneficiarios.count, repeatedValue: true)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.beneficiariosTableView.reloadData()
                        print(self.proyecto.descripcion)
                    }
                }
                
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }
        task.resume()
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let view = segue.destinationViewController as! SocioBeneficiariosAsistenciaViewController
        
        view.arrBeneficiarios = self.arrBeneficiarios
        view.arrboolAsistencias = self.arrboolAsistencias
        
    }
 
    // MARK: - TableViewController Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrBeneficiarios.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("beneficiarioCell") as! BeneficiarioTableViewCell
        
        cell.lbBeneficiarioNombre.text = arrBeneficiarios[indexPath.row].nombre
        cell.swtAsistencia.on = arrboolAsistencias[indexPath.row]
        cell.swtAsistencia.enabled = false
        
        return cell
    }
    
    @IBAction func unwindTomarListaBeneficiarios(unwindSegue: UIStoryboardSegue) {
        
        self.beneficiariosTableView.reloadData()
        
    }

}
