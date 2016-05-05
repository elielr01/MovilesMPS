//
//  Lugar.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/4/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class Lugar: NSObject {
    
    var id_lugar : NSNumber!
    var nombre : String!
    var direccion: String!
    
    override init() {
        self.id_lugar = nil
        self.nombre = nil
        self.direccion = nil
        
    }
    
    init(id_lugar : NSNumber, nombre : String, direccion : String) {
        self.id_lugar = id_lugar
        self.nombre = nombre
        self.direccion = direccion
    }
}
