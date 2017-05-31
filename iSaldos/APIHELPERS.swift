//
//  APIHELPERS.swift
//  iSaldos
//
//  Created by formador on 3/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import Foundation
import SwiftyJSON
import MessageUI

let customPrefes = UserDefaults.standard


func muestraVC(_ titleData : String, messageData : String) -> UIAlertController{
    let alertVC = UIAlertController(title: titleData, message: messageData, preferredStyle: .alert)
    alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    return alertVC
}

func configuredMailComposeVC() -> MFMailComposeViewController{
    let mailCompose = MFMailComposeViewController()
    mailCompose.setToRecipients([""])
    mailCompose.setSubject("Ayuda con la app de iOS")
    mailCompose.setMessageBody("Escriba aqui si mensaje", isHTML: false)
    return mailCompose
}

func dimeString(_ json : JSON, nombre : String) -> String{
    if let stringResult = json[nombre].string{
        return stringResult
    }else{
        return ""
    }
}


func getImagePath(_ type: String, id: String!, name: String!) -> String{
    return CONSTANTES.LLAMADAS.BASE_PHOTO_URL + id + "/" + name
}


public func fechaNasa(_ fecha : Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yyyy"
    dateFormatter.locale = Locale(identifier: "es_ES")
    return dateFormatter.string(from: fecha)
}

public func dameFecha(_ fecha : Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM"
    dateFormatter.locale = Locale(identifier: "es_ES")
    return dateFormatter.string(from: fecha)
}



















