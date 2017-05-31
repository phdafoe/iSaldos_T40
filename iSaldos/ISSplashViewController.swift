//
//  ISSplashViewController.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse


class ISSplashViewController: UIViewController {
    
    //MARK: - Varibales locales
    var viewAnimator : UIViewPropertyAnimator!
    var desbloqueoGesto = Timer()
    var reachability = Reachability()
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myImageSplashSaldos: UIImageView!
    @IBOutlet weak var myComprobacionInternetImage: UIImageView!
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewAnimator = UIViewPropertyAnimator(duration: 1.0,
                                              curve: .easeInOut,
                                              animations: { 
                self.myImageSplashSaldos.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.desbloqueoGesto = Timer.scheduledTimer(timeInterval: 1.5,
                                                            target: self,
                                                            selector: #selector(self.manejadorAutomatico),
                                                            userInfo: nil,
                                                            repeats: false)
        })
        
        viewAnimator.startAnimation()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged(_:)),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability?.startNotifier()
        }catch{
            print("No es posible iniciar la notificacion")
        }
    }
    
    

    //MARK: - Utils
    func reachabilityChanged(_ noti : Notification){
        let reachability = noti.object as! Reachability
        if reachability.isReachable{
            if reachability.isReachableViaWiFi{
                print("via wifi")
            }else{
                print("via 3G")
            }
        }else{
            UIView.animate(withDuration: 0.2,
                           animations: { 
                            self.myImageSplashSaldos.layer.opacity = 1
            })
            print("No hay red")
        }
    }
    
    
    func manejadorAutomatico(){
        let logoAnimation = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .easeInOut) { 
                                                    self.myImageSplashSaldos.transform = CGAffineTransform(scaleX: 25, y: 25)
        }
        logoAnimation.startAnimation()
        logoAnimation.addCompletion { _ in
            self.beginApp()
        }
    }
    
    func beginApp(){
        if(customPrefes.string(forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL) != nil){
            if PFUser.current() == nil{
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! ISLoginViewController
                loginVC.modalTransitionStyle = .crossDissolve
                present(loginVC, animated: true, completion: nil)
            }else{
                let revealVC = self.storyboard?.instantiateViewController(withIdentifier: "RevealViewController") as! SWRevealViewController
                revealVC.modalTransitionStyle = .crossDissolve
                present(revealVC, animated: true, completion: nil)

            }
        }else{
            customPrefes.setValue("OK", forKey: CONSTANTES.USER_DEFAULT.VISTA_GALERIA_INICIAL)
            let galeriaVC = self.storyboard?.instantiateViewController(withIdentifier: "GaleriaTutorialViewController") as! ISGaleriaTutorialViewController
            galeriaVC.modalTransitionStyle = .crossDissolve
            present(galeriaVC, animated: true, completion: nil)
        }
        
    }
    
    
}
