//
//  ISNoticiaTableViewController.swift
//  iSaldos
//
//  Created by formador on 24/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISNoticiaTableViewController: UITableViewController {
    
    //MARK: - Variables locales
    var noticiaNasa : ISNasaModel?
    
    
    //MARK: - IBOUtlets
    
    @IBOutlet weak var myImageNasa: UIImageView!
    @IBOutlet weak var myNombreNasa: UILabel!
    @IBOutlet weak var myFechaNasa: UILabel!
    @IBOutlet weak var myInformacionNasa: UILabel!
    @IBOutlet weak var myDescripcionNasa: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let format = DateFormatter()
        format.dateFormat = "yyyyMMddHHmmss"

        //gestion de la Altura dinamica de la tabla
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //Setter informacion desde Modelo
        let urlImagen = URL(string: (noticiaNasa?.hdurl)!)
        do{
            let imageData = try Data(contentsOf: urlImagen!)
            myImageNasa.image = UIImage(data: imageData)
        }catch{
            print("\(noticiaNasa?.hdurl)")
        }
        myNombreNasa.text = noticiaNasa?.title
        myFechaNasa.text = fechaNasa(format.date(from: (noticiaNasa?.fecha)!)!)
        myInformacionNasa.text = noticiaNasa?.explanation
        myDescripcionNasa.text = noticiaNasa?.explanation
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1{
            return UITableViewAutomaticDimension
        }
        return super.tableView(tableView, heightForRowAt: indexPath)
    }

}
