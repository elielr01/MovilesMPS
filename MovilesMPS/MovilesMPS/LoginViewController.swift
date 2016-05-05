//
//  LoginViewController.swift
//  MovilesMPS
//


import UIKit



class LoginViewController: UIViewController {
    
    //Outlets de la vista
    
    @IBOutlet var txfUsuario: UITextField!
    @IBOutlet var txfContraseña: UITextField!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet var btnIniciarSesion: UIButton!
    
    
    //Atributos de la clase
    var staff : StaffUser!
    var admin : AdminUser!
    var socio : SocioformadorUser!
    
    var bAlert : Bool! //Se utiliza para saber si debo mostrar la alerta de login fallido
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Hago las esquinas redondas
        self.backgroundView.layer.cornerRadius = 14
        self.btnIniciarSesion.layer.cornerRadius = 8
        
        
        bAlert = false
        
        //Agrego esto para poder quitar el teclado con un toque
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Función a la que regresa cuando un usuario termina su sesión.
    @IBAction func unwindLogOut(unwindSegue: UIStoryboardSegue) {
        txfUsuario.text = ""
        txfContraseña.text = ""
    }
    
    
    //Función que valida las credenciales por cada tipo de usuario
    @IBAction func iniciarSesion(sender: UIButton) {
        
        
        //Intento en este orden iniciar sesión. Si la credencial es válida para alguno, se inicia sesión con ése tipo de usuario en específico
        //Si no, se muestra la alerta de login fallido
        self.tryLoginStaff()
        self.tryLoginAdmin()
        self.tryLoginSocio()
    }
    
    func tryLoginStaff() {
        
        //Creo el URL
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginStaff.php")!)
        request.HTTPMethod = "POST"
        
        //Agrego el cuerpo que es necesario para el POST
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //E inicio sesión.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          //verifico errores de red
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
                    self.bAlert=true
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.staff = StaffUser.init()
                    
                    self.staff.contra = user.valueForKey("contra") as! String
                    self.staff.id_staff = user.valueForKey("id_staff") as! String
                    self.staff.nombre = user.valueForKey("nombre") as! String
                    
                    //Esto se usa ya que quiero realizar una operación del main thread desde un thread hijo.
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
        
        //Creo el URL
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginAdmin.php")!)
        request.HTTPMethod = "POST"
        
        //Agrego el cuerpo que es necesario para el POST
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //E inicio sesión.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          //verifico errores de red
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
                    self.bAlert = true
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.admin = AdminUser.init()
                    
                    self.admin.contra = user.valueForKey("contra") as! String
                    self.admin.id_admin = user.valueForKey("id_admin") as! String
                    self.admin.nombre = user.valueForKey("nombre") as! String
                    
                    //Esto se usa ya que quiero realizar una operación del main thread desde un thread hijo.
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
        
        //Creo el URL
        let request = NSMutableURLRequest(URL: NSURL(string: "http://localhost/~elielr01/mps/loginSocio.php")!)
        request.HTTPMethod = "POST"
        
        //Agrego el cuerpo que es necesario para el POST
        let strUsername = txfUsuario.text
        let strPassword = txfContraseña.text
        
        let strPostBody = "username=\(strUsername!)&password=\(strPassword!)"
        
        request.HTTPBody = strPostBody.dataUsingEncoding(NSUTF8StringEncoding)
        
        //E inicio sesión.
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          //verifico errores de red
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
                    self.bAlert = true
                    
                    let jsonArray : NSMutableArray = json as! NSMutableArray
                    
                    let user = jsonArray[0]
                    
                    self.socio = SocioformadorUser.init()
                    
                    self.socio.contra = user.valueForKey("contra") as! String
                    self.socio.id_socioformador = user.valueForKey("id_socioformador") as! String
                    self.socio.nombre = user.valueForKey("nombre") as! String
                    self.socio.id_proyecto_coordina = Int.init(user.valueForKey("id_proyecto_coordina") as! String)
                    
                    //Esto se usa ya que quiero realizar una operación del main thread desde un thread hijo.
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("SocioSegue", sender: self)
                    }
                }
                else {
                    //Ya que este es la última validación de credenciales, si falla se manda la alerta.
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
    
    //Manda alerta si el login es fallido con las credenciales brindadas.
    func showAlert() {
        
        if (!bAlert!) {
            
            let alert = UIAlertController(title: "Error al iniciar sesión", message: "El usuario o contraseña no son correctos. Vuelva a intentarlo, por favor", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "Ok", style: .Cancel, handler: nil)
            
            alert.addAction(okAction)
            
            presentViewController(alert, animated: true, completion: nil)
        }
    }

    //Realiza la transición necesaria según el tipo de usuario que está haciendo sesión
    
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
    
    //función que quita el teclado cuando se da tap en alguna parte de la vista
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    

}

