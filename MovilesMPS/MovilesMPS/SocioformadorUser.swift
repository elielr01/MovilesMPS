//
//  SocioformadorUser.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/3/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class SocioformadorUser: NSObject {
    
    var id_socioformador : String!
    var nombre : String!
    var contra : String!
    var id_proyecto_coordina : NSNumber!
    var id_lugar : NSNumber!
    
    override init() {
        self.id_socioformador = nil
        self.nombre = nil
        self.contra = nil
        self.id_proyecto_coordina = nil
        self.id_lugar = nil
    }
    
    init(id_socioformador : String, nombre : String, contra : String, id_proyecto_coordina : NSNumber, id_lugar : NSNumber) {
        self.id_socioformador = id_socioformador
        self.nombre = nombre
        self.contra = contra
        self.id_proyecto_coordina = id_proyecto_coordina
        self.id_lugar = id_lugar
    }

}
