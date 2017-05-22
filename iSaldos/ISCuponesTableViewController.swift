//
//  ISCuponesTableViewController.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import PKHUD
import Kingfisher

class ISCuponesTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayCupones = [ISPromocionesModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - Llamada
        llamadaCupones()
        
        //TODO:  - Menu superior Izq
        if revealViewController() != nil{
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rightViewRevealWidth = 150
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        //TODO: - Registro de Nib
        tableView.register(UINib(nibName: "ISOfertaCustomCell", bundle: nil), forCellReuseIdentifier: "ISOfertaCustomCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayCupones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCellCupones = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let model = arrayCupones[indexPath.row]
        
        customCellCupones.myNombreOferta.text = model.nombre
        customCellCupones.myFechaOferta.text = model.fechaFin
        customCellCupones.myInformacionOferta.text = model.masInformacion
        customCellCupones.myImporteOferta.text = model.importe
        
        customCellCupones.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath(CONSTANTES.LLAMADAS.CUPONES,
                                                                                                              id: model.id,
                                                                                                              name: model.imagen))!),
                                                    placeholder: #imageLiteral(resourceName: "placeholder"),
                                                    options: nil,
                                                    progressBlock: nil,
                                                    completionHandler: nil)
        
        return customCellCupones
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCuponSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCuponSegue"{
            let detalleVC = segue.destination as! ISDetalleCuponesTableViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayCupones[selectInd!]
            detalleVC.cupon = objInd
            
            do{
                let imageData = UIImage(data: try Data(contentsOf: URL(string: CONSTANTES.LLAMADAS.BASE_PHOTO_URL + (objInd.id)! + "/" + (objInd.imagen)!)!))
                detalleVC.detalleImagenData = imageData!
            }catch let error{
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
    //MARK: - Utils
    func llamadaCupones(){
        //instancia de la llamada (SINGLETON)
        let datosCupones = ISParserPromociones()
        //Parametros en la llamada
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.CUPONES
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        HUD.show(.progress)
        firstly {
            return when(resolved: datosCupones.getDatosPromociones(idLocalidad,
                                                                   idTipo: tipoOferta,
                                                                   idParametro: tipoParametro))
            }.then{_ in
                self.arrayCupones = datosCupones.getParserPromociones()
            }.then{_ in
                self.tableView.reloadData()
            }.then{_ in
                HUD.hide(afterDelay: 0)
            }.catch{error in
                self.present(muestraVC("Lo sentimos",
                                       messageData: error.localizedDescription),
                             animated: true,
                             completion: nil)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
