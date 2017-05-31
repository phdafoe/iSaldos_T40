//
//  ISConfiguracionPerfilTableViewControler.swift
//  iSaldos
//
//  Created by formador on 29/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISConfiguracionPerfilTableViewControler: UITableViewController {
    
    //MARK: - Variables locales
    var fotoSeleccionada = false
    var objectIdFoto : String?
    
    //MARK: - IBOutlest
    @IBOutlet weak var myImagenPerfil: UIImageView!
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myNombreTF: UITextField!
    @IBOutlet weak var myApellidoTF: UITextField!
    @IBOutlet weak var myEmailTF: UITextField!
    @IBOutlet weak var myMovilTF: UITextField!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateDataIntoParse(_ sender: Any) {
        updateData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myActivityIndicator.isHidden = true
        
        myImagenPerfil.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickePhoto))
        myImagenPerfil.addGestureRecognizer(tapGR)
        
        datosFromParse()
    }
    
    //MARK: - Utils
    func datosFromParse(){
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno?[0]{
                    self.myNombreTF.text = objectUnoDes["nombre"] as? String
                    self.myApellidoTF.text = objectUnoDes["apellido"] as? String
                    self.myUsernameTF.text = PFUser.current()?.username
                    self.myPasswordTF.text = PFUser.current()?.password
                    self.myEmailTF.text = PFUser.current()?.email
                    self.myMovilTF.text = objectUnoDes["movil"] as? String
                    //2 consulta
                    let queryFotoPerfil = PFQuery(className: "ImageProfile")
                    queryFotoPerfil.whereKey("username", equalTo: (PFUser.current()?.username)!)
                    queryFotoPerfil.findObjectsInBackground(block: { (objectDos, errorDos) in
                        if errorDos == nil{
                            if let objectDosDes = objectDos?[0]{
                                let userImageFile = objectDosDes["imageProfile"] as! PFFile
                                self.objectIdFoto = objectDosDes.objectId
                                userImageFile.getDataInBackground(block: { (imageData, errorDataImagen) in
                                    if errorDataImagen == nil{
                                        if let imageDataDes = imageData{
                                            let imageDataFinal = UIImage(data: imageDataDes)
                                            self.myImagenPerfil.image = imageDataFinal
                                        }
                                    }
                                })
                            }
                        }
                    })
                }
            }
        })
    }
    
    
    func updateData(){
        let userData = PFUser.current()!
        userData["nombre"] = myNombreTF.text
        userData["apellido"] = myApellidoTF.text
        userData.email = myEmailTF.text
        userData["movil"] = myMovilTF.text
        
        myActivityIndicator.isHidden = false
        myActivityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        userData.saveInBackground { (exitoso, error) in
            
            self.myActivityIndicator.isHidden = false
            self.myActivityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if exitoso{
                self.updatePhoto()
            }else{
                print("Error")
            }
        }
    }
    
    func updatePhoto(){
        let imageProfile = PFObject(className: "ImageProfile")
        imageProfile.objectId = objectIdFoto
        let imageDataprofile = UIImageJPEGRepresentation(myImagenPerfil.image!, 0.5)
        let imageProfileFile = PFFile(name: "userImageProfile.jpg", data: imageDataprofile!)
        imageProfile["imageProfile"] = imageProfileFile
        imageProfile["username"] = PFUser.current()?.username
        imageProfile.saveInBackground(block: { (exitoso, error) in
            if error == nil{
                self.dismiss(animated: true, completion: nil)
                self.fotoSeleccionada = false
                self.myUsernameTF.text = ""
                self.myPasswordTF.text = ""
                self.myNombreTF.text = ""
                self.myApellidoTF.text = ""
                self.myEmailTF.text = ""
                self.myMovilTF.text = ""
                self.myImagenPerfil.image = #imageLiteral(resourceName: "placeholder")
            }else{
                
            }
        })
    }
    
}//TODO: - fin de la clase

extension ISConfiguracionPerfilTableViewControler : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func pickePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            muestraMenu()
        }else{
            muestraLibreriaFotos()
        }
    }
    
    func muestraMenu(){
        let alertVC = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        let tomaFotoAction = UIAlertAction(title: "Toma Foto", style: .default) { _ in
            self.muestraCamara()
        }
        let seleccionaLibreriaAction = UIAlertAction(title: "Selecciona de la Librería", style: .default) { _ in
            self.muestraLibreriaFotos()
        }
        alertVC.addAction(cancelAction)
        alertVC.addAction(tomaFotoAction)
        alertVC.addAction(seleccionaLibreriaAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func muestraCamara(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func muestraLibreriaFotos(){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let imageData = info[UIImagePickerControllerOriginalImage] as? UIImage{
            myImagenPerfil.image = imageData
            fotoSeleccionada = true
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
