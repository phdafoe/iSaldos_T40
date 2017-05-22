//
//  ISEnumerator.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

enum CustomError : Error {
    case campoVacio
    case emailInvalido
    case usuarioExistente
    case ingresoUsuarioError
}

extension CustomError : LocalizedError{
    var errorDescription: String{
        switch self {
        case .campoVacio:
            return "Ingrese todos los campos"
        case .emailInvalido:
            return "Correo invalido"
        case .usuarioExistente:
            return "ya existe esete usuario"
        case .ingresoUsuarioError:
            return "Datos incorrectos"
        }
    }
}
