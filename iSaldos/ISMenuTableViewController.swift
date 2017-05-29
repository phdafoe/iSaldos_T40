//
//  ISMenuTableViewController.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import MessageUI

class ISMenuTableViewController: UITableViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImageProfile: UIImageView!
    @IBOutlet weak var myNombreProfile: UILabel!
    @IBOutlet weak var myApellidoProfile: UILabel!
    @IBOutlet weak var myEmailProfile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageProfile.layer.cornerRadius = myImageProfile.frame.width / 2
        myImageProfile.layer.borderColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myImageProfile.layer.borderWidth = 1
        myImageProfile.clipsToBounds = true
        
        dameInformacionParse()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            switch indexPath.row {
                case 2:
                    sendMessage()
                case 3:
                    showRateAlertInmediatly(self)
                case 4:
                    logout()
                default:
                    break
            }
        }
    }
    
    
    
    //MARK: - Utils
    func logout(){
        PFUser.logOutInBackground()
    }
    
    func sendMessage(){
        let mailComposeVC = configuredMailComposeVC()
        mailComposeVC.mailComposeDelegate = self
        if MFMailComposeViewController.canSendMail(){
            present(mailComposeVC,
                    animated: true,
                    completion: nil)
        }else{
            present(muestraVC("Atención",
                              messageData: "El mail no se enviado correctamente"),
                    animated: true,
                    completion: nil)
        }
    }
    
    func dameInformacionParse(){
        //1.primera consulta
        let queryUser = PFUser.query()
        queryUser?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryUser?.findObjectsInBackground(block: { (objectBusqueda, errorBusqueda) in
            if errorBusqueda == nil{
                if let objectData = objectBusqueda?[0]{
                    self.myNombreProfile.text = objectData["nombre"] as? String
                    self.myApellidoProfile.text = objectData["apellido"] as? String
                    self.myEmailProfile.text = objectData["email"] as? String
                    //2. segunda consulta
                    let queryFoto = PFQuery(className: "ImageProfile")
                    queryFoto.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFoto.findObjectsInBackground(block: { (objectBusquedaFoto, errorBusquedaFoto) in
                        if errorBusquedaFoto == nil{
                            if let objectBusquedaData = objectBusquedaFoto?[0]{
                                //3. obtencion de data para pintar la imagen del usuario
                                let userImageFile = objectBusquedaData["imageProfile"] as! PFFile
                                userImageFile.getDataInBackground(block: { (imageData, errorData) in
                                    if errorData == nil{
                                        if let data = imageData{
                                            let imageDataFinal = UIImage(data: data)
                                            self.myImageProfile.image = imageDataFinal
                                        }
                                    }else{
                                        print("no tenemos imagen")
                                    }
                                })
                            }
                            self.tableView.reloadData()
                        }
                    })
                }
            }
            self.tableView.reloadData()
        })
    }
    
    
}// fin de la clase

extension ISMenuTableViewController : MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        
        controller.dismiss(animated: true,
                           completion: nil)
        
    }
}













