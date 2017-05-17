//
//  ISOfertasTableViewController.swift
//  iSaldos
//
//  Created by formador on 10/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import PKHUD
import Kingfisher

class ISOfertasTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayOfertas = [ISPromocionesModel]()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: - Llamada
        llamadaOfertas()

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
        return arrayOfertas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCellOferta = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell

        let model = arrayOfertas[indexPath.row]
        
        customCellOferta.myNombreOferta.text = model.nombre
        customCellOferta.myFechaOferta.text = model.fechaFin
        customCellOferta.myInformacionOferta.text = model.masInformacion
        customCellOferta.myImporteOferta.text = model.importe
        
        customCellOferta.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string: getImagePath(CONSTANTES.LLAMADAS.OFERTAS,
                                                                                                              id: model.id,
                                                                                                              name: model.imagen))!),
                                                    placeholder: #imageLiteral(resourceName: "placeholder"),
                                                    options: nil,
                                                    progressBlock: nil,
                                                    completionHandler: nil)
        
        return customCellOferta
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showOfertaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOfertaSegue"{
            let detalleVC = segue.destination as! ISDetalleTableViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayOfertas[selectInd!]
            detalleVC.oferta = objInd
            
            do{
                let imageData = UIImage(data: try Data(contentsOf: URL(string: CONSTANTES.LLAMADAS.BASE_PHOTO_URL + (objInd.id)! + "/" + (objInd.imagen)!)!))
                detalleVC.detalleImagenData = imageData!
            }catch let error{
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    

    //MARK: - Utils
    func llamadaOfertas(){
        //instancia de la llamada (SINGLETON)
        let datosOfertas = ISParserPromociones()
        //Parametros en la llamada
        let idLocalidad = "11"
        let tipoOferta = CONSTANTES.LLAMADAS.OFERTAS
        let tipoParametro = CONSTANTES.LLAMADAS.PROMOCIONES_SERVICE
        HUD.show(.progress)
        firstly {
            return when(resolved: datosOfertas.getDatosPromociones(idLocalidad,
                                                                   idTipo: tipoOferta,
                                                                   idParametro: tipoParametro))
            }.then{_ in
                self.arrayOfertas = datosOfertas.getParserPromociones()
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
