//
//  ISNasaModel.swift
//  iSaldos
//
//  Created by formador on 24/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISNasaModel: NSObject {
    
    
    var id : String?
    var fecha : String?
    var date : String?
    var explanation : String?
    var hdurl : String?
    var media_type : String?
    var service_version : String?
    var title : String?
    var url : String?
    
    
    init(pId : String, pfecha : String, pDate : String, pExplanation : String, pHdurl : String, pMedia_type : String, pService_version : String, pTitle : String, pUrl : String) {
        self.id = pId
        self.fecha = pfecha
        self.date = pDate
        self.explanation = pExplanation
        self.hdurl = pHdurl
        self.media_type = pMedia_type
        self.service_version = pService_version
        self.title = pTitle
        self.url = pUrl
        super.init()
    }
    

}
