//
//  ISSignIn.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import Parse

class APISignIn: NSObject {
    
    var username : String?
    var password : String?
    
    init(pUsername : String, pPassword : String) {
        self.username = pUsername
        self.password = pPassword
    }
    
    func signInUser() throws{
        guard camposVacios() else{
            throw CustomError.campoVacio
        }
        guard validarDatosUsuario() else {
            throw CustomError.ingresoUsuarioError
        }
    }
    
    func camposVacios() -> Bool{
        
        return !(username?.isEmpty)! && !(password?.isEmpty)!
    }
    
    func validarDatosUsuario() -> Bool{
        do{
            try PFUser.logIn(withUsername: username!, password: password!)
        }catch let error{
            print("Error: \(error.localizedDescription)")
        }
        
        return (PFUser.current() != nil)
    }
    
    
    
    
    
    
    
    
}
