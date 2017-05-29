//
//  UserPostImage.swift
//  iSaldos
//
//  Created by formador on 29/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class UserPostImage: NSObject {
    
    var nombre : String?
    var apellido : String?
    var username : String?
    var imageProfile : PFFile?
    var imagePost : PFFile?
    var fechaCreacion : Date?
    var descripcionPost : String?
    
    init(pNombre : String, pApellido : String, pUsername : String, pImageProfile : PFFile, pImagePost : PFFile, pfechaCreacion : Date, pDescripcionPost : String) {
        
        self.nombre = pNombre
        self.apellido = pApellido
        self.username = pUsername
        self.imageProfile = pImageProfile
        self.imagePost = pImagePost
        self.fechaCreacion = pfechaCreacion
        self.descripcionPost = pDescripcionPost
        super.init()
    }
    
    
}
