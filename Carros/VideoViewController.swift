//
//  VideoViewController.swift
//  Carros
//
//  Created by Andre Furquin on 1/2/15.
//  Copyright (c) 2015 Andre Furquim. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    var carro:Carro?
    @IBOutlet var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = self.carro!.url_video.url()
        // 1) Vídeo com WebView
        var request = NSURLRequest(URL: url)
        self.webView.loadRequest(request)
    }
}
