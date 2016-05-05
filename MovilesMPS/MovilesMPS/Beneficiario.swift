//
//  Beneficiario.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/4/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class Beneficiario: NSObject {

    
    var id_beneficiario : NSNumber!
    var nombre : String!
    var edad: NSNumber!
    var id_lugar : NSNumber!
    
    override init() {
        self.id_beneficiario = nil
        self.nombre = nil
        self.edad = nil
        self.id_lugar = nil
    }
    
    init(id_beneficiario : NSNumber, nombre : String, edad : NSNumber, id_lugar: NSNumber) {
        self.id_beneficiario = id_beneficiario
        self.nombre = nombre
        self.edad = edad
        self.id_lugar = id_lugar
    }
    
}
