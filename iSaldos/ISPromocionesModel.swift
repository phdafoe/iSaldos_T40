//
//  ISPromocionesModel.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISPromocionesModel: NSObject {
    
    var id : String?
    var tipoPromocion : String?
    var nombre : String?
    var importe : String?
    var imagen : String?
    var fechaFin : String?
    var masInformacion : String?
    var asociado : ISAsociadoModel?
    
    init(pId : String,
         pTipoPromocion : String,
         pNombre : String,
         pImporte : String,
         pImagen : String,
         pFechaFin : String,
         pMasInformacion : String,
         pAsociado : ISAsociadoModel) {
        
        self.id = pId
        self.tipoPromocion = pTipoPromocion
        self.nombre = pNombre
        self.importe = pImporte
        self.importe = pImagen
        self.fechaFin = pFechaFin
        self.masInformacion = pMasInformacion
        self.asociado = pAsociado
        super.init()
        
    }
    
    
    
    
    
    
    
    
    

}
