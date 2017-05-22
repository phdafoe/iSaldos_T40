//
//  ISWebViewController.swift
//  iSaldos
//
//  Created by formador on 22/5/17.
//  Copyright © 2017 icologic. All rights reserved.
//

import UIKit

class ISWebViewController: UIViewController {
    
    //MARK: - Varibales locales
    var urlWeb : String?
    
    
    //MARK: - IBOutlet
    @IBOutlet weak var myWebView: UIWebView!
    @IBOutlet weak var myActiviInd: UIActivityIndicatorView!
    
    
    @IBAction func hideVC(_ sender: Any) {
        dismiss(animated: true,
                completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlData = URL(string: "http://" + urlWeb!)
        let urlDataRequest = URLRequest(url: urlData!)
        myWebView.loadRequest(urlDataRequest)
        
        myActiviInd.isHidden = true
        myWebView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}

extension ISWebViewController : UIWebViewDelegate{

    func webViewDidStartLoad(_ webView: UIWebView) {
        myActiviInd.isHidden = false
        myActiviInd.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActiviInd.isHidden = true
        myActiviInd.stopAnimating()
    }
    
    
}










