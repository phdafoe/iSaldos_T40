//
//  ISNuevoPostTableViewController.swift
//  iSaldos
//
//  Created by formador on 29/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISNuevoPostTableViewController: UITableViewController {
    
    //MARK: - Variables
    var fotoSeleccionada = false
    let fechaHumana = Date()
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myFotoPerfil: UIImageView!
    @IBOutlet weak var myUsernamePerfil: UILabel!
    @IBOutlet weak var myNombre: UILabel!
    @IBOutlet weak var myApellido: UILabel!
    @IBOutlet weak var myFechaHumanaPerfil: UILabel!
    @IBOutlet weak var myDescripcionPost: UITextView!
    @IBOutlet weak var myImagenPost: UIImageView!
    
    
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        myDescripcionPost.delegate = self
        
        
        //bloque de la toolbar
        let barraFlexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        
        let colorWC = CONSTANTES.COLORES.BLANCO_TEXTO_NAV
        let colorBT = CONSTANTES.COLORES.GRIS_NAV_TAB
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        toolBar.barStyle = .blackOpaque
        toolBar.tintColor = colorWC
        toolBar.barTintColor = colorBT
        
        let customCamera = UIBarButtonItem(image: UIImage(named: "camara"),
                                           style: .done,
                                           target: self,
                                           action: #selector(pickerPhoto))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
