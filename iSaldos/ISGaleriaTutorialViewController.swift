//
//  ISGaleriaTutorialViewController.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISGaleriaTutorialViewController: UIViewController {
    
    //MARK: - IBOutlest
    @IBOutlet weak var myScrollViewGaleria: UIScrollView!
    @IBOutlet weak var myPageControll: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anchoImagen = self.view.frame.width
        let altoImagen = self.view.frame.height
        
        for c_imagen in 0..<8{
            let imagenes = UIImageView(image: UIImage(named: String(format: "FOTO_%d.jpg", c_imagen)))
            imagenes.frame = CGRect(x: CGFloat(c_imagen) * anchoImagen, y: 0, width: anchoImagen, height: altoImagen)
            myScrollViewGaleria.addSubview(imagenes)
        }
        
        myScrollViewGaleria.delegate = self
        myScrollViewGaleria.contentSize = CGSize(width: 7 * anchoImagen, height: altoImagen)
        myScrollViewGaleria.isPagingEnabled = true
        myPageControll.numberOfPages = 7
        myPageControll.currentPage = 0
        
        // Do any additional setup after loading the view.
    }


}//FIN DE LA CLASE

extension ISGaleriaTutorialViewController : UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = myScrollViewGaleria.contentOffset.x / myScrollViewGaleria.frame.size.width
        myPageControll.currentPage = Int(page)
    }
}














