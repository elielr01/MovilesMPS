//
//  Proyecto.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/4/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class Proyecto: NSObject {
    
    var id_proyecto : NSNumber!
    var nombre : String!
    var descripcion: String!
    
    override init() {
        self.id_proyecto = nil
        self.nombre = nil
        self.descripcion = nil
    }
    
    init(id_proyecto : NSNumber, nombre : String, descripcion : String) {
        self.id_proyecto = id_proyecto
        self.nombre = nombre
        self.descripcion = descripcion
    }
}
