//
//  ISCanalSocialViewController.swift
//  iSaldos
//
//  Created by formador on 29/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISCanalSocialViewController: UIViewController {
    
    //MARK: - Variables
    var customRefreshControl : UIRefreshControl!
    var userModel = [UserPostImage]()
    var nombre : String?
    var apellido : String?
    var imagenPerfil : UIImage?
    
    //MARK: - IBOutlets
    @IBOutlet weak var myTableView : UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //refresh
        customRefreshControl = UIRefreshControl()
        customRefreshControl.addTarget(self,
                                       action: #selector(dataFromParse),
                                       for: .valueChanged)
        
        myTableView.addSubview(customRefreshControl)
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: "SRMiPerfilCustomCell", bundle: nil), forCellReuseIdentifier: "SRMiPerfilCustomCell")
        myTableView.register(UINib(nibName: "ISPostCustomCell", bundle: nil), forCellReuseIdentifier: "ISPostCustomCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
        informacionUsuario()
        dataFromParse()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        myTableView.reloadData()
        informacionUsuario()
    }
    
    
    
    //MARK: - Utils
    func informacionUsuario(){
        //1 consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno?[0]{
                    self.nombre = objectUnoDes["nombre"] as? String
                    self.apellido = objectUnoDes["apellido"] as? String
                    //2 consulta
                    let queryFotoPerfil = PFQuery(className: "ImageProfile")
                    queryFotoPerfil.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFotoPerfil.findObjectsInBackground(block: { (objectDos, errorDos) in
                        if errorDos == nil{
                            if let objectDosDes = objectDos?[0]{
                                let userImageFile = objectDosDes["imageProfile"] as! PFFile
                                userImageFile.getDataInBackground(block: { (imageData, errorDataImagen) in
                                    if errorDataImagen == nil{
                                        if let imageDataDes = imageData{
                                            let imageDataFinal = UIImage(data: imageDataDes)
                                            self.imagenPerfil = imageDataFinal
                                        }
                                    }
                                })
                            }
                            self.myTableView.reloadData()
                        }
                    })
                }
                self.myTableView.reloadData()
            }
        })
    }
    
    
    
    func dataFromParse(){
        
    }
    
    

}// FIN DE LA CLASE

extension ISCanalSocialViewController : UITableViewDelegate, UITableViewDataSource{
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return userModel.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let perfilCell = myTableView.dequeueReusableCell(withIdentifier: "SRMiPerfilCustomCell", for: indexPath) as! SRMiPerfilCustomCell
            
            perfilCell.myNombrePerfilUsuario.text = nombre
            perfilCell.myUsernameSportReviewLBL.text = apellido
            perfilCell.myFotoPerfilUsuario.image = imagenPerfil
            
            perfilCell.myBotonAjustesPerfilUsuario.addTarget(self,
                                                             action: #selector(muestraVCConfiguracion),
                                                             for: .touchUpInside)
            
            perfilCell.myUsuarioGenerales.addTarget(self,
                                                    action: #selector(muestraTablaUsuarios),
                                                    for: .touchUpInside)
            
            
    
            return perfilCell
        }else{
            let postCell = myTableView.dequeueReusableCell(withIdentifier: "ISPostCustomCell", for: indexPath) as! ISPostCustomCell
            
            return postCell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 305
        }else{
            return 450
        }
    }
    
    
    
    //MARK: - Utils
    func muestraVCConfiguracion(){
        let configuracionVC = storyboard?.instantiateViewController(withIdentifier: "ISConfiguracionPerfilTableViewControler") as!ISConfiguracionPerfilTableViewControler
        present(configuracionVC, animated: true, completion: nil)
    }
    
    func muestraTablaUsuarios(){
        let tablaUsuarioVC = storyboard?.instantiateViewController(withIdentifier: "ISUsuariosTableViewController") as! ISUsuariosTableViewController
        let navVC = UINavigationController(rootViewController: tablaUsuarioVC)
        present(navVC, animated: true, completion: nil)
    }
    
    

}


















