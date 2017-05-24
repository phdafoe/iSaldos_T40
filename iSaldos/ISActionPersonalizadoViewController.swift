//
//  ISActionPersonalizadoViewController.swift
//  iSaldos
//
//  Created by formador on 24/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISActionPersonalizadoViewController: UIViewController {
    
    //MARK: - Variables locales
    var arrayRS = ["Facebook", "Twitter", "LinkedIn", "Meetic"]
    var arrayIMRS = ["like", "nation", "shape", "symbols"]
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myCustomView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var myCancelarBTN: UIButton!
    
    
    //MARK: - IBActions
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    
    //MARK: - LIFE VC
    override func viewDidLoad() {
        super.viewDidLoad()

        //Vista
        self.view.backgroundColor = UIColor.clear
        self.view.isOpaque = false
        
        //BNT
        myCustomView.layer.cornerRadius = 10
        myCancelarBTN.layer.cornerRadius = 5
        
        //SHADOW
        myCustomView.layer.masksToBounds = false
        myCustomView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        myCustomView.layer.shadowColor = CONSTANTES.COLORES.GRIS_NAV_TAB.cgColor
        myCustomView.layer.shadowRadius = 20.0
        myCustomView.layer.shadowOpacity = 1.0
        
        //TABLE
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true, completion: nil)
    }
    

    

}//FIN DE LA CLASE

extension ISActionPersonalizadoViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayRS.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let modelDataUno = arrayRS[indexPath.row]
        let modelDataDos = arrayIMRS[indexPath.row]
        
        cell.textLabel?.text = modelDataUno
        cell.detailTextLabel?.text = "\(Date())"
        cell.imageView?.image = UIImage(named: modelDataDos)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}







