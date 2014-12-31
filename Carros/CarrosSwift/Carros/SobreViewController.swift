//
//  SobreViewController.swift
//  Carros
//
//  Created by Andre Furquin on 12/20/14.
//  Copyright (c) 2014 Andre Furquim. All rights reserved.
//

import UIKit
let URL_SOBRE = "http://livroiphone.com.br/carros/sobre.htm"

class SobreViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webview : UIWebView!
    @IBOutlet var progress : UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sobre"

    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // para a animação
        progress.stopAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        // Inicia animação do activity indicator
        self.progress.startAnimating()
        // Carrega o URL no WebView
        var url = NSURL(string: URL_SOBRE)!
        var request = NSURLRequest(URL: url)
        self.webview.loadRequest(request)
        // delegate
        self.webview.delegate = self
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }

}
