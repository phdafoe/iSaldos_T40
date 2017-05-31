//
//  ISLoginViewController.swift
//  iSaldos
//
//  Created by formador on 8/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit
import Parse
import AVFoundation

class ISLoginViewController: UIViewController {
    
    //MARK: - Variables locales
    var player : AVPlayer!
    var splash : UIImageView?
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var myUsernameTF: UITextField!
    @IBOutlet weak var myPasswordTF: UITextField!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    @IBAction func doLoginACTION(_ sender: Any) {
        let sigIn = APISignIn(pUsername: myUsernameTF.text!,
                              pPassword: myPasswordTF.text!)
        
        do{
            try sigIn.signInUser()
            self.performSegue(withIdentifier: "jumpToViewContollerFromLogin", sender: self)
        }catch let error{
            present(muestraVC("Lo sentimos",
                              messageData: "\(error.localizedDescription)"),
                    animated: true,
                    completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        muestraVideo()
        myActivityIndicator.isHidden = true
    

        // Do any additional setup after loading the view.
    }

    //MARK: - Utils
    func muestraVideo(){
        //Videos
        let videoPath = Bundle.main.path(forResource: "Nike_iOS", ofType: "mp4")
        player = AVPlayer(url: URL(fileURLWithPath: videoPath!))
        player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        let playerlayer = AVPlayerLayer(player: player)
        playerlayer.frame = self.view.frame
        playerlayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.insertSublayer(playerlayer, at: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        player.seek(to: kCMTimeZero)
        player.play()
    }
    
    func playerItemDidReachEnd(){
        player.seek(to: kCMTimeZero)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
