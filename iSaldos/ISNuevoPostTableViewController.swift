//
//  ISNuevoPostTableViewController.swift
//  iSaldos
//
//  Created by formador on 29/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse

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
                                           action: #selector(self.pickePhoto))
        let salvarDatos = UIBarButtonItem(title: "Salvar",
                                          style: .plain,
                                          target: self,
                                          action: #selector(self.salvarDatos))
        
        toolBar.items = [customCamera, barraFlexible, salvarDatos]
        myDescripcionPost.inputAccessoryView = toolBar

        let customDateFormatter = DateFormatter()
        customDateFormatter.dateStyle = .medium
        myFechaHumanaPerfil.text = "fecha" + " " + customDateFormatter.string(from: fechaHumana)
        
        let gestRecog = UITapGestureRecognizer(target: self,
                                               action: #selector(self.bajarTeclado))
        tableView.addGestureRecognizer(gestRecog)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myDescripcionPost.becomeFirstResponder()
        dameInformacionPerfil()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    

    //MARK: - Utils
    func salvarDatos(){
        
        var errorData = ""
        
        if !fotoSeleccionada && myDescripcionPost.text == "¿Qué está pasando?" || myDescripcionPost.text.isEmpty{
            errorData = "por favor elige una foto de la galeria y escribe un texto"
        }
        
        if errorData != ""{
            present(muestraVC("Error de datos",
                              messageData: errorData),
                    animated: true,
                    completion: nil)
        }else{
            let postImage = PFObject(className: "PostImageNetwork")
            let imageData = UIImageJPEGRepresentation(self.myImagenPost.image!, 0.2)
            let imageFile = PFFile(name: "imagePost.jpg", data: imageData!)
            let imageDataPerfil = UIImageJPEGRepresentation(self.myFotoPerfil.image!, 0.1)
            let imageFilePerfil = PFFile(name: "imagePerfil.jpg", data: imageDataPerfil!)
            
            postImage["imageFilePost"] = imageFile
            postImage["imageFilePerfil"] = imageFilePerfil
            postImage["username"] = PFUser.current()?.username
            postImage["descripcionImagen"] = myDescripcionPost.text
            postImage["nombre"] = myNombre.text
            postImage["apellido"] = myApellido.text
            
            UIApplication.shared.beginIgnoringInteractionEvents()
            postImage.saveInBackground(block: { (subidaExitosa, error) in
                
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if subidaExitosa{
                    self.dismiss(animated: true, completion: nil)
                }else{
                    self.present(muestraVC("Error de subida", messageData: "problemas con la subida de datos"),
                                 animated: true,
                                 completion: nil)
                }
                self.fotoSeleccionada = false
                self.myDescripcionPost.text = ""
                self.myImagenPost.image = #imageLiteral(resourceName: "placeholder")
            })
        }
    }
    
    func bajarTeclado(){
        myDescripcionPost.resignFirstResponder()
    }

    func dameInformacionPerfil(){
        
        //1 consulta
        let queryData = PFUser.query()
        queryData?.whereKey("username", equalTo: (PFUser.current()?.username)!)
        queryData?.findObjectsInBackground(block: { (objectUno, errorUno) in
            if errorUno == nil{
                if let objectUnoDes = objectUno?[0]{
                    
                    self.myNombre.text = objectUnoDes["nombre"] as? String
                    self.myApellido.text = objectUnoDes["apellido"] as? String
                    self.myUsernamePerfil.text = "@" + (PFUser.current()?.username)!
                    
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
                                            self.myFotoPerfil.image = imageDataFinal
                                        }
                                    }
                                })
                            }
                            self.tableView.reloadData()
                        }
                    })
                }
                self.tableView.reloadData()
            }
        })
    }
    

}//TODO: - fin de la clase

extension ISNuevoPostTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
            myImagenPost.image = imageData
            if myImagenPost.image != nil{
               fotoSeleccionada = true
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}//FIN DE LA EXTENSION


extension ISNuevoPostTableViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray{
            textView.text = nil
            textView.textColor = UIColor.black
            self.navigationController?.setToolbarHidden(true, animated: true)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty{
            textView.text = "¿Qué está pasando?"
            textView.textColor = UIColor.lightGray
            self.navigationController?.setToolbarHidden(false, animated: true)
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }
}









