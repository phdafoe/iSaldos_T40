//
//  APIUTILS.swift
//  iSaldos
//
//  Created by formador on 3/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation

let CONSTANTES = Constantes()

struct Constantes {
    let COLORES = Colores()
    let LLAMADAS = LLamadas()
    let USER_DEFAULT = CustomUserDefault()
    let PARSE_DATA = ParseData()
}

struct Colores {
    let GRIS_NAV_TAB = #colorLiteral(red: 0.2784313725, green: 0.2784313725, blue: 0.2784313725, alpha: 1)
    let BLANCO_TEXTO_NAV = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

struct LLamadas {
    let OFERTAS = "oferta"
    let CUPONES = "cupones"
    let PROMOCIONES_SERVICE = "promociones"
    
    let BASE_PHOTO_URL = "http://app.clubsinergias.es/uploads/promociones/"
    let BASE_URL = "http://app.clubsinergias.es/api_comercios.php?"
    let BASE_URL_ID_CLIENTE = "http://app.clubsinergias.es/api_comercios.php?idcliente="
    let BASE_ID_LOCALIDAD = "idlocalidad="
    let BASE_ID_P = "&p="
    let BASE_ID_TIPO = "&tipo="
    
}

struct ParseData {
    let NOMBRE_TABLA_IMAGEN = "ImageProfile"
    let IMAGE_URL = "imagenFile"
    let USERNAME_PARSE = "username"
}

struct CustomUserDefault {
    let VISTA_GALERIA_INICIAL = "vistaGaleriaInicial"
}













