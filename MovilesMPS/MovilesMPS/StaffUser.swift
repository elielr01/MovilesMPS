//
//  StaffUser.swift
//  MovilesMPS
//
//  Created by Elí Emmanuel on 5/3/16.
//  Copyright © 2016 Elí Emmanuel. All rights reserved.
//

import UIKit

class StaffUser: NSObject {
    
    var id_staff : String!
    var nombre : String!
    var contra : String!
    
    override init() {
        self.id_staff = nil
        self.nombre = nil
        self.contra = nil
    }
    
    init(id_staff : String, nombre : String, contra : String) {
        self.id_staff = id_staff
        self.nombre = nombre
        self.contra = contra
    }

}
