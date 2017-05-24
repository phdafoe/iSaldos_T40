//
//  ISParserNasa.swift
//  iSaldos
//
//  Created by formador on 24/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import SwiftyJSON
import PromiseKit
import Alamofire

class ISParserNasa: NSObject {
    
    var jsonDataNasa : JSON?
    
    func getDatosPromociones() -> Promise<JSON>{
        let customRequest = URLRequest(url: URL(string: CONSTANTES.LLAMADAS.BASE_URL_NASA)!)
        //print(customRequest)
        return Alamofire.request(customRequest).responseJSON().then{(data) -> JSON in
            self.jsonDataNasa = JSON(data)
            //print(self.jsonDataNasa!)
            return self.jsonDataNasa!
        }
    }
    
    func getParserNasa() -> [ISNasaModel]{
        var arrayNasa = [ISNasaModel]()
        for c_objNasa in (jsonDataNasa?["news"])! {
            
            let nasaModel = ISNasaModel(pId: dimeString(c_objNasa.1, nombre: "Id"),
                                        pfecha: dimeString(c_objNasa.1, nombre: "fecha"),
                                        pDate: dimeString(c_objNasa.1, nombre: "date"),
                                        pExplanation: dimeString(c_objNasa.1, nombre: "explanation"),
                                        pHdurl: dimeString(c_objNasa.1, nombre: "hdurl"),
                                        pMedia_type: dimeString(c_objNasa.1, nombre: "media_type"),
                                        pService_version: dimeString(c_objNasa.1, nombre: "service_version"),
                                        pTitle: dimeString(c_objNasa.1, nombre: "title"),
                                        pUrl: dimeString(c_objNasa.1, nombre: "url"))
            arrayNasa.append(nasaModel)
        }
        return arrayNasa
    }
    
}





