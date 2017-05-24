//
//  ISDetalleCuponesTableViewController.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISDetalleCuponesTableViewController: UITableViewController {
    
    
    
    //MARK: - Variables locales
    var cupon : ISPromocionesModel?
    var detalleImagenData : UIImage?
    
    //MARK: - variables QR
    var qrData : String?
    var codeBarData : String?
    var qrCodeImage : CIImage?
    var imageGroupTag = 3
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var myImageCupon: UIImageView!
    @IBOutlet weak var myNombreCupon: UILabel!
    @IBOutlet weak var myFechaCupon: UILabel!
    @IBOutlet weak var myInformacionCupon: UILabel!
    @IBOutlet weak var myNombreAsociadoCupon: UILabel!
    @IBOutlet weak var myDescripcionAsociadoCupon: UILabel!
    @IBOutlet weak var myDireccionAsociadoCupon: UILabel!
    @IBOutlet weak var myTelefonoFijoAsociadoCupon: UIButton!
    @IBOutlet weak var myTelefonoMovilAsociadoCupon: UILabel!
    @IBOutlet weak var myWebAsociadoCupon: UIButton!
    @IBOutlet weak var myemailAsociadoCupon: UILabel!
    @IBOutlet weak var myIdActividadAsociadoCupon: UILabel!
    
    
    
    //MARK: - IBActions
    @IBAction func hacerLLamadaTelefonica(_ sender: Any) {
        let stringUno = myTelefonoFijoAsociadoCupon.titleLabel?.text
        let phoneUrl = URL(string: String(format: "telprompt:%@", stringUno!))!
        if UIApplication.shared.canOpenURL(phoneUrl){
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }else{
            present(muestraVC("Atención",
                              messageData: "numero de telefono no disponible"),
                    animated: true,
                    completion: nil)
        }
    }
    
    
    @IBAction func visitarPaginaWebAsociado(_ sender: Any) {
        let stringUno = myWebAsociadoCupon.titleLabel?.text
        let webVC = self.storyboard?.instantiateViewController(withIdentifier: "ISWebViewController") as! ISWebViewController
        webVC.urlWeb = stringUno
        present(webVC, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func creacionCB_QR(_ sender: Any) {
        
        let customBackground = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 2))
        customBackground.backgroundColor = CONSTANTES.COLORES.GRIS_NAV_TAB
        customBackground.alpha = 0.0
        customBackground.tag = imageGroupTag
        
        let custBackAnim = UIViewPropertyAnimator(duration: 0.3,
                                                  curve: .easeInOut) { 
                                                    customBackground.alpha = 0.5
                                                    self.view.addSubview(customBackground)
        }
        custBackAnim.startAnimation()
        custBackAnim.addCompletion { _ in
            self.muestraImagenCB_QR()
        }
        
        let tapGR = UITapGestureRecognizer(target: self,
                                           action: #selector(ocultaView(_:)))
        view.addGestureRecognizer(tapGR)
        
    }
    
    //MARK: - Utils
    func fromString(_ string : String) -> UIImage?{
        let data = string.data(using: String.Encoding.ascii)
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        filter!.setValue(data, forKey: "inputMessage")
        return UIImage(ciImage: filter!.outputImage!)
    }
    
    func ocultaView(_ gesto : UITapGestureRecognizer){
        for c_subview in self.view.subviews{
            if c_subview.tag == self.imageGroupTag{
                c_subview.removeFromSuperview()
            }
        }
    }
    
    func muestraImagenCB_QR(){
        if myIdActividadAsociadoCupon.text == qrData{
            let anchoImagen = self.view.frame.width / 1.3
            let altoImagen = self.view.frame.height / 3
            
            let imageView = UIImageView(frame: CGRect(x: (self.view.frame.width / 2 - anchoImagen / 2),
                                                      y: (self.view.frame.height / 2 - altoImagen / 2),
                                                      width: anchoImagen,
                                                      height: altoImagen))
            imageView.contentMode = .scaleAspectFit
            imageView.tag = imageGroupTag
            imageView.image = fromString(qrData!)
            self.view.addSubview(imageView)
            
        }else{
            //Aqui podeís decirle al usuario algo
        }
    }
    
    
    @IBAction func muestraActionSheetPersonalizado(_ sender: Any) {
        self.muestraStoryboard()
    }
    
    //MARK: - Utils
    func muestraStoryboard(){
        let stbData = UIStoryboard(name: "ActionSheetStoryboard", bundle: nil)
        let actionSheetVC = stbData.instantiateInitialViewController()
        actionSheetVC?.modalPresentationStyle = .overCurrentContext
        show(actionSheetVC as! UINavigationController, sender: self)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //gestion de la Altura dinamica de la tabla
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        myImageCupon.image = detalleImagenData
        myNombreCupon.text = cupon?.nombre
        myFechaCupon.text = cupon?.fechaFin
        myInformacionCupon.text = cupon?.masInformacion
        myNombreAsociadoCupon.text = cupon?.asociado?.nombre
        myDescripcionAsociadoCupon.text = cupon?.asociado?.descripcion
        
        myTelefonoFijoAsociadoCupon.setTitle(cupon?.asociado?.telefonoFijo, for: .normal)
        
        myTelefonoMovilAsociadoCupon.text = cupon?.asociado?.telefonoMovil
        
        myWebAsociadoCupon.setTitle(cupon?.asociado?.web, for: .normal)
        
        myemailAsociadoCupon.text = cupon?.asociado?.mail
        myIdActividadAsociadoCupon.text = cupon?.asociado?.idActividad
        
        qrData = cupon?.asociado?.idActividad
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    

}
