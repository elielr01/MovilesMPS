//
//  AdminUser.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/3/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class AdminUser: NSObject {
    
    var id_admin : String!
    var nombre : String!
    var contra : String!
    
    override init() {
        self.id_admin = nil
        self.nombre = nil
        self.contra = nil
    }
    
    init(id_admin : String, nombre : String, contra : String) {
        self.id_admin = id_admin
        self.nombre = nombre
        self.contra = contra
    }

}
