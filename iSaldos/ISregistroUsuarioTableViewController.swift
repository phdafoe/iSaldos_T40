//
//  ISregistroUsuarioTableViewController.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

class ISregistroUsuarioTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var fotoSeleccionada = false
    
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
    
    
    @IBAction func doSignUpACTION(_ sender: Any) {
        
        var errorInicial = ""
        
        if myImagenPerfil.image == nil || myUsernameTF.text == "" || myPasswordTF.text == "" || myNombreTF.text == "" || myApellidoTF.text == "" || myEmailTF.text == ""{
            
            errorInicial = "Estimado usuario por favor rellene todos los campos"
            
        }else{
            //aqui registramos el usuarios
            let newUser = PFUser()
            newUser.username = myUsernameTF.text
            newUser.password = myPasswordTF.text
            newUser.email = myEmailTF.text
            newUser["nombre"] = myNombreTF.text
            newUser["apellido"] = myApellidoTF.text
            newUser["movil"] = myMovilTF.text
            
            myActivityIndicator.isHidden = false
            myActivityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            newUser.signUpInBackground(block: { (exitoso, errorRegistro) in
                self.myActivityIndicator.isHidden = true
                self.myActivityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if errorRegistro != nil{
                    self.present(muestraVC("Atención", messageData: "Error al registrar"), animated: true, completion: nil)
                }else{
                    self.signUpWithPhoto()
                    self.performSegue(withIdentifier: "jumpToViewContoller", sender: self)
                }
            })
            
        }
        
        if errorInicial != ""{
            present(muestraVC("Atención",
                              messageData: errorInicial),
                    animated: true,
                    completion: nil)
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        myImagenPerfil.isUserInteractionEnabled = true
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(pickePhoto))
        myImagenPerfil.addGestureRecognizer(tapGR)
    }
    
    //MARK: - Utils
    func signUpWithPhoto(){
        if fotoSeleccionada{
            let imageProfile = PFObject(className: "ImageProfile")
            let imageDataprofile = UIImageJPEGRepresentation(myImagenPerfil.image!, 0.5)
            let imageProfileFile = PFFile(name: "userImageProfile.jpg", data: imageDataprofile!)
            imageProfile["imageProfile"] = imageProfileFile
            imageProfile["username"] = PFUser.current()?.username
            imageProfile.saveInBackground()
            self.fotoSeleccionada = false
            self.myUsernameTF.text = ""
            self.myPasswordTF.text = ""
            self.myNombreTF.text = ""
            self.myApellidoTF.text = ""
            self.myEmailTF.text = ""
            self.myMovilTF.text = ""
            self.myImagenPerfil.image = #imageLiteral(resourceName: "placeholderPerson")
        }else{
            self.present(muestraVC("Atención", messageData: "Foto no seleccionada"), animated: true, completion: nil)
        }
    }

}//TODO: - fin de la clase

extension ISregistroUsuarioTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
