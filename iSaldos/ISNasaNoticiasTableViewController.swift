//
//  ISNasaNoticiasTableViewController.swift
//  iSaldos
//
//  Created by formador on 24/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import PromiseKit
import PKHUD
import Kingfisher


class ISNasaNoticiasTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var arrayNoticiasNasa = [ISNasaModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO: - Llamada
        llamadaNoticiasNasa()
        
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
        return arrayNoticiasNasa.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let customCellCupones = tableView.dequeueReusableCell(withIdentifier: "ISOfertaCustomCell", for: indexPath) as! ISOfertaCustomCell
        
        let model = arrayNoticiasNasa[indexPath.row]
        
        customCellCupones.myNombreOferta.text = model.title
        customCellCupones.myFechaOferta.text = model.fecha
        customCellCupones.myInformacionOferta.text = model.explanation
        
        customCellCupones.myImagenOferta.kf.setImage(with: ImageResource(downloadURL: URL(string:model.url!)!),
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
        performSegue(withIdentifier: "showNasaSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNasaSegue"{
            let detalleVC = segue.destination as! ISNoticiaTableViewController
            let selectInd = tableView.indexPathForSelectedRow?.row
            let objInd = arrayNoticiasNasa[selectInd!]
            detalleVC.noticiaNasa = objInd
        }
    }
    
    //MARK: - Utils
    func llamadaNoticiasNasa(){
        //instancia de la llamada (SINGLETON)
        let datosNasa = ISParserNasa()
        HUD.show(.progress)
        firstly {
            return when(resolved: datosNasa.getDatosPromociones())
            }.then{_ in
                self.arrayNoticiasNasa = datosNasa.getParserNasa()
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
