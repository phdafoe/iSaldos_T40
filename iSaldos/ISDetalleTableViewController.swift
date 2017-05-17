//
//  ISDetalleTableViewController.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import MapKit

class ISDetalleTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var oferta : ISPromocionesModel?
    var detalleImagenData : UIImage?
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var myImagenOferta: UIImageView!
    @IBOutlet weak var myNombreOferta: UILabel!
    @IBOutlet weak var myFechaOferta: UILabel!
    @IBOutlet weak var myInformacionOferta: UILabel!
    @IBOutlet weak var myNombreAsociado: UILabel!
    @IBOutlet weak var myDescripcionAsociado: UILabel!
    @IBOutlet weak var myDireccionAsociado: UILabel!
    @IBOutlet weak var myTelefonoFijoAsociado: UILabel!
    @IBOutlet weak var myMovilAsociado: UILabel!
    @IBOutlet weak var myWebAsociado: UILabel!
    @IBOutlet weak var myEmailAsociado: UILabel!
    @IBOutlet weak var myMapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - Altura general de las celdas
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        myImagenOferta.image = detalleImagenData
        myNombreOferta.text = oferta?.nombre
        myFechaOferta.text = oferta?.fechaFin
        myInformacionOferta.text = oferta?.masInformacion
        
        myNombreAsociado.text = oferta?.asociado?.nombre
        myDescripcionAsociado.text = oferta?.asociado?.descripcion
        myDireccionAsociado.text = oferta?.asociado?.direccion
        myTelefonoFijoAsociado.text = oferta?.asociado?.telefonoFijo
        myMovilAsociado.text = oferta?.asociado?.telefonoMovil
        myWebAsociado.text = oferta?.asociado?.web
        myEmailAsociado.text = oferta?.asociado?.mail
        
        //Mapa
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.352494, longitude: -3.809620),
                                        span: MKCoordinateSpan(latitudeDelta: 0.001,
                                                               longitudeDelta: 0.001))
        myMapView.setRegion(region, animated: true)
        
        let customAnnot = MKPointAnnotation()
        customAnnot.coordinate = CLLocationCoordinate2D(latitude: 40.352494, longitude: -3.809620)
        customAnnot.title = oferta?.nombre
        customAnnot.subtitle = oferta?.asociado?.direccion
        myMapView.addAnnotation(customAnnot)
        
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    

}
