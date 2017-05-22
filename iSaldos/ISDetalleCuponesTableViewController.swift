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
        
        
    }
    
    
    @IBAction func visitarPaginaWebAsociado(_ sender: Any) {
        
        
        
    }
    
    @IBAction func creacionCB_QR(_ sender: Any) {
        
        
        
    }
    
    
    @IBAction func muestraActionSheetPersonalizado(_ sender: Any) {
        
        
        
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
        
        //qrData =
        
        
        
        
        

        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    

}
