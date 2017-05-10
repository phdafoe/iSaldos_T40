//
//  ISParserPromociones.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ISParserPromociones: NSObject {
    
    //http://app.clubsinergias.es/api_comercios.php?idlocalidad=11&tipo=oferta&p=promociones
    
    var jsonDataPromociones : JSON?
    
    func getDatosPromociones(_ idLocalidad : String, idTipo : String, idParametro : String) -> Promise<JSON>{
        
        let customRequest = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_URL + CONSTANTES.LLAMADAS.BASE_ID_LOCALIDAD + idLocalidad + CONSTANTES.LLAMADAS.BASE_ID_TIPO + idTipo + CONSTANTES.LLAMADAS.BASE_ID_P + idParametro)!)
            //print(customRequest)
        return Alamofire.request(customRequest).responseJSON().then{(data) -> JSON in
            self.jsonDataPromociones = JSON(data)
            //print(self.jsonDataPromociones!)
            return self.jsonDataPromociones!
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
